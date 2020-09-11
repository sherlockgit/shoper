from encodings import unicode_escape

import requests

# 首页搜索

def index_spider():

    url = 'https://xiapi.xiapibuy.com/api/v2/search_items?by=relevancy&keyword=水杯&limit=50&newest=0&order=desc&page_type=search&version=2'
    print('relevancy:综合排名,ctime：最新,sales：最热销,price:价格')
    by = input()
    print('关键字')
    keyword = input()
    print('每页条数')
    limit = input()
    print('第几条开始')
    newest = input()
    print('asc:低到高,desc:高到低')
    order = input()
    page_type = 'search'
    version = 2
    params = {"by": by,
              "keyword": keyword,
              "limit": limit,
              "newest": newest,
              "order": order,
              "page_type": page_type,
              "version": version}
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0"}
    res = get(url, params, headers)
    con = res.text
    print(con)

# get请求

def get(url,params,header):
    res = requests.get(url=url, params=params, headers=header)
    return res


if __name__ == '__main__':
    index_spider()


