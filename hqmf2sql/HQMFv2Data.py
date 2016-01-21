import json
from HQMFUtil import *
from sqlalchemy.sql import select
from sqlalchemy.sql.expression import subquery, exists
from abc import ABCMeta, abstractmethod
from datetime import datetime
HQMF='hqmf'
VALUESET='valueset'

class TemporalReferrant(metaclass=ABCMeta):
    def __init__(self):
        pass

    def get_start_time(self, outer=True):
        raise NotImplementedError

    def get_end_time(self, outer=True):
        raise NotImplementedError


