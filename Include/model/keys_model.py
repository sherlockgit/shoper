from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, text, TIMESTAMP

# 生成orm基类
Base = declarative_base()

class keys(Base):
    __tablename__ = 'db_keys'  # 表名
    id = Column(Integer, primary_key=True)
    key = Column(String(255))
    site = Column(Integer)