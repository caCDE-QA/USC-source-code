from sqlalchemy.dialects.postgresql import INTERVAL
#from sqlalchemy.dialects import postgres
from sqlalchemy.dialects import postgresql
from sqlalchemy.types import TypeDecorator
import HQMFUtil
import sqlparse

class HQMFIntervalType(TypeDecorator):
    impl = INTERVAL

    def process_literal_param(self, value, dialect):
        return "'" + str(value) + "'"

class HQMFIntervalUtil:
    @staticmethod
    def get_dialect():
#        return postgres.dialect()
        return postgresql.dialect()

class HQMFResultUtil:
    def __init__(self, schema, cohort_schema=None):
        self.schema = schema
        self.cohort_schema = cohort_schema
    
    def create_view(self, view_name, query, pretty=True):
        if pretty:
            return("create or replace view " +
                   self.schema + "." + view_name +
                   " as " +
                   sqlparse.format(HQMFUtil.sql_to_string(query), reindent=True) +
                   ";")
        else:
            return("create or replace view " +
                   self.schema + "." + view_name +
                   " as " +
                   HQMFUtil.sql_to_string(query) +
                   ";")

    def get_schema(self):
        return self.schema

    def get_cohort_schema(self):
        return self.cohort_schema
              
    def qualified_artifact_name(self, name):
        return(self.schema + "." + name)

    def statement_terminator(self):
        return(';\n')
