from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, DateTime, DECIMAL

# 生成orm基类
Base = declarative_base()


class product(Base):
    __tablename__ = 'db_product'  # 表名
    id = Column(Integer, primary_key=True)
    keys_id = Column(Integer)
    shop_id = Column(String(255))
    search_id = Column(Integer)
    item_id = Column(String(255))
    cat_id = Column(String(255))
    ads_id = Column(Integer)
    label_ids = Column(String(255))
    campaign_id = Column(Integer)
    product_name = Column(String(255))
    brand = Column(String(255))
    price_min = Column(Integer)
    price_max = Column(Integer)
    ads_keyword = Column(String(255))
    free_shipping = Column(String(255))
    is_preferred_plus_seller = Column(String(255))
    rating_star = Column(DECIMAL(1, 3))
    cmt_count = Column(Integer)
    view_count = Column(Integer)
    liked_count = Column(Integer)
    shop_location = Column(String(255))
    flag = Column(String(255))
    sold = Column(Integer)
    historical_sold = Column(Integer)
    ranking = Column(Integer)
    create_time = Column(DateTime)
    serach_time = Column(DateTime)
