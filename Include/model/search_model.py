from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, DateTime, DECIMAL

# 生成orm基类
Base = declarative_base()


class search(Base):
    __tablename__ = 'db_search'  # 表名
    id = Column(Integer, primary_key=True)
    key_id = Column(Integer)
    key = Column(String(255))
    order_type = Column(String(255))
    search_type = Column(String(255))
    total_count = Column(Integer)
    total_ads_count = Column(Integer)
    ori_totalCount = Column(Integer)
    suggestion_algorithm = Column(Integer)
    create_time = Column(DateTime)
