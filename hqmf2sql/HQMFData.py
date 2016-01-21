import json
from HQMFUtil import *
from sqlalchemy.sql import select
from sqlalchemy.sql.expression import subquery, exists
from abc import ABCMeta, abstractmethod
from datetime import datetime
HQMF='hqmf'
VALUESET='valueset'

class HQMFCustomEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, DataCriterion) or isinstance(obj, ValueSpec) or isinstance(obj, MeasurePeriod):
            return obj.to_json()

        return json.JSONEncoder.default(self, obj)

class TemporalReferrant(metaclass=ABCMeta):
    def __init__(self):
        pass

    def get_start_time(self):
        raise NotImplementedError

    def get_end_time(self):
        raise NotImplementedError

    @abstractmethod
    def existence_test_col(self):
        pass

class DataCriterion(TemporalReferrant):
    SPECIFIC_OCCURRENCE_CONST="specific_occurrence_const"
    SPECIFIC_OCCURRENCE="specific_occurrence"
    def __init__(self, ctx):
        self.name = strip_quotes(ctx.any_string().getText())
        self.attributes = dict()
        self.temporal_references = []
        self.subset_operators = []
        self.value = None
        self.derivation_operator = None
        self.children = None
        self.inline_code_list = None

       
    def to_json(self):
        temporal_reference_list = []
        for r in self.temporal_references:
            temporal_reference_list.append(r.values)
        retval = {'name' : self.name, 'attributes' : self.attributes, 'temporal_references' : temporal_reference_list,
                  'subset_operators' : self.subset_operators}
        if self.value != None:
            retval['value'] = self.value.values
        if self.inline_code_list != None:
            retval['inline_code_list'] = self.inline_code_list.to_json()
        return retval

    def existence_test_col(self):
        return None
    
    def set_attribute(self, name, val):
        self.attributes[name] = val

    def get_status_attribute(self):
        return self.attributes.get('status')

    def get_definition_attribute(self):
        return self.attributes.get('definition')

    def set_derivation_operator(self, val):
        self.derivation_operator = val

    def get_derivation_operator(self):
        return(self.derivation_operator)

    def add_child_criterion_name(self, name):
        self.children.append(name)

    def get_child_criteria_names(self):
        return self.children

    def set_temporal_references(self, references):
        self.temporal_references = references

    def so_const(self):
        return self.attributes.get(self.SPECIFIC_OCCURRENCE_CONST)

    def so_inst(self):
        return self.attributes.get(self.SPECIFIC_OCCURRENCE)
   
    def is_specific_occurrence(self):
        return self.attributes.get(self.SPECIFIC_OCCURRENCE) != None

    def set_value(self, val):
        self.value = val

    def get_code_list_id(self):
        if self.attributes.get('negation'):
            return self.attributes.get('negation_code_list_id')
        else:
            return self.attributes.get('code_list_id')

    def set_inline_code_list(self, code_list):
        self.inline_code_list = code_list

    def add_subset_operator(self, op):
        self.subset_operators.append(op)

    def get_value(self):
        return self.value

    def get_attribute(self, attr):
        return self.attributes.get(attr)

    def get_negation(self):
        return self.get_attribute('negation')

    def get_subset_operators(self):
        return self.subset_operators


class ValueSpec:
    def __init__(self, ctx):
        self.values = dict()
    def set_value(self, key, val):
        self.values[key] = val
    def get_value_attr(self, key):
        return self.values.get(key)
    def set_range(self, range):
        self.values['range'] = range
    def to_json(self):
        return {'value' : self.values}

class InlineCodeList:
    def __init__(self, ctx):
        self.code_type = None
        self.codes = []
    def to_json(self):
        return {self.code_type : self.codes}

class TemporalReference:
    def __init__(self, ctx):
        self.values = dict()
    def set_operator(self, op):
        self.values['operator'] = op
    def get_operator(self):
        return self.values['operator']
    def set_reference(self, ref):
        self.values['reference'] = ref
    def get_reference(self):
        return self.values['reference']
    def set_range(self, temporal_range):
        self.values['range'] = temporal_range
    def get_range(self):
        return self.values.get('range')
    def to_json(self, encoderInstance):
        return {'temporal_reference' : self.values}



class MeasurePeriod(TemporalReferrant):
    def __init__(self, ctx):
        TemporalReferrant.__init__(self)
        self.values = dict()
        
    def set_range(self, temporal_range):
        self.values = temporal_range
    def to_json(self):
        return {'measure_period' : self.values}
    def get_start_time(self):
        return self.to_datetime(self._get_value('low'))
    def get_end_time(self):
        return self.to_datetime(self._get_value('high'))

    def existence_test_col(self):
        return None

    def _get_value(self, key):
        d = self.values.get(key)
        if d != None:
            return d.get('value')
        return None

    def _set_value(self, key, val):
        d = self.values.get(key)
        if d != None:
            d['value'] = val

    def override_values(self, low, high):
        self._set_value('low', low)
        self._set_value('high', high)

    def to_datetime(self, timestring):
        return datetime.strptime(timestring, "%Y%m%d%H%M")
    def is_specific_occurrence(self):
        return False
