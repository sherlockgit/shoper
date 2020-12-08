import math
import time
from datetime import datetime


import jieba
import json
import requests
import pymysql
import re

# 首页搜索
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from Include.model import keys_model, search_model, product_model, word_model
from Include.model.keys_model import keys
from Include.utils import check_legal


def index_spider():
    tw_url = 'https://xiapi.xiapibuy.com/api/v2/search_items'
    ph_prl = 'https://ph.xiapibuy.com/api/v2/search_items'

    print('输入查询站点：1：台湾；2：菲律宾；')
    site = input()
    if site == '1':
        url = tw_url
    elif site == '2':
        url = ph_prl

    print('输入查询方式：1:综合排名;2：最新;3：最热销;4:价格')
    by = input()

    if by == 1:
        by = 'relevancy'
        search_type = '综合'
    elif by == 2:
        by = 'ctime'
        search_type = '最新'
    elif by == 3:
        by = 'sales'
        search_type = '最热销'
    elif by == 4:
        by = 'price'
        search_type = '价格'
    else:
        by = 'relevancy'
        search_type = '综合'

    print('输入关键字：')
    keyword = input()

    print('输入查询总条数：')
    total_count = int(input())
    if total_count > 300:
        total_count = 300

    print('输入排序方式：2:低到高;1:高到低')
    order = input()
    if order == 1:
        order = 'desc'
        order_type = '高到低'
    elif order == 2:
        order = 'asc'
        order_type = '低到高'
    else:
        order = 'desc'
        order_type = '高到低'

    limit = 50
    page_type = 'search'
    version = 2
    ranking = 0
    ranking_ads = 0
    base_massage = False
    session = get_session()
    key_id = None
    search_id = None
    word_dict = dict()
    for newest in range(0, math.ceil(total_count / 50)):
        params = {"by": by,
                  "keyword": keyword,
                  "limit": limit,
                  "newest": newest*50,
                  "order": order,
                  "page_type": page_type,
                  "version": version}
        headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0"}
        res = get(url, params, headers)
        con = res.text
        text = json.loads(con)

        if not base_massage:
            # 构建关键字
            key1 = session.query(keys).filter(keys.key == keyword and keys.site == 1).all()

            if len(key1) == 0:
                keys1 = keys_model.keys(
                    key=keyword,
                    site=site
                )
                session.add(keys1)
                session.flush()
                key_id = keys1.id
            else:
                key_id = key1[0].id


            # 构建搜索
            search = search_model.search(
                key_id=key_id,
                key=keyword,
                order_type=order_type,
                search_type=search_type,
                total_count=text.get('total_count'),
                total_ads_count=text.get('total_ads_count'),
                ori_totalCount=text.get('query_rewrite').get('ori_totalCount'),
                suggestion_algorithm=text.get('suggestion_algorithm'),
                create_time=datetime.now()
            )
            session.add(search)
            session.flush()
            search_id = search.id
        base_massage = True



        # 商品信息
        for i in text.get('items'):
            if i.get('ads_keyword') is not None:
                ranking = ranking+1
                rank = ranking
            else:
                ranking_ads = ranking_ads+1
                rank = ranking_ads

            product = product_model.product(
                keys_id=key_id,
                shop_id=i.get('shopid'),
                search_id=search_id,
                item_id=i.get('itemid'),
                cat_id=i.get('catid'),
                ads_id=i.get('adsid'),
                label_ids=",".join(str(x) for x in i.get('label_ids')),
                campaign_id=i.get('campaignid'),
                product_name=i.get('name'),
                brand=i.get('brand'),
                price_min=i.get('price_min'),
                price_max=i.get('price_max'),
                ads_keyword=i.get('ads_keyword'),
                free_shipping=i.get('show_free_shipping'),
                is_preferred_plus_seller=i.get('is_preferred_plus_seller'),
                rating_star=i.get('item_rating').get('rating_star'),
                cmt_count=i.get('cmt_count'),
                view_count=i.get('view_count'),
                liked_count=i.get('liked_count'),
                shop_location=i.get('shop_location'),
                flag=i.get('flag'),
                sold=i.get('sold'),
                historical_sold=i.get('historical_sold'),
                ranking=rank,
                create_time=datetime.fromtimestamp(i.get('ctime')),
                serach_time=datetime.now()
            )

            # 分词
            words = list(jieba.cut(i.get('name'), cut_all=False))
            for word in words:
                if not check_legal.is_legal(word):
                    continue
                if word_dict.get(word) is None:
                    word_m = word_model.word(
                        search_id=search_id,
                        key=keyword,
                        word=word,
                        num=1,
                        sold=i.get('sold'),
                        history_sold=i.get('historical_sold'),
                        view_count=i.get('view_count'),
                        create_time=datetime.now()
                    )
                    word_dict[word] = word_m
                else:
                    word_dict[word].num = word_dict[word].num+1
                    word_dict[word].sold = word_dict[word].sold+i.get('sold')
                    word_dict[word].history_sold = word_dict[word].history_sold + i.get('historical_sold')
                    word_dict[word].view_count = word_dict[word].view_count + i.get('view_count')

            session.add(product)
        print('完成准备下一波')
        time.sleep(5)
    for words in word_dict:
        session.add(word_dict[words])
    session.commit()
    print('*****************成功********************')


def get(url, params, header):  # get请求
    res = requests.get(url=url, params=params, headers=header,verify=False)
    return res


def get_session():
    engine = create_engine("mysql+pymysql://shoper:123456@localhost/shoper",
                           encoding='utf-8')
    session_class = sessionmaker(bind=engine)  # 创建与数据库的会话session class ,注意,这里返回给session的是个class,不是实例
    session = session_class()  # 生成session实例
    return session


if __name__ == '__main__':
     index_spider()
