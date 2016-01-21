from sqlalchemy import *
from sqlalchemy.sql.functions import *
from sqlalchemy.types import Date
from HQMFv2SqlGenerator import TemporalFunctions
from HQMFUtil import sql_to_string
import sqlparse

if __name__ == '__main__':
    metadata = MetaData()
    t = Table('t', metadata,
                Column('lhs', Date),
                Column('rhs', Date),
                )

    print(sqlparse.format(sql_to_string(TemporalFunctions.year_delta(t.c.lhs, t.c.rhs))))
    print(";")
    print(sqlparse.format(sql_to_string(TemporalFunctions.month_delta(t.c.lhs, t.c.rhs))))
    print(";")
    print(sqlparse.format(sql_to_string(TemporalFunctions.week_delta(t.c.lhs, t.c.rhs))))
    print(";")
    print(sqlparse.format(sql_to_string(TemporalFunctions.day_delta(t.c.lhs, t.c.rhs))))
    print(";")

