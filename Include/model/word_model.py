from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, DateTime, DECIMAL

# 生成orm基类
Base = declarative_base()


class word(Base):
    __tablename__ = 'db_word'  # 表名
    id = Column(Integer, primary_key=True)
    search_id = Column(Integer)
    key = Column(String(255))
    word = Column(String(255))
    num = Column(Integer)
    sold = Column(Integer)
    history_sold = Column(Integer)
    view_count = Column(Integer)
    create_time = Column(DateTime)
