import json
from HQMFUtil import *
from sqlalchemy.sql import select
from sqlalchemy.sql.expression import subquery, exists
from abc import abstractmethod
from collections.abc import Mapping, MutableMapping
from collections import UserDict
from datetime import datetime
from io import StringIO
HQMF='hqmf'
VALUESET='valueset'


#class DictLike(MutableMapping):
class DictLike(dict):
    @abstractmethod
    def _base_mapping(self):
        raise NotImplementedError("no base mapping defined")

    def __getitem__(self, key):
        return self._base_mapping().__getitem__(key)
    
    def __iter__(self):
        return self._base_mapping().__iter__()

    def __len__(self):
        return self._base_mapping().__len__()

    def __setitem__(self, key, val):
        return self._base_mapping().__setitem__(key, val)

    def __delitem__(self, key):
        return self._base_mapping().__delitem__(key)

    def __str__(self):
        b = StringIO()
        b.write('{')
        for k in self.keys():
            v = self.get(k)
            if isinstance(v, list):
                b.write("{k} : [ {l} ]\n".format(k=str(k), l=",".join(map(str,v))))
            else:
                b.write("{k} : {v}\n".format(k=str(k), v=str(v)))
        b.write('}\n')
        s = b.getvalue()
        b.close()
        return s
    
class SimpleDictLike(DictLike):
    def __init__(self):
        self._map = dict()

    def _base_mapping(self):
        return self._map


class TemporalReferrant(UserDict):
    special_keys = ['start_time', 'end_time']
    def __init__(self):
        UserDict.__init__(self)
        for key in self.special_keys:
            self.data[key] = None

    def serializable_version(self):
        d=dict()
        for k in self.data.keys():
            if k == 'start_time':
                d[k] = self.get_start_time()
            elif k == 'end_time':
                d[k] = self.get_end_time()
            else:
                d[k] = self.data.get(k)
        return(d)
            
    def __getitem__(self, key):
        if key == 'start_time':
            return self.get_start_time()
        elif key == 'end_time':
            return self.get_end_time()
        else:
            return UserDict.__getitem__(self, key)
        
    def __setitem__(self, key, val):
        if key in self.special_keys:
            raise NotImplementedError("Can't explicitly set {key}".format(key=key))
        return UserDict.__setitem__(self, key, val)

    def __delitem__(self, key):
        if key in self.special_keys:
            raise NotImplementedError("Can't explicitly delete {key}".format(key=key))        
        return UserDict.__delitem__(self, key)

        
        
    @abstractmethod    
    def get_start_time(self):
        pass

    @abstractmethod        
    def get_end_time(self):
        pass


