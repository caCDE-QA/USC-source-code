import json
from HQMFv2JSONParserListener import HQMFv2JSONParserListener
from HQMFv2JSONParser import *
from HQMFUtil import *
from HQMFv2JSONLexer import HQMFv2JSONLexer
from collections.abc import Mapping
from collections import UserDict
from HQMFv2Data import *
import re
from datetime import date, timedelta, datetime
from abc import abstractmethod

LEXER=HQMFv2JSONLexer

       
def literal(token_number):
    return LEXER.literalNames[token_number]

def token_name(token_number):
    return strip_all_quotes(literal(token_number))

def string_to_number(val):
    if val is None:
        return None
    try:
        retval = int(val)
    except TypeError:
        retval = float(val)
    except ValueError:
        try:
            retval = float(val)
        except TypeError:
            pass
    return retval

class UnknownCriterionTypeException(Exception):
    pass

TEMPLATE_IDS = {
    "2.16.840.1.113883.10.20.28.3.54" : "patient_characteristic_birthdate",
    "2.16.840.1.113883.10.20.28.3.7" : "care_goal",
    "2.16.840.1.113883.10.20.28.3.105" : "cause",
    "2.16.840.1.113883.10.20.28.3.100" : "cumulative_medication_duration",
    "2.16.840.1.113883.10.20.28.3.11" : "device_adverse_event",
    "2.16.840.1.113883.10.20.28.3.12" : "device_allergy",
    "2.16.840.1.113883.10.20.28.3.13" : "device_applied",
    "2.16.840.1.113883.10.20.28.3.14" : "device_intolerance",
    "2.16.840.1.113883.10.20.28.3.15" : "device_order",
    "2.16.840.1.113883.10.20.28.3.16" : "device_recommended",
    "2.16.840.1.113883.10.20.28.3.1" : "diagnosis_active",
    "2.16.840.1.113883.10.20.28.3.17" : "diagnosis_family_history",
    "2.16.840.1.113883.10.20.28.3.18" : "diagnosis_inactive",
    "2.16.840.1.113883.10.20.28.3.19" : "diagnosis_resolved",
    "2.16.840.1.113883.10.20.28.3.20" : "diagnostic_study_adverse_event",
    "2.16.840.1.113883.10.20.28.3.21" : "diagnostic_study_intolerance",
    "2.16.840.1.113883.10.20.28.3.22" : "diagnostic_study_order",
    "2.16.840.1.113883.10.20.28.3.23" : "diagnostic_study_performed",
    "2.16.840.1.113883.10.20.28.3.24" : "diagnostic_study_recommended",
    "2.16.840.1.113883.10.20.28.3.26" : "encounter_active",
    "2.16.840.1.113883.10.20.28.3.27" : "encounter_order",
    "2.16.840.1.113883.10.20.28.3.5" : "encounter_performed",
    "2.16.840.1.113883.10.20.28.3.28" : "encounter_recommended",
    "2.16.840.1.113883.10.20.28.3.92" : "facility_location",
    "2.16.840.1.113883.10.20.28.3.99" : "frequency",
    "2.16.840.1.113883.10.20.28.3.29" : "functional_status_order",
    "2.16.840.1.113883.10.20.28.3.30" : "functional_status_performed",
    "2.16.840.1.113883.10.20.28.3.31" : "functional_status_recommended",
    "2.16.840.1.113883.10.20.28.3.102" : "health_record_field",
    "2.16.840.1.113883.10.20.28.3.89" : "incision_datetime",
    "2.16.840.1.113883.10.20.28.3.33" : "intervention_adverse_event",
    "2.16.840.1.113883.10.20.28.3.34" : "intervention_intolerance",
    "2.16.840.1.113883.10.20.28.3.35" : "intervention_order",
    "2.16.840.1.113883.10.20.28.3.36" : "intervention_performed",
    "2.16.840.1.113883.10.20.28.3.37" : "intervention_recommended",
    "2.16.840.1.113883.10.20.28.3.39" : "laboratory_test_adverse_event",
    "2.16.840.1.113883.10.20.28.3.40" : "laboratory_test_intolerance",
    "2.16.840.1.113883.10.20.28.3.41" : "laboratory_test_order",
    "2.16.840.1.113883.10.20.28.3.42" : "laboratory_test_performed",
    "2.16.840.1.113883.10.20.28.3.43" : "laboratory_test_recommended",
    "2.16.840.1.113883.10.20.28.3.98" : "laterality",
    "2.16.840.1.113883.10.20.28.3.44" : "medication_active",
    "2.16.840.1.113883.10.20.28.3.45" : "medication_administered",
    "2.16.840.1.113883.10.20.28.3.46" : "medication_adverse_effects",
    "2.16.840.1.113883.10.20.28.3.47" : "medication_allergy",
    "2.16.840.1.113883.10.20.28.3.48" : "medication_discharge",
    "2.16.840.1.113883.10.20.28.3.49" : "medication_dispensed",
    "2.16.840.1.113883.10.20.28.3.50" : "medication_intolerance",
    "2.16.840.1.113883.10.20.28.3.51" : "medication_order",
    "2.16.840.1.113883.10.20.28.3.52" : "patient_care_experience",
    "2.16.840.1.113883.10.20.28.3.53" : "patient_characteristic",
    "2.16.840.1.113883.10.20.28.3.6" : "patient_characteristic_clinical_trial_participant",
    "2.16.840.1.113883.10.20.28.3.56" : "patient_characteristic_ethnicity",
    "2.16.840.1.113883.10.20.28.3.57" : "patient_characteristic_expired",
    "2.16.840.1.113883.10.20.28.3.58" : "patient_characteristic_payer",
    "2.16.840.1.113883.10.20.28.3.59" : "patient_characteristic_race",
    "2.16.840.1.113883.10.20.28.3.55" : "patient_characteristic_sex",
    "2.16.840.1.113883.10.20.28.3.86" : "patient_preference",
    "2.16.840.1.113883.10.20.28.3.61" : "physical_exam_order",
    "2.16.840.1.113883.10.20.28.3.62" : "physical_exam_performed",
    "2.16.840.1.113883.10.20.28.3.63" : "physical_exam_recommended",
    "2.16.840.1.113883.10.20.28.3.64" : "procedure_adverse_event",
    "2.16.840.1.113883.10.20.28.3.65" : "procedure_intolerance",
    "2.16.840.1.113883.10.20.28.3.66" : "procedure_order",
    "2.16.840.1.113883.10.20.28.3.67" : "procedure_performed",
    "2.16.840.1.113883.10.20.28.3.68" : "procedure_recommended",
    "2.16.840.1.113883.10.20.28.3.70" : "provider_care_experience",
    "2.16.840.1.113883.10.20.28.3.71" : "provider_characteristic",
    "2.16.840.1.113883.10.20.28.3.87" : "provider_preference",
    "2.16.840.1.113883.10.20.28.3.106" : "radiation_dosage",
    "2.16.840.1.113883.10.20.28.3.107" : "radiation_duration",
    "2.16.840.1.113883.10.20.28.3.91" : "reaction",
    "2.16.840.1.113883.10.20.28.3.88" : "reason",
    "2.16.840.1.113883.10.20.28.3.103" : "recorder",
    "2.16.840.1.113883.10.20.28.3.101" : "result",
    "2.16.840.1.113883.10.20.28.3.72" : "risk_category_assessment",
    "2.16.840.1.113883.10.20.28.3.109" : "satisfies_all",
    "2.16.840.1.113883.10.20.28.3.108" : "satisfies_any",
    "2.16.840.1.113883.10.20.28.3.93" : "severity_observation",
    "2.16.840.1.113883.10.20.28.3.104" : "source",
    "2.16.840.1.113883.10.20.28.3.94" : "status",
    "2.16.840.1.113883.10.20.28.3.95" : "status_active",
    "2.16.840.1.113883.10.20.28.3.96" : "status_inactive",
    "2.16.840.1.113883.10.20.28.3.97" : "status_resolved",
    "2.16.840.1.113883.10.20.28.3.73" : "substance_administered",
    "2.16.840.1.113883.10.20.28.3.46.74" : "substance_adverse_event",
    "2.16.840.1.113883.10.20.28.3.75" : "substance_allergy",
    "2.16.840.1.113883.10.20.28.3.76" : "substance_intolerance",
    "2.16.840.1.113883.10.20.28.3.77" : "substance_order",
    "2.16.840.1.113883.10.20.28.3.78" : "substance_recommended",
    "2.16.840.1.113883.10.20.28.3.79" : "symptom_active",
    "2.16.840.1.113883.10.20.28.3.80" : "symptom_assessed",
    "2.16.840.1.113883.10.20.28.3.81" : "symptom_inactive",
    "2.16.840.1.113883.10.20.28.3.82" : "symptom_resolved",
    "2.16.840.1.113883.10.20.28.3.84" : "transfer_from",
    "2.16.840.1.113883.10.20.28.3.85" : "transfer_to"
}

DATA_LOINC_CODES = {
    '21112-8' : 'patient_characteristic_birthdate'
}

DIAGNOSIS_CODE = "282291009"

TIME_UNITS = {
              'a' : 'year',
              'mo' : 'month',
              'wk' : 'week',
              'd' : 'day'
              }

def find_data_table(template_id):
    if template_id == None:
        return None
    return TEMPLATE_IDS.get(template_id)

class MeasurePeriod (TemporalReferrant):
    def __init__(self):
        TemporalReferrant.__init__(self)

    def set_time_value(self, time_value):
        self.data['time_value'] = time_value;

    def set_id(self, id):
        self.data['id'] = id;

    def set_code(self, code):
        self.data['code'] = code;

    def get_start_time(self, outer=True):
        if self.data.get('explicit_start_time') != None:
            return self.data.get('explicit_start_time')
        elif self.data.get('time_value') == None:
            return None
        else:
            return self.data.get('time_value').get_start_time()

    def get_end_time(self, outer=True):
        if self.data.get('explicit_end_time') != None:
            return self.data.get('explicit_end_time')
        elif self.get('time_value') == None:
            return None
        else:
            return self.time_value.get_end_time()

    def override_values(self, start_time, end_time):
        self['explicit_start_time'] = start_time
        self['explicit_end_time'] = end_time

class BaseDictClass(UserDict):
    def __init__(self):
        UserDict.__init__(self)

    def serializable_version(self):
        return self.data

    def clone_data(self):
        d=dict()
        for k in self.data.keys():
            d[k] = self[k]
        return(d)
    
    
    def set_name_value_pair(self, name, value):
        self.data[name] = value

    def get_dict_entry(self, key):
        return self.data.get(token_name(key))

    def get_nested_dict_entry(self, keys):
        val = self
        for key in keys:
            val = val.get_dict_entry(key)
            if val == None:
                return None
        return val

class MyEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, BaseDictClass) or isinstance(o, TemporalReferrant):
            return o.serializable_version()
        if isinstance(o, datetime):
            return str(o)
        return json.JSONEncoder.default(self, o)

    
class ValueRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.value = None

    def set_value(self, value):
        self.value = value
        self['value'] = self.value

    def get_raw_value(self):
        return self.value

    def get_value_type(self):
        return type(self.value)

    def get_value_str(self):
        if self.value == None:
            return None
        if hasattr(self.value, 'value_str'):
            return self.value.value_str()
        else:
            return(str(type(self.value)))

    def get_value_code(self):
        if isinstance(self.value, CdRhs):
            return self.value.get_code()
        return None

    def get_display_name(self):
        if isinstance(self.value, CdRhs):
            return self.value.get_display_name()
        if isinstance(self.value, ValueSetRhs):
            return self.value.get_display_name()
        return None

    def get_value_set(self):
        if isinstance(self.value, ValueSetRhs):
            return self.value.get_value_set()

    def get_str(self):
        if isinstance(self.value, CdRhs):
            return str(self.get_value_code()) + " (" + str(self.get_display_name()) + ")"
        if isinstance(self.value, ValueSetRhs):
            return self.get_value_set() + " (" + self.get_display_name() + ")"
        if isinstance(self.value, ValueAnyNonNullRhs):
            return  "(" + self.value.get_display_name() + ")"
        if isinstance(self.value, IvlPqRhs):
            res = None
            lowval = self.value.get_low()
            if lowval != None:
                low = lowval.get_value()
                if low != None:
                    op = "&gt;"
                    lc = self.value.get_low_closed()
                    if lc or lc == None:
                        op = op + "="
                    res = "low: " + str(low) + ", closed: " + str(lc) + " ( " + op + " " + str(low) + ")"
            highval = self.value.get_high()
            if highval != None:
                high = highval.get_value()
                if high != None:
                    op = "&lt;"
                    hc = self.value.get_high_closed()
                    if hc or hc == None:
                        op = op + "="
                    if res == None:
                        res = ""
                    else:
                        res = res + ", "
                    res = res + "high: " + str(high) + ", closed: " + str(hc) + " ( " + op + " " + str(high) + ")"
            return res
        return "(" + str(type(self.value)) + ")"

class ValueSetRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.value_set = None
        self.display_name = None

    def set_value_set(self, value_set):
        self.value_set = value_set
        self['value_set'] = self.value_set
    def get_value_set(self):
        return self.value_set

    def set_display_name(self, display_name):
        self.display_name = display_name
        self['display_name'] = self.display_name
    def get_display_name(self):
        if self.display_name == None:
            return None
        return self.display_name.get_value()

class Placeholder:
    pass

class Hxit(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

class Any(Hxit):
    def __init__(self):
        BaseDictClass.__init__(self)

class Code:
    def __init__(self, code = None, code_system = None, display_name = None):
        self.set_code(code)
        self.set_code_system(code_system)
        self.set_display_name(display_name)

    def equals(self, other):
        return other != None and self.get_code_part() == other.get_code_part() and self.get_code_system() == other.get_code_system()

    def set_code(self, code):
        self.code = code

    def set_code_system(self, code_system):
        self.code_system = code_system

    def set_display_name(self, display_name):
        self.displayName = display_name

    def get_code(self):
        return self.code

    def get_code_system(self):
        return self.codeSystem

    def get_display_name(self):
        return self.displayName

    def to_string(self):
        if self.displayName != None:
            return str(self.get_code()) + " (" + self.get_display_name() + ")"
        else:
            return str(self.get_code())

class ValueCodeRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

    def get_code(self):
        return self.get_dict_entry(LEXER.A_code)

    def get_codeSystem(self):
        return self.get_dict_entry(LEXER.A_codeSystem)

    def value_str(self):
        return self.get_code()
        
class ValueAnyNonNullRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self['any_non_null'] = True
    
    def get_display_name(self):
        return("Any non-null")

    def value_str(self):
        return("any non-null")

   

class InfrastructureRoot(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

    def getTemplateIds(self):
        return self.get_dict_entry(LEXER.S_templateId)

    def get_type_id(self):
        return self.get_dict_entry(LEXER.S_typeId)

    def get_realm_code(self):
        return self.get_dict_entry(LEXER.S_realmCode)

class BaseDset:
    def __init__(self):
        self.items=[]

    def add_item(self, item):
        self.items.append(item)


class DsetCdRhs(BaseDset):
    def __init__(self):
        BaseDset.__init__(self)

class TemporalInformationRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

    def get_precision(self):
        return self.get_dict_entry(LEXER.A_precisionUnit)

    def get_raw_delta(self):
        return self.get_dict_entry(LEXER.C_qdm_delta)

    def get_low(self):
        d = self.get_raw_delta()
        if d == None:
            return None
        return d.get_low()

    def get_high(self):
        d = self.get_raw_delta()
        if d == None:
            return None
        return d.get_high()

    def get_low_closed(self):
        d = self.get_raw_delta()
        if d == None:
            return None
        return d.get_low_closed()
    
    def get_high_closed(self):
        d = self.get_raw_delta()
        if d == None:
            return None
        return d.get_high_closed()


class TemporalInformationAttributeRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

class CriteriaReferenceRhs(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)

    def get_id_root(self):
        return self.get_nested_dict_entry([LEXER.S_id, LEXER.A_root])

    def get_id_extension(self):
        return self.get_nested_dict_entry([LEXER.S_id, LEXER.A_extension])

    def get_criterion_id(self):
        return IiRhs.make_key(self.get_id_root(), self.get_id_extension())

    def get_data_criterion(self, symbol_table):
        return symbol_table.get_data_criterion(self.get_criterion_id())

class BooleanGroupingRhs(InfrastructureRoot):
    def __init__(self, grouping_type):
        InfrastructureRoot.__init__(self)
        self.grouping_type = grouping_type
        self.preconditions = None

    def set_preconditions(self, prec_rhs):
        self.preconditions = prec_rhs

    def get_raw_preconditions(self):
        return self.preconditions

    def get_preconditions(self):
        raw = self.get_raw_preconditions()
        if raw == None:
            return None
        return raw.get_preconditions()

class MeasureAttributeRhs(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)

class OutboundRelationship(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.child_data_criterion = None
        self.child_criterion_reference = None

    def set_child_data_criterion(self, crit):
        self.child_data_criterion = crit

    def set_child_criterion_reference(self, ref):
        self.child_data_criterion_reference = ref

    def get_child_data_criterion(self):
        return self.child_data_criterion

    def get_child_data_criterion_reference(self):
        return self.child_data_criterion_reference

    def get_child_criterion(self, symbol_table):
        child = self.get_child_data_criterion()
        if child == None:
            ref = self.get_child_data_criterion_reference()
            if ref != None:
                child = symbol_table.get_data_criterion(ref.get_criterion_id())
                if child is None:
                    raise ValueError("No entry for" + str(ref.get_criterion_id()) + " in symbol table")
            else:
                raise ValueError("Outbound relationship has no child and no reference")
        return child
    
class FieldValue(OutboundRelationship):
    def __init__(self):
        OutboundRelationship.__init__(self)
        self.field_template_id = None
        self.field_name = None
        
    def get_raw_field_value(self):
        child = self.get_child_data_criterion()
        if child is None:
            return None
        return child.get_value()

    def get_field_name(self):
        return self.field_name
    
    def get_field_template_id(self):
        return self.field_template_id
    
    def set_field_template_id(self, tmpl):
        self.field_template_id = tmpl
        self.field_name = TEMPLATE_IDS.get(self.field_template_id)
  
class StatusEntry(OutboundRelationship):
    ACTIVE = 'active'
    def __init__(self):
        OutboundRelationship.__init__(self)

    def get_status_code(self):
        child = self.get_child_data_criterion()
        if child is None:
            return None
        status_value = child.get_value()
        if status_value is None:
            return None
        return status_value.get_value_code()

    def get_status(self):
        status_code = self.get_status_code()
        if status_code == token_name(LEXER.C_SNOMED_active):
            return self.ACTIVE

class ResultEntry(OutboundRelationship):
    def __init__(self):
        OutboundRelationship.__init__(self)

class ConjunctionEntry(OutboundRelationship):
    def __init__(self):
        OutboundRelationship.__init__(self)
        self.conjunction_code = None
        self.criteria_reference = None

    def set_conjunction_code(self, conjunction_code):
        self.conjunction_code = conjunction_code

    def get_raw_conjunction_code(self):
        return self.conjunction_code

    def get_conjunction_code(self):
        if self.conjunction_code == None:
            return None
        return self.conjunction_code.get_code()

    def print_summary(self, symbol_table, dc_set, html=True, prefix="<li>", suffix="</li>", text_prefix_add="   ", dc_verbose=False):
        child = self.get_child_criterion(symbol_table)
        if child != None:
            child_id = child.get_id()
        else:
            child_id = None
        print(prefix + str(self.get_conjunction_code()) + " " + str(child_id) + suffix)            
        if html:
            print("<ul>")
        else:
            prefix = prefix + text_prefix_add
        child.print_summary(symbol_table, dc_set, html, prefix, suffix, text_prefix_add, dc_verbose)
        print("</ul>")

class SpecificOccurrenceEntry(OutboundRelationship):
    def __init__(self):
        OutboundRelationship.__init__(self)

class Excerpt(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.data_criterion = None
        
    def add_data_criterion(self, dc):
        self.data_criterion = dc
    
    def get_data_criterion(self): 
        return self.data_criterion


class DataCriterion(InfrastructureRoot):
    index_number = 0
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.name = None
        self.criterion_id = None
        self.title = None
        self.value = None
        self.raw_template_ids = None
        self.temporally_related = []
        self['temporally_related'] = self.temporally_related
        self.type_id = None
        self.status = None
        self.result = None
        self.outbound_relationship_list = []
        self['outbound_relationship_list'] = self.outbound_relationship_list
        self.recent = None
        self.conjunction_entries = None
        self.specific_occurrence = None
        self.repeat_number = None
        self.count = None
        self.sequence_number = None
        self.field_value = None
        self.specific_occurrence_target_indicator = False
        self.code_list = None
        self.variable_name = None
        self.short_name = None
        self.dc_index = self.next_index()

    @classmethod
    def next_index(cls):
        cls.index_number = cls.index_number + 1
        return cls.index_number

    def serializable_version(self):
        return self.clone_data()

    def is_negation(self):
        return self.data.get(token_name(LEXER.A_actionNegationInd)) == True
    
    def set_code_list(self, code_list):
        self.code_list = code_list
        self.__setitem__('code_list', self.code_list)
        
    def get_raw_code_list(self):
        return self.code_list
    
    def get_code_list(self):
        rcl = self.get_raw_code_list()
        if rcl == None:
            return None
        return rcl.get_value_set()
    
    def set_effective_value(self, val):
        self.effective_value = val
        self.__setitem__('effective_value', self.effective_value)        
        
    def get_effective_value(self):
        return self.effective_value
        
    def is_specific_occurrence_target(self):
        return self.specific_occurrence_target_indicator
    
    def set_specific_occurrence_target_indicator(self):
        self.specific_occurrence_target_indicator = True
        self.__setitem__('specific_occurrence_target_indicator', self.specific_occurrence_target_indicator)
        
    def is_specific_occurrence(self):
        return self.specific_occurrence != None    
        
    def set_field_value(self, field_value):
        self.field_value = field_value
        self.__setitem__('field_value', self.field_value)
        
    def get_raw_field_value(self):
        return self.field_value

    def get_name(self):
        return self.name

    def set_name(self, name):
        self.name = name
        self.__setitem__('name', self.name)
    
    def get_variable_name(self):
        return self.variable_name

    def get_short_name(self):
        if self.is_specific_occurrence():
            self.short_name = "so_" + str(self.dc_index)
        elif self.is_variable():
            self.short_name = "var_" + str(self.dc_index)
        else:
            self.short_name = 'dc_' + str(self.dc_index)
        self['short_name'] = self.short_name
        return self.get('short_name')

    def is_variable(self):
        return self.get_variable_name() != None
        
    def set_sequence_number(self, num):
        self.sequence_number = num
        self.__setitem__('sequence_number', self.sequence_number)
        
    def get_sequence_number(self):
        return self.sequence_number

    def get_raw_count(self):
        return self.count

    def set_count(self, count):
        self.count = count
        self.__setitem__('count', self.count)

        
        
    def set_id(self, criterion_id):
        self.criterion_id = criterion_id
        self.__setitem__('criterion_id', self.criterion_id)
        # Ugh. According to https://github.com/projectcypress/health-data-standards/blob/master/resources/qdm_hqmf_r2.1_patterns/Variable_Assignment_HQMF_Pattern.md,
        # naming conventions are how we distinguish variables from other criteria.

        name = criterion_id.get_extension()
        if name[:8] == "qdm_var_":
            self.variable_name = self.get_key()
            self.__setitem__('variable_name', self.variable_name)            
        else:
            self.variable_name = None


    def get_raw_id(self):
        return self.criterion_id
    
    def so_const(self):
        if self.is_specific_occurrence_target():
            return self.get_raw_id().get_root()
        else:
            return None

    def get_id(self):
        raw = self.get_raw_id()
        if raw == None:
            return None
        return raw.get_extension()
    
    def get_key(self):
        raw = self.get_raw_id()
        if raw == None:
            return None
        return raw.get_key()

    def get_raw_code(self):
        return self.get_dict_entry(LEXER.S_code)
    
    def set_value(self, value):
        self.value = value
        self.__setitem__('value', self.value)

    def get_value(self):
        return(self.value)

    def add_temporally_related(self, info):
        self.temporally_related.append(info)

    def get_temporally_related(self):
        return self.temporally_related

    def set_type_id(self, type_id):
        self.type_id = type_id
        self.__setitem__('type_id', self.type_id)

    def get_type_id(self):
        return self.type_id

    def set_template_ids(self, list_ii_rhs):
        self.raw_template_ids = list_ii_rhs
        self.__setitem__('raw_template_ids', self.raw_template_ids)

    def get_raw_template_ids(self):
        return self.raw_template_ids

    def set_status(self, status):
        self.status = status
        self.__setitem__('status', self.status)

    def get_status(self):
        return self.status

    def set_result(self, result):
        self.result = result
        self.__setitem__('result', self.result)

    def get_result(self):
        return self.result

    def add_conjunction_entry(self, entry):
        if self.conjunction_entries == None:
            self.conjunction_entries = [entry]
            self.__setitem__('conjunction_entries', self.conjunction_entries)
        else:
            self.conjunction_entries.append(entry)

    def get_conjunction_entries(self):
        return self.conjunction_entries

    def set_specific_occurrence(self, specific_occurrence):
        self.specific_occurrence = specific_occurrence
        self.__setitem__('specific_occurrence', self.specific_occurrence)

    def get_specific_occurrence(self):
        return self.specific_occurrence
        
    def set_recent(self, recent):
        self.recent = recent
        self.__setitem__('recent', self.recent)
        
    def get_recent(self):
        return self.recent

    def set_repeat_number(self, ivl_int_rhs):
        self.repeat_number = ivl_int_rhs
        self.__setitem__('repeat_number', self.repeat_number)

    def get_repeat_number(self):
        return self.repeat_number

    def get_count(self):
        cnt = self.get_raw_count()
        if cnt == None:
            return None
        dc = cnt.get_data_criterion()
        if dc == None:
            return None
        return dc.get_repeat_number()

    def get_template_id(self):
        raw = self.get_raw_template_ids()
        if raw == None:
            return None
        ids = raw.get_ids()
        if isinstance(ids, list):
            if len(ids) != 1:
                raise UnknownCriterionTypeException("missing or multiple template ids")
            template = ids[0]
        else:
            template = ids
        if template != None:
            return template.get_root()

    def get_criteria_data_type(self):
        template_id = self.get_template_id()
        if template_id == None:
            return None
        result = find_data_table(self.get_template_id())
        if result == None:
            raise UnknownCriterionTypeException("Can't find data type for template " + str(self.get_template_id()))
        return result
    
    def get_status_code(self):
        status = self.get_status()
        if status == None:
            return None
        return status.get_status()

    def print_summary(self, symbol_table, dc_set, html=True, prefix="<li>", suffix="</li>", text_prefix_add="   ", dc_verbose = False):
        if (dc_set != None) and (self.get_key() in dc_set):
            return
        if not dc_verbose:
            so_ref = self.get_specific_occurrence()
            if so_ref is not None:
                so = so_ref.get_data_criterion(symbol_table)    
                print(prefix + "Specific occurrence " + self.get_id() + " references " + so.get_id())
            elif self.is_variable():
                print(prefix + "Variable " + self.get_variable_name() + " (Data criterion id: " + self.get_id() + ")" + suffix)
            else:
                data_type = None
                if self.conjunction_entries != None:
                    data_type = "conjunction"
                else:
                    data_type = self.get_criteria_data_type()
                print(prefix + "Data criterion id: " + str(self.get_id()) + ", name: " + str(self.get_name()) + ", type: " + str(data_type) + suffix)
        else:
            print(prefix + "Data criterion " + str(self.get_name()) + suffix)
            if (html):
                print("<ul>")
            print(prefix + "ID: " + str(self.get_id()) + suffix)
            if self.conjunction_entries != None:
                print(prefix + "Data type: conjunction" + suffix)
            if self.get_template_id() != None:
                print(prefix + "Data type: " + str(self.get_template_id()) + " (" + self.get_criteria_data_type() + ")" + suffix)
            print (prefix + "Code List: " + str(self.get_code_list()) + suffix)
            code = self.get_raw_code()
            if code != None:
                res = None
                cd = code.get_code()
                if cd != None:
                    res = "Code: " + str(cd)
                vs = code.get_value_set()
                if vs != None:
                    if res == None:
                        res = "Value Set: " + str(vs)
                    else:
                        res = res + ", Value Set: " + str(vs)
                dn = code.get_display_name()
                if dn != None and res != None:
                    res = res + " (" + dn + ")"
                if res != None:
                    print(prefix + res + suffix)
                            
            value = self.get_value()
            if value != None:
                print(prefix + "Value: " + str(value.get_str()) + suffix)
            result = self.get_result()
            if result != None:
                dc = result.get_child_data_criterion()
                if dc != None:
                    value = dc.get_value()
                    if value != None:
                        print(prefix + "Result: " + str(value.get_str()) + suffix)
            if self.get_type_id() != None:
                print(prefix + "Type: " + str(self.get_type_id()) + suffix)
            if self.get_recent() != None:
                print(prefix + "Most Recent" + suffix)
            if self.get_status_code() != None:
                print(prefix + "Status: " + str(self.get_status_code()) + suffix)
            if self.get_sequence_number() != None:
                print(prefix + "Sequence number (Nth occurrence): " + str(self.get_sequence_number()) + suffix)
            field = self.get_raw_field_value()
            if field is not None:
                print(prefix + "Field " + field.get_field_name() + ", value " + str(field.get_raw_field_value().get_str()) + suffix)

            rep = self.get_count()
            if rep != None:
                low = rep.get_low()
                if low != None:
                    op = ">"                
                    if html:
                        op = "&gt;"
                    lc = rep.get_low_closed()
                    if lc or lc == None:
                        op = op + "="
                    print (prefix + "Count: low: " + str(low) + ", closed: " + str(lc) + " (Count " + op + " " + str(low) + ")" + suffix)
                high = rep.get_high()
                if high != None:
                    op = "<"
                    if (html):
                        op = "&lt;"
                    hc = rep.get_high_closed()
                    if hc or hc == None:
                        op = op + "="
                    print (prefix + "Count: high: " + str(high) + ", closed: " + str(hc) + " (Count " + op + " " + str(high) + ")" + suffix)              
            for temp in self.get_temporally_related():
                if temp != None:
                    print(prefix + "Temporal relationship: " + suffix)
                    if (html):
                        print("<ul>")
                    else:
                        old_prefix = prefix
                        prefix = old_prefix + text_prefix_add
                    print(prefix + "Temporal operator: " + str(temp.get_type_code()) + suffix)
                    print(prefix + "Temporal precision: " + str(temp.get_precision()) + suffix)
                    ref = temp.get_criteria_reference()
                    if ref == None:
                        print(prefix + "Temporal reference criterion: (none)" + suffix)
                    else:
                        print (prefix + "Temporal reference criterion: " + str(ref.get_criterion_id()) + suffix)
                    low = temp.get_low()
                    if low != None and low.get_value() != None:
                        lc = temp.get_low_closed()
                        if (html):
                            op = "&gt;"
                        else:
                            op = ">"
                        if lc or lc == None:
                            op = op + "="
                        print(prefix + "Low delta: " + str(low.get_value()) + ", unit: " + str(low.get_unit()) + ", closed: " + str(temp.get_low_closed()) + 
                              " ( " + op + " " + str(low.get_value()) + " " + TIME_UNITS.get(low.get_unit()) + ")" + suffix)
                    high = temp.get_high()
                    if high != None and high.get_value() != None:
                        hc = temp.get_high_closed()
                        if (html):
                            op = "&lt;"
                        else:
                            op = "<"
                        if hc or hc == None:
                            op = op + "="
                        print(prefix + "High delta: " + str(high.get_value()) + ", unit: " + str(high.get_unit()) + ", closed: " + str(temp.get_high_closed()) + 
                              " ( " + op + " " + str(high.get_value()) + " " + str(TIME_UNITS.get(high.get_unit())) + ")" + suffix)                
                    if (html):
                        print("</ul>")
                        
        if dc_verbose or not self.is_variable():
            if self.conjunction_entries != None:
                print(prefix + "Conjunction:" + suffix)
                child_prefix = prefix
                if (html):
                    print("<ul>")
                else:
                    child_prefix = prefix + text_prefix_add
                for entry in self.conjunction_entries:
                    entry.print_summary(symbol_table, dc_set, html, child_prefix, suffix, text_prefix_add, dc_verbose)
                if (html):
                    print("</ul>")
        if (html and dc_verbose):
            print("</ul>")
        if dc_set != None:
            dc_set.add(self.get_key())            

    def dc_census(self, dc_set, symbol_table):
        dc_set.add(self.get_key())
        for temp in self.get_temporally_related():
            if temp != None:
                ref = temp.get_criteria_reference()
                if ref != None:
                    child = ref.get_data_criterion(symbol_table)
                    if child != None:
                        child.dc_census(dc_set, symbol_table)
        if self.conjunction_entries != None:
            for entry in self.conjunction_entries:
                child = entry.get_child_criterion(symbol_table)
                if child != None:
                    child.dc_census(dc_set, symbol_table)

class Hl7_id:
    def __init__(self, root, extension):
        self.root = root
        self.extension = extension

    def get_root(self):
        return self.root

    def get_extension(self):
        return self.extension

    def get_identifier_name(self):
        return self.identifier_name

    def get_displayable(self):
        return self.displayable

    def get_scope(self):
        return self.scope

    def get_reliablilty(self):
        return self.reliablitity
    
    @staticmethod
    def make_key(root, extension):
        return str(root) + ':' + str(extension)

    def get_key(self):
        return self.make_key(self.get_root(), self.get_extension())

    def equals(self, other):
        return self.root == other.root and self.extension == other.extension

        
class SymbolTable(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.measure_period = None
        self.data_criteria = dict()
        self.__setitem__('data_criteria', self.data_criteria)
        self.population_criteria = dict()
        self.__setitem__('population_criteria', self.population_criteria)
        self.variables = dict()
        self.__setitem__('variables', self.variables)
        self.specific_occurrences = dict()
        self.__setitem__('specific_occurrences', self.specific_occurrences)
        self.measure_attributes = []
        self.__setitem__('measure_attributes', self.measure_attributes)
        self.so_temporal_dependencies = dict()
        self.__setitem__('so_temporal_dependencies', self.so_temporal_dependencies)

    def set_measure_period(self, measure_period):
        self.measure_period = measure_period
        self.__setitem__('measure_period', self.measure_period)


    def get_measure_period(self):
        return self.measure_period

    def add_measure_attribute(self, measure_attribute):
        self.measure_attributes.append(measure_attribute)

    def get_measure_attributes(self):
        return self.measure_attributes

    def add_data_criterion(self, dc):
        self.data_criteria[dc.get_key()] = dc
        if dc.is_variable():
            vn = dc.get_variable_name()
            if vn != None:
                self.variables[vn] = dc
                self.data_criteria[vn] = dc
                
    def add_specific_occurrence(self, so):
        so_target = self.get_data_criterion(so.get_specific_occurrence().get_criterion_id())
        so_target.set_specific_occurrence_target_indicator()
        self.data_criteria[so_target.get_key()] = so_target
        self.specific_occurrences[so_target.get_key()] = so_target
        temp = so.get_temporally_related()
        if temp is not None:
            for t in temp:
                ref = t.get_criteria_reference()
                if ref != None and ref.get_id_extension() != 'measureperiod':
                    ref_target = self.get_data_criterion(ref.get_criterion_id())
                    if ref_target is None:
                        print("No target for " + ref.get_criterion_id())
                    else:
                        self.add_so_dependency(so.get_key(), ref_target.get_key())

    def add_so_dependency(self, lhs, rhs):
        so_set = self.so_temporal_dependencies.get(lhs)
        if so_set == None:
            self.so_temporal_dependencies[lhs] = set()
        self.so_temporal_dependencies.get(lhs).add(rhs)

        
    def get_specific_occurrences(self):
        return self.specific_occurrences
    
    def get_specific_occurrence(self, key):
        return self.specific_occurrences.get(key)
                
    def get_variable(self, vname):
        return self.variables.get(vname)
    
    def get_variables(self):
        return self.variables

    def get_data_criteria(self):
        return self.data_criteria

    def get_data_criterion(self, key):
        return self.data_criteria.get(key)

    def set_population_criterion(self, pc):
        self.population_criteria[pc.get_id()] = pc

    def get_population_criterion(self, id):
        return self.population_criteria.get(id)

class Measure(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.symbol_table = SymbolTable()
        self['symbol_table'] = self.symbol_table
        self.populations = []
        self['populations'] = self.populations
        self['measure_name'] = None

    def get_symbol_table(self):
        return(self.symbol_table)
    
    def get_measure_name(self):
        found = False
        if self.data.get('measure_name') != None:
            return self.data.get('measure_name')
        for attr in self.symbol_table.get_measure_attributes():
            code = attr.get_dict_entry(LEXER.S_code)
            if code != None:
                orig_text = code.get_original_text()
                if orig_text != None:
                    val = orig_text.entries.get(token_name(LEXER.A_value))
                    if val[:19] == "eMeasure Identifier":
                        found = True
            if found:
                val = attr.get_dict_entry(LEXER.S_value)
                name = val.get_dict_entry(LEXER.A_value)
                if name == None:
                    found = False
                else:
                    return name
        return "unknown_measure"             
                

    def __getitem__(self, key):
        if key == 'measure_name':
            return self.get_measure_name()
        return InfrastructureRoot.__getitem__(self, key)

    def serializable_version(self):
        return self.clone_data()
    
    def add_population(self, population):
        self.populations.append(population)

    def date_str(self, date):
        if date == None:
            return "(none)"
        else:
            return date.strftime("%Y-%d-%m")

    def non_stratifier_data_criteria(self):
        criteria = set()
        for p in self.populations:
            for p in self.populations:
                if isinstance(p, list):
                    for pop in p:
                        pop.dc_census(criteria, self.symbol_table)
                else:
                    p.dc_census(criteria, self.symbol_table)
        return criteria


    def print_summary(self, html=True, prefix="<li>", suffix="</li>", text_prefix_add="   ", dc_verbose = False):
        mp = self.symbol_table.get_measure_period()
        if (html):
            print("<html>\n<head>\n</head><body>")
            print("<ul>")
        print(prefix + "Measure name: " + self.get_measure_name() + suffix)
        print(prefix + "Measure period: " + self.date_str(mp.get_start_time()) + " - " + self.date_str(mp.get_end_time()) + suffix)
        print(prefix + "Populations:" + suffix)
        if (html):
            print("<ul>")
        for p in self.populations:
            if isinstance(p, list):
                for pop in p:
                    pop.print_summary(self.symbol_table, None, html, prefix, suffix, text_prefix_add, dc_verbose)
            else:
                p.print_summary(self.symbol_table, None, html, prefix, suffix, text_prefix_add, dc_verbose)
        if (html):
            print("</ul>")
        dc_done = set()
        print(prefix + "Specific Occurrences" + suffix)
        if html:
            print("<ul>")
        for v in self.symbol_table.get_specific_occurrences().values():
            v.print_summary(self.symbol_table, dc_done, html, prefix, suffix, text_prefix_add, True)
        if html:
            print("</ul>")        
        print(prefix + "Variables" + suffix)
        if html:
            print("<ul>")
        for v in self.symbol_table.get_variables().values():
            v.print_summary(self.symbol_table, dc_done, html, prefix, suffix, text_prefix_add, True)
        if html:
            print("</ul>")            
        print(prefix + "All other non-stratification data criteria:" + suffix)
        if html:
            print("<ul>")
        for d in self.non_stratifier_data_criteria():
            dc = self.symbol_table.get_data_criterion(d)
            dc.print_summary(self.symbol_table, dc_done, html, prefix, suffix, text_prefix_add, True)
        if (html):
            print("</ul>")
        if (html):
            print("</ul>")
            print("</body>\n</html>")

class PopulationCriteriaSectionRhs(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.population_criteria = dict()
        self.data['population_criteria'] = self.population_criteria

    def add_population_criterion(self, crit):
        ctype = crit.get_type()
        if ctype == token_name(LEXER.S_STRAT):
            existing = self.population_criteria.get(ctype)
            if existing == None:
                self.population_criteria[ctype] = [crit]
            else:
                self.population_criteria[ctype].append(crit)
        else:
            self.population_criteria[crit.get_type()] = crit

    def get_population_criteria(self):
        return self.population_criteria

    def get_population_criterion(self, key):
        return self.population_criteria.get(key)

    def print_summary(self, symbol_table, dc_set, html=True, prefix="<li>", suffix="</li>", text_prefix_add="   ", dc_verbose = False):
        for key in [LEXER.S_IPOP, LEXER.S_DENOM, LEXER.S_DENEX, LEXER.S_NUMER,
                    LEXER.S_NUMEX, LEXER.S_DENEXCEP, LEXER.S_STRAT]:
            print(prefix + token_name(key) + suffix)
            child_prefix=prefix
            if (html):
                print("<ul>")
            else:
                child_prefix =prefix + "      "
            criterion = self.get_population_criterion(token_name(key))
            if criterion == None:
                print(prefix + "None" + suffix)
            elif isinstance(criterion, list):
                for c in criterion:
                    c.print_summary(symbol_table, html, dc_set, prefix, suffix, text_prefix_add, dc_verbose)
            else:
                criterion.print_summary(symbol_table, html, dc_set, child_prefix, suffix, text_prefix_add, dc_verbose)
            if (html):
                print("</ul>")

    def dc_census(self, dc_set, symbol_table):
        for key in [LEXER.S_IPOP, LEXER.S_DENOM, LEXER.S_DENEX, LEXER.S_NUMER,
                    LEXER.S_NUMEX, LEXER.S_DENEXCEP]:
            criterion = self.get_population_criterion(token_name(key))
            if criterion != None:
                criterion.dc_census(dc_set, symbol_table)
            

class PopulationCriterion(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.preconditions = None

    def set_preconditions(self, preconditions):
        self.preconditions = preconditions

    def get_preconditions(self):
        if self.preconditions == None:
            return None
        return self.preconditions.get_preconditions()

    def get_type(self):
        return self.get_nested_dict_entry([LEXER.S_code, LEXER.A_code])

    def get_id(self):
        return self.get_nested_dict_entry([LEXER.S_id, LEXER.A_extension])

    def population_name(self):
        return self.get_id()

    def get_display_name(self):
        code = self.get_dict_entry(LEXER.S_code)
        if code == None:
            return None
        return code.get_display_name()
    
    def print_summary(self, symbol_table, dc_set, html=True, prefix="<li>", suffix="</li>", text_prefix_add="   ", dc_verbose = False, include_children=True):
        print(prefix + "ID: " + str(self.get_id()) + suffix)
        print(prefix + "Display name: " + str(self.get_display_name()) + suffix)
        print(prefix + "Type: " + str(self.get_type()) + suffix)
        if include_children:
            print(prefix + "Preconditions:" + suffix)
            child_prefix = prefix
            if html:
                print("<ul>")
            else:
                child_prefix = prefix + text_prefix_add
            for p in self.get_preconditions():
                p.print_summary(symbol_table, html, dc_set, child_prefix, suffix, text_prefix_add, dc_verbose)
            if html:
                print("</ul>")
        
    def dc_census(self, dc_set, symbol_table):
        for p in self.get_preconditions():
            p.dc_census(dc_set, symbol_table)

class PreconditionRhs(InfrastructureRoot):
    def __init__(self):
        InfrastructureRoot.__init__(self)
        self.symbol_table = SymbolTable()
        self.preconditions = []
    
    def add_precondition(self, precondition):
        self.preconditions.append(precondition)

    def get_preconditions(self):
        return self.preconditions

class Precondition(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.grouping = None

    def set_grouping(self, group):
        self.grouping = group

    def get_grouping(self):
        return self.grouping

    def get_raw_criteria_reference(self):
        return self.get_dict_entry(LEXER.S_criteriaReference)

    def get_criteria_reference_id(self):
        raw = self.get_raw_criteria_reference()
        if raw == None:
            return None
        return IiRhs.make_key(raw.get_nested_dict_entry([LEXER.S_id, LEXER.A_root]),
                              raw.get_nested_dict_entry([LEXER.S_id, LEXER.A_extension]))

    def follow_criteria_reference(self, symbol_table):
        id = self.get_criteria_reference_id()
        ref = symbol_table.get_data_criterion(id)
        if ref == None:
            ref = symbol_table.get_population_criterion(id)
        return ref

    def print_summary(self, symbol_table, dc_set, html=True, prefix="<li>", suffix="</li>", text_prefix_add="   ", dc_verbose = False):
        ref = self.follow_criteria_reference(symbol_table)
        if ref != None:
            self.print_ref_summary(ref, symbol_table, dc_set, html, prefix, suffix, text_prefix_add, dc_verbose)
        grp = self.get_grouping()
        if grp != None:
            self.print_group_summary(grp, symbol_table, dc_set, html, prefix, suffix, text_prefix_add, dc_verbose)

    def print_group_summary(self, grp, symbol_table, dc_set, html, prefix, suffix, text_prefix_add, dc_verbose):
        if grp.preconditions == None:
            return
        print(prefix + "Precondition - " + str(grp.grouping_type) + suffix)
        child_prefix = prefix
        if (html):
            print("<ul>")
        else:
            child_prefix = prefix + text_prefix_add
        for p in grp.get_preconditions():
            p.print_summary(symbol_table, dc_set, html, child_prefix, suffix, text_prefix_add, dc_verbose)
        if (html):
            print("</ul>")

    def print_ref_summary(self, ref, symbol_table, dc_set, html, prefix, suffix, text_prefix_add, dc_verbose):
        if isinstance(ref, DataCriterion):
            reftype = "data criterion"
        elif isinstance(ref, PopulationCriterion):
            reftype = "population criterion"
        else:
            reftype = str(type(ref))
        print(prefix + "Precondition - Criteria reference: (" + reftype + ")" + suffix)
        child_prefix = prefix
        if (html):
            print("<ul>")
        else:
            child_prefix = prefix + text_prefix_add
        if isinstance(ref, PopulationCriterion):
            ref.print_summary(symbol_table, dc_set, html, child_prefix, suffix, text_prefix_add, dc_verbose, False)
        else:
            ref.print_summary(symbol_table, dc_set, html, child_prefix, suffix, text_prefix_add, dc_verbose)
        if (html):
            print("</ul>")
            
    def dc_census(self, dc_set, symbol_table):
        ref = self.follow_criteria_reference(symbol_table)
        if isinstance(ref, DataCriterion):
            ref.dc_census(dc_set, symbol_table)
        grp = self.get_grouping()
        if grp != None:
            for p in grp.get_preconditions():
                p.dc_census(dc_set, symbol_table)

class TimeValue:
    def __init__(self):
        self.pivl_ts = None

class IvlBase(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

    def get_low(self):
        return self.get_dict_entry(LEXER.S_low)

    def get_high(self):
        return self.get_dict_entry(LEXER.S_high)

    def get_width(self):
        return self.get_dict_entry(LEXER.S_width)

    def get_low_closed(self):
        return self.get_dict_entry(LEXER.A_lowClosed)

    def get_high_closed(self):
        return self.get_dict_entry(LEXER.A_highClosed)

    def set_low(self, low):
        self.set_name_value_pair(token_name(LEXER.S_low), low)

    def set_high(self, high):
        self.set_name_value_pair(token_name(LEXER.S_high), high)

    def set_width(self, width):
        self.set_name_value_pair(token_name(LEXER.S_width), width)

    def set_low_closed(self, low_closed):
        self.set_name_value_pair(token_name(LEXER.A_lowClosed), low_closed)

    def set_high_closed(self, high_closed):
        self.set_name_value_pair(token_name(LEXER.A_highClosed), high_closed)


class IvlIntRhs(IvlBase):
    def __init__(self):
        IvlBase.__init__(self)
        self.original_text = None
        self.any_val = None

    def get_original_text(self):
        return self.original_text

    def get_any(self):
        return self.any_val

    def set_any(self, any_val):
        self.any_val = any_val

    def set_original_text(self, original_text):
        self.original_text = original_text

    def get_raw_low(self):
        return IvlBase.get_low(self)

    def get_raw_high(self):
        return IvlBase.get_high(self)

    def get_int(self, qty):
        retval = None
        if qty != None:
            val = qty.get_value()
            if val != None:
                try:
                    retval = int(val)
                except ValueError:
                    pass
        return retval

    def get_low(self):
        return self.get_int(self.get_raw_low())

    def get_high(self):
        return self.get_int(self.get_raw_high())
            


class PivlTs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.phase = None
        self.period = None
        self.frequency = None
        self.count = None
        self.alignment = None
        self.is_flexible = None

    def get_high_closed(self):
        if self.phase is None:
            return None
        return self.phase.high_closed()

    def get_low_closed(self):
        if self.phase is None:
            return None
        return self.phase.low_closed()

    def get_start_time(self, outer=True):
        return self.phase.get_start_time()

    def get_end_time(self, outer=True):
        return self.phase.get_end_time()

    # def explicit_start(self):
    #     if self.phase is None:
    #         return None
    #     return self.phase.explicit_start()

    # def explicit_end(self):
    #     if self.phase is None:
    #         return None
    #     return self.phase.explicit_end()

    # def explicit_width_value(self):
    #     if self.phase is None:
    #         return None
    #     return self.phase.explicit_width_value()

    # def explicit_width_unit(self):
    #     if self.phase is None:
    #         return None
    #     return self.phase.explicit_width_unit()

    def period_value(self):
        if self.period is None:
            return None
        return self.period.value

    def period_unit(self):
        if self.period is None:
            return None
        return self.period.unit

    def set_phase(self, phase):
        self.phase = phase
        self['phase'] = self.phase
    def set_period(self, period):
        period.make_numeric_val()
        self.period = period;
        self['period'] = self.period
    def set_frequency(self, frequency):
        self.frequency = frequency
        self['frequency'] = self.frequency
    def set_count(self, count):
        self.count = count
        self['count'] = self.count
    def set_alignment(self, alignment):
        self.alignment = alignment
        self['alignment'] = self.alignment
    def set_is_flexible(self, is_flexible):
        self.is_flexible = is_flexible
        self['is_flexible'] = self.is_flexible

class TsRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.qty = None

    def set_qty(self, qty):
        self.qty = qty
        self['qty'] = self.qty

    def set_value(self, val):
        self.value = val
        self['value'] = self.value

    def get_value(self):
        if self.qty != None:
            return self.qty.get_value()
        return None

class CsRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

class CdRhs(Code, BaseDictClass):
    def __init__(self):
        Code.__init__(self)
        BaseDictClass.__init__(self)
        self.translation = None
        self.originalText = None

    def set_translation(self, translation):
        self.translation = translation

    def set_original_text(self, original_text):
        self.originalText = original_text

    def get_translation(self):
        return self.translation

    def get_original_text(self):
        return self.originalText
        
    def get_raw_display_name(self):
        return self.displayName

    def get_display_name(self):
        if self.displayName == None:
            return None
        return self.displayName.get_value()

    def get_code(self):
        return self.get_dict_entry(LEXER.A_code)

    def get_code_system(self):
        return self.get_dict_entry(LEXER.A_codeSystem)
    
    def get_value_set(self):
        return self.get_dict_entry(LEXER.A_valueSet)        

class CountRhs(Excerpt, CdRhs):
    def __init__(self):
        Excerpt.__init__(self)
        CdRhs.__init__(self)

class MeasureAttrValueRhs(CdRhs):
    def __init__(self):
        CdRhs.__init__(self)

class StRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.translation = None
        self.value = None
        self.language = None

    def set_translation(self, translation):
        self.transltion = translation
        self['translation'] = self.translation

    def get_translation(self):
        return self.transltion

    def set_value(self, value):
        self.value = value
        self['value'] = self.value

    def get_value(self):
        return self.value

    def set_language(self, language):
        self.language = language
        self['language'] = self.language

    def get_language(self):
        return self.language

class ScRhs(StRhs):
    def __init__(self):
        StRhs.__init__(self)
        self.code = None

    def set_code(self, code):
        self.code = code
        self['code'] = self.code
        

class IvlTsRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.original_text = None

    def set_original_text(self, text):
        self.original_text = text

    def set_ts(self, ts_rhs):
        self.ts = ts_rhs

    def set_qty(self, qty_rhs):
        self.qty = qty_rhs

    def high_closed(self):
        return self._closed(token_name(LEXER.A_highClosed))

    def low_closed(self):
        return self._closed(token_name(LEXER.A_lowClosed))

    def _closed(self, highlow):
        retval = self.get_dict_entry(highlow)
        if retval is None:
            # default is inclusive
            retval = True
        return retval

    def get_raw_high(self):
        return self.get_dict_entry(LEXER.S_high)

    def get_raw_low(self):
        return self.get_dict_entry(LEXER.S_low)

    def get_raw_width(self):
        return self.get_dict_entry(LEXER.S_width)

    def get_x_value(self, x):
        if x == None:
            return None
        return x.get_value()

    def get_high_value(self):
        return self.get_x_value(self.get_raw_high())

    def get_low_value(self):
        return self.get_x_value(self.get_raw_low())

    def get_width_value(self):
        return self.get_x_value(self.get_raw_width())

    def get_width_unit(self):
        w = self.get_raw_width()
        if w == None:
            return None
        return w.get_unit()

    def width_as_timedelta(self):
        val = self.get_width_value()
        unit=self.get_width_unit()
        if val == None or unit == None:
            return None
        if unit == 'a' or unit == 'year':
            return timedelta(days=365*val)
        if unit == 'wk' or unit == 'week':
            return timedelta(days = 7*val)
        if unit == 'd' or unit == 'day':
            return timedelta(days = val)
        return None

    def get_start_time(self, outer=True):
        low = self.get_low_value()
        if low != None:
            return low
        high = self.get_high_value()
        width = self.width_as_timedelta()
        if high != None and width != None:
            return high - width

    def get_end_time(self, outer=True):
        high = self.get_high_value()
        if high != None:
            return high
        low = self.get_low_value()
        width = self.width_as_timedelta()
        if low != None and width != None:
            return low + width

    # def explicit_start(self):
    #     return self.qty_value_from_value_dict(token_name(LEXER.S_low))

    # def explicit_end(self):
    #     return self.qty_value_from_value_dict(token_name(LEXER.S_high))

    # def explicit_width_value(self):
    #     width = self._width()
    #     if width is None:
    #         return None
    #     return width.value

    # def explicit_width_unit(self):
    #     width = self._width()
    #     if width is None:
    #         return None
    #     return width.unit

    # def _width(self):
    #     return self.get_dict_entry(LEXER.S_width)

    # def qty_value_from_value_dict(self, string):
    #     val = self.get_dict_entry(string)
    #     if val is None:
    #         return None
    #     qty = val.qty
    #     if qty is None:
    #         return None
    #     return qty.value

class EdRhs:
    def __init__(self):
        self.entries = dict()
    def set_entry(self, key, val):
        self.entries[key] = val

class QtyRhs(Any):
    date_pattern=re.compile('^[0-9]{8,8}$')
    def __init__(self):
        Any.__init__(self)
        self.value = None
        self.expression = None
        self.original_text = None
        self.uncertainty = None
        self.uncertain_range = None
        self.unit = None
        self.value_type = None
        self.string_value = None

    def set_value(self, val):
        self.string_value = val
        if self.value_type == token_name(LEXER.S_PQ):
            self.value = string_to_number(val)
        elif self.date_pattern.match(val):
            self.value=date(int(val[:4]), int(val[4:6]), int(val[6:]))
        else:
            self.value = val

    def make_numeric_val(self):
        # Called when we're pretty sure the value should be numeric, regardless of value_type
        if self.string_value is None:
            self.string_value = self.value
        try:
            self.value = string_to_number(self.string_value)
        except TypeError:
            pass

    def set_expression(self, ed_rhs):
        self.value = ed_rhs

    def set_original_text(self, ed_rhs):
        self.original_text = ed_rhs

    def set_uncertainty(self, ivl_quantity_rhs):
        self.uncertainty = ivl_quantity_rhs

    def set_uncertain_range(self, ivl_quantity_rhs):
        self.uncertain_range = ivl_quantity_rhs

    def set_unit(self, val):
        self.unit = val

    def set_value_type(self, val):
        self.value_type = val
        if self.value_type == token_name(LEXER.S_PQ) and isinstance(self.value, str):
            self.value = string_to_number(self.value)

    def get_value(self):
        return(self.value)

    def get_unit(self):
        return(self.unit)


class IvlQtyRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

class IvlPqRhs(IvlBase):
    def __init__(self):
        IvlBase.__init__(self)
        

class PqRhs(QtyRhs):
    def __init__(self):
        QtyRhs.__init__(self)
        self.translation = None
        self.codingRationale = None

class IiRhs(Hl7_id, BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

    def get_root(self):
        return self.get_dict_entry(LEXER.A_root)

    def get_extension(self):
        return self.get_dict_entry(LEXER.A_extension)

    def get_identifier_name(self):
        return self.get_dict_entry(LEXER.A_identifierName)

    def get_displayable(self):
        return self.get_dict_entry(LEXER.A_displayable)

    def get_scope(self):
        return self.get_dict_entry(LEXER.A_scope)

    def get_reliablilty(self):
        return self.get_dict_entry(LEXER.A_reliability)



class ListIiRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)
        self.ids = []
        self['ids'] = self.ids

    def add_ii_rhs(self, ii_rhs):
        self.ids.append(ii_rhs)

    def get_ids(self):
        return self.ids

class TemporallyRelatedRhs(BaseDictClass):
    def __init__(self):
        BaseDictClass.__init__(self)

    def get_type_code(self):
        return self.get_dict_entry(LEXER.A_typeCode)

    def get_criteria_reference(self):
        return self.get_dict_entry(LEXER.S_criteriaReference)

    def get_temporal_information(self):
        return self.get_dict_entry(LEXER.C_qdm_temporalInformation)

    def get_precision(self):
        ti = self.get_temporal_information()
        if ti == None:
            return None
        return ti.get_precision()

    def get_low(self):
        ti = self.get_temporal_information()
        if ti == None:
            return None
        return ti.get_low()

    def get_high(self):
        ti = self.get_temporal_information()
        if ti == None:
            return None
        return ti.get_high()

    def get_low_closed(self):
        ti = self.get_temporal_information()
        if ti == None:
            return None
        return ti.get_low_closed()

    def get_high_closed(self):
        ti = self.get_temporal_information()
        if ti == None:
            return None
        return ti.get_high_closed()


class SymbolTableBuilder(HQMFv2JSONParserListener):
    def __init__(self):
        self.measure = Measure()
        self.symbol_table = self.measure.get_symbol_table()

    def unimplemented(self, ctx):
        pass

    def get_measure(self):
        return self.measure

    def enterMeasure_period(self, ctx):
        ctx.parsed_measure_period = MeasurePeriod()

    def exitMeasure_period(self, ctx):
        self.symbol_table.set_measure_period(ctx.parsed_measure_period)

    def enterMeasurePeriodTimeValue(self, ctx):
        ctx.parsed_time_element = PivlTs()

    def exitMeasurePeriodTimeValue(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_measure_period'):
            ctx.parentCtx.parsed_measure_period.set_time_value(ctx.parsed_time_element)

        

    def enterPivlTsPhase(self, ctx):
        ctx.parsed_ivl_ts_rhs = IvlTsRhs()

    def exitPivlTsPhase(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_time_element'):
            ctx.parentCtx.parsed_time_element.set_phase(ctx.parsed_ivl_ts_rhs)

    def enterIvl_ts_rhs(self, ctx):
        ctx.parsed_ivl_ts_rhs = ctx.parentCtx.parsed_ivl_ts_rhs

    def enterIvlTsOriginalText(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitIvlTsOriginalText(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ivl_ts_rhs'):
            ctx.parentCtx.parsed_ivl_ts_rhs.set_original_text(ctx.parsed_ed_rhs)

    def enterEd_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ed_rhs'):
            ctx.parsed_ed_rhs = ctx.parentCtx.parsed_ed_rhs

    def enterEdSimpleKeywordEntry(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ed_rhs'):
            ctx.parentCtx.parsed_ed_rhs.set_entry(self.token2string(ctx.ed_simple_keyword()),
                                                  self.token2string(ctx.any_string()))

    def enterCdOriginalText(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitCdOriginalText(self, ctx):
        ctx.parentCtx.parsed_cd_rhs.set_original_text(ctx.parsed_ed_rhs)
#         if hasattr(ctx.parentCtx, 'parsed_data_criterion'):
#             ctx.parentCtx.parsed_data_criterion.set_original_text(ctx.parsed_ed_rhs)

    def enterTime_value(self, ctx):
        ctx.parsed_time_value = ctx.parentCtx.parsed_time_element

    def enterTime_element(self, ctx):
        ctx.parsed_time_element = ctx.parentCtx.parsed_time_value

    def enterIvlTsBoolean(self, ctx):
        ctx.parentCtx.parsed_ivl_ts_rhs.set_name_value_pair(self.token2string(ctx.ivl_ts_boolean_keyword()),
                                                            self.token2boolean(ctx.boolean_string_value()))

    def enterIvlTsTs(self, ctx):
        ctx.parsed_ts_rhs = TsRhs()
        ctx.parsed_ts_keyword = self.token2string(ctx.ivl_ts_ts_keyword())

    def exitIvlTsTs(self, ctx):
        ctx.parentCtx.parsed_ivl_ts_rhs.set_name_value_pair(ctx.parsed_ts_keyword,
                                                            ctx.parsed_ts_rhs)
    
    def enterTs_rhs(self, ctx):
        ctx.parsed_ts_rhs = ctx.parentCtx.parsed_ts_rhs

    def enterTSQty(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def enterQtyAny(self, ctx):
        ctx.parsed_any_rhs = ctx.parentCtx.parsed_qty_rhs

    def enterQty_rhs(self, ctx):
        ctx.parsed_qty_rhs = ctx.parentCtx.parsed_qty_rhs

    def enterAnyHxit(self, ctx):
        ctx.parsed_hxit_rhs = ctx.parentCtx.parsed_any_rhs

    def enterAnyAny(self, ctx):
        ctx.parentCtx.parsed_any_rhs.set_name_value_pair(self.token2string(ctx.qdm_any_attribute()),
                                                         self.token2string(ctx.any_string()))

    def enterHxit_entry(self, ctx):
        ctx.parentCtx.parsed_hxit_rhs.set_name_value_pair(self.token2string(ctx.hxit_attribute()),
                                                          self.token2string(ctx.any_string()))

    def enterQtyValue(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_qty_rhs'):
            ctx.parentCtx.parsed_qty_rhs.set_value(self.token2string(ctx.any_string()))


    def enterQtyUnit(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_qty_rhs'):
            ctx.parentCtx.parsed_qty_rhs.set_unit(self.token2string(ctx.any_string()))

    def enterQtyType(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_qty_rhs'):
            ctx.parentCtx.parsed_qty_rhs.set_value_type(self.token2string(ctx.any_string()))


    def enterQtyExpression(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitQtyExpression(self, ctx):
        ctx.parentCtx.parsed_qty_rhs.set_expression(ctx.parsed_ed_rhs)

    def enterQtyOriginalText(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitQtyOriginalText(self, ctx):
        ctx.parentCtx.parsed_qty_rhs.set_original_tex(ctx.parsed_ed_rhs)

    def enterQtyUncertainty(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitQtyUncertainty(self, ctx):
        ctx.parentCtx.parsed_qty_rhs.set_expression(ctx.parsed_qty_rhs)

    def enterQtyUncertainRange(self, ctx):
        ctx.parsed_ivl_qty_rhs = IvlQtyRhs()

    def exitQtyUncertainRange(self, ctx):
        ctx.parentCtx.parsed_qty_rhs.set_uncertain_range(ctx.parsed_ivl_qty_rhs)

    def enterIvlQtyOriginalText(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitIvlQtyOriginalText(self, ctx):
        ctx.parentCtx.parsed_ivl_qty_rhs.set_name_value_pair(self.token2string(ctx.S_originalText()),
                                                             ctx.parsed_ed_rhs)

    def enterIvlQtyQty(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlQtyQty(self, ctx):
        ctx.parentCtx.parsed_ivl_qty_rhs.set_name_value_pair(self.token2string(ctx.ivl_qty_qty_keyword()),
                                                             ctx.parsed_ed_rhs)

    def enterIvlQtyBoolean(self, ctx):
        ctx.parentCtx.parsed_ivl_qty_rhs.set_name_value_pair(self.token2string(ctx.ivl_qty_boolean_keyword()),
                                                             self.token2boolan(ctx.boolean_string_value()))

    def enterIvlTsQty(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlTsQty(self, ctx):
        ctx.parentCtx.parsed_ivl_ts_rhs.set_name_value_pair(self.token2string(ctx.ivl_ts_qty_keyword()),
                                                            ctx.parsed_qty_rhs)

    def exitTSQty(self, ctx):
        ctx.parentCtx.parsed_ts_rhs.set_qty(ctx.parsed_qty_rhs)

    def enterTSValue(self, ctx):
        ctx.parentCtx.parsed_ts_rhs.set_value(self.token2string(ctx.any_string()))

    def enter_qty_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_qty_rhs'):
            ctx.parsed_qty_rhs = ctx.parentCtx.parsed_qty_rhs

    def enterPivlTsPeriod(self, ctx):
        ctx.parsed_pq_rhs = PqRhs()

    def exitPivlTsPeriod(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_time_element'):
            ctx.parentCtx.parsed_time_element.set_period(ctx.parsed_pq_rhs)


    def enterPq_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_pq_rhs'):
            ctx.parsed_pq_rhs = ctx.parentCtx.parsed_pq_rhs
            ctx.parsed_qty_rhs = ctx.parentCtx.parsed_pq_rhs

    def enterPq_entry(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_pq_rhs'):
            ctx.parsed_pq_rhs = ctx.parentCtx.parsed_pq_rhs
        if hasattr(ctx.parentCtx, 'parsed_qty_rhs'):
            ctx.parsed_qty_rhs = ctx.parentCtx.parsed_qty_rhs

    def enterData_criterion(self, ctx):
        ctx.parsed_data_criterion = DataCriterion()

    def enterData_criterion_entry(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def exitData_criterion(self, ctx):
        dc = ctx.parsed_data_criterion
        if not hasattr(dc, 'effective_value'):
            dc.set_effective_value(dc.value)
            
        if dc is not None:
                 self.symbol_table.add_data_criterion(dc)

    def enterDCM_localVariableName(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name(self.token2string(ctx.any_string()))

    def enterObservation_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def exitObservation_criterion(self, ctx):
        code = ctx.parsed_data_criterion.get_raw_code()
        if code is None or code.get_value_set() is None:
            ctx.parsed_data_criterion.set_code_list(ctx.parsed_data_criterion.get_value())
            ctx.parsed_data_criterion.set_effective_value(None)
        else:
            ctx.parsed_data_criterion.set_code_list(code)            


    def enterEncounter_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def exitEncounter_criterion(self, ctx):
        ctx.parsed_data_criterion.set_code_list(ctx.parsed_data_criterion.get_raw_code())
        
        

    def enterSubstance_administration_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterGrouper_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def exitGrouper_criterion(self, ctx):
        pass

    def enterResult_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterProcedure_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion        

    def exitProcedure_criterion(self, ctx):
        ctx.parsed_data_criterion.set_code_list(ctx.parsed_data_criterion.get_raw_code())

    def enterAct_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion        

    def exitAct_criterion(self, ctx):
        ctx.parsed_data_criterion.set_code_list(ctx.parsed_data_criterion.get_raw_code())


    def enterRecentDataCriterion(self, ctx):
        # Here for convenience, but will be ignored
        ctx.parsed_data_criterion = DataCriterion()

    def enterLabelled_data_criterion(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterGRP_TemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitGRP_TemplateId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_template_ids(ctx.parsed_list_ii_rhs)

    def enterGRP_generic(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterDC_repeatNumber(self, ctx):
        ctx.parsed_ivl_int_rhs = IvlIntRhs()

    def exitDC_repeatNumber(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_repeat_number(ctx.parsed_ivl_int_rhs)

    def enterEC_generic(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterEC_TemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitEC_TemplateId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_template_ids(ctx.parsed_list_ii_rhs)
        
    def enterPRC_generic(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterPRC_TemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitPRC_TemplateId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_template_ids(ctx.parsed_list_ii_rhs)        

    def enterACT_generic(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterACT_TemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitACT_TemplateId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_template_ids(ctx.parsed_list_ii_rhs)        


    def enterSA_generic(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterSA_TemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitSA_TemplateId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_template_ids(ctx.parsed_list_ii_rhs)


    def enterRC_generic(self, ctx):
        ctx.parsed_data_criterion = DataCriterion()

    def exitRC_generic(self, ctx):
        ctx.parentCtx.parsed_result_entry.set_child_data_criterion(ctx.parsed_data_criterion)

    def enterTR_infrastructure(self, ctx):
        ctx.parsed_temporally_related_rhs = ctx.parentCtx.parsed_temporally_related_rhs
        ctx.parsed_infrastructure = ctx.parentCtx.parsed_temporally_related_rhs

    def enterDC_infrastructure(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        ctx.parsed_infrastructure = ctx.parsed_data_criterion

    def enterDC_boolean(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(self.token2string(ctx.dc_boolean_keyword()),
                                                                self.token2boolean(ctx.boolean_string_value()))

    def enterDC_cs(self, ctx):
        ctx.parsed_cs_rhs = CsRhs()
    def exitDC_cs(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(self.token2string(ctx.dc_cs_keyword()),
                                                                ctx.parsed_cs_rhs)

    def enterDC_cd(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()
    def exitDC_cd(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(self.token2string(ctx.dc_cd_keyword()),
                                                                ctx.parsed_cd_rhs)

    def enterDC_ivl_ts(self, ctx):
        ctx.parsed_ivl_ts_rhs = IvlTsRhs()
    def exitDC_ivl_ts(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(self.token2string(ctx.dc_ivl_ts_keyword(),
                                                                                  ctx.parsed_ivl_ts_rhs))

    def enterDC_title(self, ctx):
        ctx.parentCtx.parsed_data_criterion.title = self.token2string(ctx.any_string())

    def enterDC_ts(self, ctx):
        ctx.parsed_ts_rhs = TsRhs()
    def exitDC_ts(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(self.token2string(ctx.dc_ts_keyword(),
                                                                                  ctx.parsed_ts_rhs))

    def enterDC_dset_cd(self, ctx):
        ctx.parsed_dset_cd_rhs = DsetCdRhs()

    def exitDC_dset_cd(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(self.token2string(ctx.dc_dset_cd_keyword()),
                                                                ctx.parsed_dset_cd_rhs)

    def enterDC_value(self, ctx):
        ctx.parsed_value_rhs = ValueRhs()

    def exitDC_value(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_value(ctx.parsed_value_rhs)

    def enterCs_entry(self, ctx):
        ctx.parentCtx.parsed_cs_rhs.set_name_value_pair(self.token2string(ctx.cs_keyword()),
                                                        self.token2string(ctx.any_string()))

    def enterCs_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_cs_rhs'):
            ctx.parsed_cs_rhs = ctx.parentCtx.parsed_cs_rhs
        else:
            ctx.parsed_cs_rhs = CsRhs()
            self.unimplemented(ctx)

    def enterScSt(self, ctx):
        ctx.parsed_st_rhs = ctx.parentCtx.parsed_sc_rhs
        
    def enterScCode(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitScCode(self, ctx):
        ctx.parentCtx.parsed_sc_rhs.set_code(ctx.parsed_cd_rhs)

    def enterDC_id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitDC_id(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_id(ctx.parsed_ii_rhs)

    def enterDC_excerpt(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterEX_recent(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_recent(True)
        
    def enterEX_count(self, ctx):
        ctx.parsed_count_rhs = CountRhs()
        
    def exitEX_count(self, ctx):
        # Terrible hack for cumulative_medication_duration
        d = ctx.parsed_count_rhs.get_data_criterion()
        if d != None:
            field_value = d.get_raw_field_value()
            if field_value != None and field_value.get_field_template_id() == token_name(LEXER.C_HQMF_TMPL_CUMULATIVE_MEDICAL_DURATION):
                ctx.parentCtx.parsed_data_criterion.set_field_value(field_value)
                return
        ctx.parentCtx.parsed_data_criterion.set_count(ctx.parsed_count_rhs)
        
    def enterEX_sequence(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterSequence_rhs(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterSE_sequence(self, ctx):        
        ctx.parentCtx.parsed_data_criterion.set_sequence_number(string_to_number(self.token2string(ctx.any_string())))

    def enterSE_dc(self, ctx):
        # We're just going to ignore this
        ctx.parsed_data_criterion = DataCriterion()
        
    def enterCount_rhs(self, ctx):
        ctx.parsed_count_rhs = ctx.parentCtx.parsed_count_rhs

    def enterCOUNT_RHS_subset(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitCOUNT_RHS_subset(self, ctx):
        ctx.parentCtx.parsed_count_rhs.set_name_value_pair(self.token2string(ctx.subset_keyword()),
                                                           ctx.parsed_cd_rhs)

    def enterCOUNT_RHS_data_criterion(self, ctx):
        ctx.parsed_data_criterion = DataCriterion()

    def exitCOUNT_RHS_data_criterion(self, ctx):
        ctx.parentCtx.parsed_count_rhs.add_data_criterion(ctx.parsed_data_criterion)

#    def enterDC_code(self, ctx):
#        ctx.parsed_cd_rhs = CdRhs()
#
#    def exitDC_code(self, ctx):
#        ctx.parentCtx.parsed_data_criterion.set_code(ctx.parsed_cd_rhs)

    def enterCd_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_cd_rhs'):
            ctx.parsed_cd_rhs = ctx.parentCtx.parsed_cd_rhs
        else:
            ctx.parsed_cd_rhs = CdRhs()
            self.unimplemented(ctx)

    def enterCdKeywordEntry(self, ctx):
        ctx.parentCtx.parsed_cd_rhs.set_name_value_pair(self.token2string(ctx.cd_simple_keyword()),
                                                        self.token2string(ctx.any_string()))

    def enterCdTranslation(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitCdTranslation(self, ctx):
        ctx.parentCtx.parsed_cd_rhs.set_translation(ctx.parsed_st_rhs)

    def enterCdDisplayName(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitCdDisplayName(self, ctx):
        ctx.parentCtx.parsed_cd_rhs.set_display_name(ctx.parsed_st_rhs)


    def enterIrTemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitIrTemplateId(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_infrastructure'):
            ctx.parentCtx.parsed_infrastructure.set_name_value_pair(token_name(LEXER.S_templateId), ctx.parsed_list_ii_rhs.get_ids())

    def enterIrRealmCode(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitIrRealmCode(self, ctx):
        ctx.parentCtx.parsed_infrastructure.set_name_value_pair(token_name(LEXER.S_typeId), ctx.parsed_ii_rhs)

    def enterIrTypeId(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitIrTypeId(self, ctx):
        ctx.parentCtx.parsed_infrastructure.set_name_value_pair(token_name(LEXER.S_typeId), ctx.parsed_ii_rhs)

    def enterList_ii_rhs(self, ctx):
        if hasattr(ctx.parentCtx, "parsed_list_ii_rhs"):
            ctx.parsed_list_ii_rhs = ctx.parentCtx.parsed_list_ii_rhs
        else:
            ctx.parsed_list_ii_rhs = ListIiRhs()
            self.unimplemented(ctx)

#    def enterList_ii_status_rhs(self, ctx):
#        ctx.parsed_list_ii_rhs = ctx.parentCtx.parsed_list_ii_rhs


    def enterIi_item(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitIi_item(self, ctx):
        ctx.parentCtx.parsed_list_ii_rhs.add_ii_rhs(ctx.parsed_ii_rhs)

    def enterIi_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ii_rhs'):
            ctx.parsed_ii_rhs = ctx.parentCtx.parsed_ii_rhs
        else:
            ctx.parsed_ii_rhs = IiRhs()

#    def enterIi_status_rhs(self, ctx):
#        ctx.parsed_ii_rhs = ctx.parentCtx.parsed_ii_rhs

#    def enterIi_status_item(self, ctx):
#        ctx.parsed_ii_rhs = IiRhs()

#    def exitIi_status_item(self, ctx):
#        ctx.parentCtx.parsed_list_ii_rhs.add_ii_rhs(ctx.parsed_ii_rhs)


    def enterIi_entry(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ii_rhs'):
            ctx.parentCtx.parsed_ii_rhs.set_name_value_pair(self.token2string(ctx.ii_keyword()), self.token2string(ctx.any_string()))

#    def enterIi_status_entry(self, ctx):
#        ctx.parsed_ii_rhs = ctx.parentCtx.parsed_ii_rhs

#    def enterII_status_misc(self, ctx):
#        ctx.parentCtx.parsed_ii_rhs.set_name_value_pair(self.token2string(ctx.ii_misc_keyword()), self.token2string(ctx.any_string()))

    def enterSt_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_st_rhs'):
            ctx.parsed_st_rhs = ctx.parentCtx.parsed_st_rhs
        else:
            ctx.parsed_st_rhs = StRhs()
            self.unimplemented(ctx)

    def enterStTranslation(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitStTranslation(self, ctx):
        ctx.parentCtx.set_translation(ctx.parsed_st_rhs)

    def enterStValue(self, ctx):
        ctx.parentCtx.parsed_st_rhs.set_value(self.token2string(ctx.any_string()))

    def enterStLanguage(self, ctx):
        ctx.parentCtx.parsed_st_rhs.set_language(self.token2string(ctx.any_string()))


    def enterDC_participation(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterParticipation_rhs(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterParticipation_material(self, ctx): 
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion   
    
    def enterPART_role(self, ctx):     
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterRole_rhs(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion
        
    def enterRole_playing_material(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion  
        
    def enterPlaying_material_rhs(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion          
        
    def enterPlaying_material_code(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()
        
    def exitPlaying_material_code(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_name_value_pair(token_name(LEXER.S_code), ctx.parsed_cd_rhs)
        ctx.parentCtx.parsed_data_criterion.set_code_list(ctx.parsed_cd_rhs)
        
    def enterDset_cd_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_dset_cd_rhs'):
            ctx.parsed_dset_cd_rhs = ctx.parentCtx.parsed_dset_cd_rhs
        else:
            ctx.parsed_dset_cd_rhs = DsetCdRhs()
            self.unimplemented()

    def enterDset_cd_item(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitDset_cd_item(self, ctx):
        ctx.parentCtx.parsed_dset_cd_rhs.add_item(ctx.parsed_cd_rhs)

    def enterIvl_int_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ivl_int_rhs'):
            ctx.parsed_ivl_int_rhs = ctx.parentCtx.parsed_ivl_int_rhs
        else:
            ctx.parsed_ivl_int_rhs = IvlIntRhs()
            self.unimplemented()

    def enterIvlIntOriginalText(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitIvlIntOriginalText(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_original_text(ctx.parsed_ed_rhs)

    def enterIvlIntLow(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlIntLow(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_low(ctx.parsed_qty_rhs)

    def enterIvlIntHigh(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlIntHigh(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_high(ctx.parsed_qty_rhs)


    def enterIvlIntany(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlIntAny(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_any(ctx.parsed_qty_rhs)


    def enterIvlIntWidth(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlIntWidth(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_width(ctx.parsed_qty_rhs)

    def enterIvlIntLowClosed(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_low_closed(self.token2boolean(ctx.boolean_string_value()))

    def enterIvlIntHighClosed(self, ctx):
        ctx.parentCtx.parsed_ivl_int_rhs.set_high_closed(self.token2boolean(ctx.boolean_string_value()))


    def enterValue_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_value_rhs'):
            ctx.parsed_value_rhs = ctx.parentCtx.parsed_value_rhs
        else:
            ctx.parsed_value_rhs = ValueRhs()
            self.unimplemented(ctx)

    def enterValueSet(self, ctx):
        ctx.parsed_value_set_rhs = ValueSetRhs()

    def exitValueSet(self, ctx):
        ctx.parentCtx.parsed_value_rhs.set_value(ctx.parsed_value_set_rhs)

    def enterValue_set_rhs(self, ctx):
        ctx.parsed_value_set_rhs = ctx.parentCtx.parsed_value_set_rhs

    def enterValueCode(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitValueCode(self, ctx):
        ctx.parentCtx.parsed_value_rhs.set_value(ctx.parsed_cd_rhs)

    def enterValueIvlPQ(self, ctx):
        ctx.parsed_ivl_pq_rhs = IvlPqRhs()

    def exitValueIvlPQ(self, ctx):
        ctx.parentCtx.parsed_value_rhs.set_value(ctx.parsed_ivl_pq_rhs)

    def enterValue_ivl_pq_rhs(self, ctx):
        ctx.parsed_ivl_pq_rhs = ctx.parentCtx.parsed_ivl_pq_rhs

    def enterValue_code_rhs(self, ctx):
        ctx.parsed_cd_rhs = ctx.parentCtx.parsed_cd_rhs

    def enterVS_valueSet(self, ctx):
        ctx.parentCtx.parsed_value_set_rhs.set_value_set(self.token2string(ctx.any_string()))

    def enterValueAnyNonNull(self, ctx):
        ctx.parentCtx.parsed_value_rhs.set_value(ValueAnyNonNullRhs())


    def enterVS_displayName(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitVS_displayName(self, ctx):
        ctx.parentCtx.parsed_value_set_rhs.set_display_name(ctx.parsed_st_rhs)

    def enterDC_temporallyRelated(self, ctx):
        ctx.parsed_temporally_related_rhs = TemporallyRelatedRhs()

    def exitDC_temporallyRelated(self, ctx):
        ctx.parentCtx.parsed_data_criterion.add_temporally_related(ctx.parsed_temporally_related_rhs)

    def enterTemporally_related_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_temporally_related_rhs'):
            ctx.parsed_temporally_related_rhs = ctx.parentCtx.parsed_temporally_related_rhs
        else:
            ctx.parsed_temporally_related_rhs = TemporallyRelatedRhs()
            self.unimplemented()

    def enterTR_SequenceNumber(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.S_sequenceNumber),
                                                                                   string_to_number(ctx.integer_string_value()))

    def enterTR_PauseQuantity(self, ctx):
        ctx.parsed_pq_rhs = PqRhs()

    def exitTR_PauseQuantity(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.S_pauseQuantity), ctx.parsed_pq_rhs)

    def enterTR_LocalVariableName(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitTR_LocalVariableName(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.S_localVariableName), ctx.parsed_st_rhs)

    def enterTR_SubsetCode(self, ctx):
        ctx.parsed_cs_rhs = ScRhs()

    def exitTR_SubsetCode(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.S_subsetCode), ctx.parsed_cs_rhs)

    def enterTR_typeCode(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.A_typeCode),
                                                                        self.token2string(ctx.temporal_operator()))

    def enterTR_TemporalInformation(self, ctx):
        ctx.parsed_temporal_information_rhs = TemporalInformationRhs()
    def exitTR_TemporalInformation(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.C_qdm_temporalInformation),
                                                                        ctx.parsed_temporal_information_rhs)

    def enterTR_CriteriaReference(self, ctx):
        ctx.parsed_criteria_reference_rhs = CriteriaReferenceRhs()
    def exitTR_CriteriaReference(self, ctx):
        ctx.parentCtx.parsed_temporally_related_rhs.set_name_value_pair(token_name(LEXER.S_criteriaReference),
                                                                        ctx.parsed_criteria_reference_rhs)

    def enterCriteria_reference_rhs(self, ctx):
        ctx.parsed_criteria_reference_rhs = ctx.parentCtx.parsed_criteria_reference_rhs

    def enterCritRef_InfrastructureRoot(self, ctx):
        ctx.parsed_criteria_reference_rhs = ctx.parentCtx.parsed_criteria_reference_rhs
        ctx.parsed_infrastructure = ctx.parentCtx.parsed_criteria_reference_rhs

    def enterCritRefClassCode(self, ctx):
        ctx.parentCtx.parsed_criteria_reference_rhs.set_name_value_pair(token_name(LEXER.A_classCode),
                                                                        self.token2string(ctx.any_string()))

    def enterCritRefMoodCode(self, ctx):
        ctx.parentCtx.parsed_criteria_reference_rhs.set_name_value_pair(token_name(LEXER.A_moodCode),
                                                                        self.token2string(ctx.any_string()))

    def enterCritRef_Id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitCritRef_Id(self, ctx):
        ctx.parentCtx.parsed_criteria_reference_rhs.set_name_value_pair(token_name(LEXER.S_id),
                                                                        ctx.parsed_ii_rhs)

    def enterCritRef_temporallyRelated(self, ctx):
        ctx.parsed_temporally_related_rhs = TemporallyRelatedRhs()

    def exitCritRef_temporallyRelated(self, ctx):
        ctx.parentCtx.parsed_criteria_reference_rhs.set_name_value_pair(token_name(LEXER.S_temporallyRelatedInformation),
                                                                        ctx.parsed_temporally_related_rhs)

    def enterTemporal_information_rhs(self, ctx):
        ctx.parsed_temporal_information_rhs = ctx.parentCtx.parsed_temporal_information_rhs

    def enterTI_who(self, ctx):
        ctx.parsed_temporal_information_attribute_rhs = TemporalInformationAttributeRhs()
    def exitTI_who(self, ctx):
        ctx.parentCtx.parsed_temporal_information_rhs.set_name_value_pair(self.token2string(ctx.ti_who_keyword()),
                                                                          ctx.temporal_information_attribute_rhs)

    def enterTIAttr_id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitTIAttr_id(self, ctx):
        ctx.parentCtx.parsed_temporal_information_attribute_rhs.set_name_value_pair(token_name(LEXER.S_id),
                                                                                    ctx.parsed_ii_rhs)

    def enterTIAttr_name(self, ctx):
        ctx.parentCtx.parsed_temporal_information_attribute_rhs.set_name_value_pair(token_name(LEXER.A_name),
                                                                                    self.token2string(ctx.any_string()))

    def enterTIAttr_bound(self, ctx):
        ctx.parentCtx.parsed_temporal_information_attribute_rhs.set_name_value_pair(token_name(LEXER.A_bound),
                                                                                    self.token2string(ctx.ti_bound_keyword()))

    def enterTI_delta(self, ctx):
        ctx.parsed_ivl_pq_rhs = IvlPqRhs()

    def exitTI_delta(self, ctx):
        ctx.parentCtx.parsed_temporal_information_rhs.set_name_value_pair(token_name(LEXER.C_qdm_delta),
                                                                          ctx.parsed_ivl_pq_rhs)

    def enterTI_precisionUnit(self, ctx):
        ctx.parentCtx.parsed_temporal_information_rhs.set_name_value_pair(token_name(LEXER.A_precisionUnit),
                                                                          self.token2string(ctx.any_string()))

    def enterIvl_pq_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_ivl_pq_rhs'):
            ctx.parsed_ivl_pq_rhs = ctx.parentCtx.parsed_ivl_pq_rhs
        else:
            ctx.parsed_ivl_pq_rhs = IvlPqRhs()
            self.unimplemented()

    def enterIvlPqOriginalText(self, ctx):
        ctx.parsed_ed_rhs = EdRhs()

    def exitIvlPqOriginalText(self, ctx):
        ctx.parentCtx.parsed_ivl_pq_rhs.set_name_value_pair(token_name(LEXER.S_originalText), ctx.parsed_ed_rhs)

    def enterIvlPqPq(self, ctx):
        ctx.parsed_pq_rhs = PqRhs()

    def exitIvlPqPq(self, ctx):
        ctx.parentCtx.parsed_ivl_pq_rhs.set_name_value_pair(self.token2string(ctx.ivl_pq_pq_keyword()), ctx.parsed_pq_rhs)

    def enterIvlPqBoolean(self, ctx):
        ctx.parentCtx.parsed_ivl_pq_rhs.set_name_value_pair(self.token2string(ctx.ivl_pq_boolean_keyword()),
                                                            self.token2boolean(ctx.boolean_string_value()))

    def enterPqWidth(self, ctx):
        ctx.parsed_qty_rhs = QtyRhs()

    def exitIvlPqWidth(self, ctx):
        ctx.parentCtx.parsed_ivl_pq_rhs.set_name_value_pair(token_name(LEXER.S_width), ctx.parsed_qty_rhs)

    def enterMeasureInfrastructureRoot(self, ctx):
        ctx.parsed_infrastructure = self.measure

    def enterDC_TypeId(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitDC_TypeId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_type_id(ctx.parsed_ii_rhs)

    def enterOC_generic(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterOC_TemplateId(self, ctx):
        ctx.parsed_list_ii_rhs = ListIiRhs()

    def exitOC_TemplateId(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_template_ids(ctx.parsed_list_ii_rhs)

    def enterDC_outboundRelationship(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterOutbound_relationship_list(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterOutbound_relationship(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterOutbound_status(self, ctx):
        ctx.parsed_status_entry = StatusEntry()

    def exitOutbound_status(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_status(ctx.parsed_status_entry)

    def enterOutbound_status_entry(self, ctx):
        ctx.parsed_status_entry = ctx.parentCtx.parsed_status_entry

    def enterOutbound_result(self, ctx):
        ctx.parsed_result_entry = ResultEntry()

    def exitOutbound_result(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_result(ctx.parsed_result_entry)
        
    def enterOutbound_field_value(self, ctx):
        ctx.parsed_field_value = FieldValue()
        
    def exitOutbound_field_value(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_field_value(ctx.parsed_field_value)
        
    def enterOutbound_field_value_entry(self, ctx):
        ctx.parsed_field_value = ctx.parentCtx.parsed_field_value
        
    def enterVC_template(self, ctx):
        ctx.parsed_field_value = ctx.parentCtx.parsed_field_value
        
    def enterVC_generic(self, ctx):
        ctx.parsed_data_criterion = DataCriterion()
        
    def exitVC_generic(self, ctx):
        ctx.parentCtx.parsed_field_value.set_child_data_criterion(ctx.parsed_data_criterion)        
        
    def enterList_ii_field_value_rhs(self, ctx):
        ctx.parsed_field_value = ctx.parentCtx.parsed_field_value
        
    def enterIi_field_value_item(self, ctx):        
        ctx.parsed_field_value = ctx.parentCtx.parsed_field_value        
                
    def enterIi_field_value_rhs(self, ctx):
        ctx.parsed_field_value = ctx.parentCtx.parsed_field_value        
        
    def enterIi_field_value_template(self, ctx):                
        ctx.parentCtx.parsed_field_value.set_field_template_id(self.token2string(ctx.field_value_oid()))

    def enterOutbound_result_entry(self, ctx):
        ctx.parsed_result_entry = ctx.parentCtx.parsed_result_entry

    def enterOutbound_conjunction(self, ctx):
        ctx.parsed_conjunction_entry = ConjunctionEntry()

    def exitOutbound_conjunction(self, ctx):
        ctx.parentCtx.parsed_data_criterion.add_conjunction_entry(ctx.parsed_conjunction_entry)

    def enterOut_conj_code(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitOut_conj_code(self, ctx):
        ctx.parentCtx.parsed_conjunction_entry.set_conjunction_code(ctx.parsed_cd_rhs)

    def enterOut_conj_ref(self, ctx):
        ctx.parsed_criteria_reference_rhs = CriteriaReferenceRhs()

    def exitOut_conj_ref(self, ctx):
        ctx.parentCtx.parsed_conjunction_entry.set_child_criterion_reference(ctx.parsed_criteria_reference_rhs)

    def exitData_criteria_section(self, ctx):
        for dc in self.symbol_table.data_criteria.values():
            so_ref = dc.get_specific_occurrence()
            if so_ref is not None:
                self.symbol_table.add_specific_occurrence(dc)

    def enterOutbound_specific_occurrence(self, ctx):
        ctx.parsed_data_criterion = ctx.parentCtx.parsed_data_criterion

    def enterSO_ref(self, ctx):
        ctx.parsed_criteria_reference_rhs = CriteriaReferenceRhs()
        
    def exitSO_ref(self, ctx):        
        ctx.parentCtx.parsed_data_criterion.set_specific_occurrence(ctx.parsed_criteria_reference_rhs)


    def enterSC_generic(self, ctx):
        ctx.parsed_data_criterion = DataCriterion()

    def exitSC_generic(self, ctx):
        ctx.parentCtx.parsed_status_entry.set_child_data_criterion(ctx.parsed_data_criterion)

#    def enterSC_status(self, ctx):
#        ctx.parsed_list_ii_rhs = ListIiRhs()
#
#    def exitSC_status(self, ctx):
#        ctx.parentCtx.parsed_status_entry.get_child_data_criterion().set_template_ids(ctx.parsed_list_ii_rhs)

    def enterMeasure_attribute_rhs(self, ctx):
        ctx.parsed_measure_attribute_rhs = MeasureAttributeRhs()

    def exitMeasure_attribute_rhs(self, ctx):
        self.symbol_table.add_measure_attribute(ctx.parsed_measure_attribute_rhs)

    def enterMeasure_attribute_ir(self, ctx):
        ctx.parsed_infrastructure = ctx.parentCtx.parsed_measure_attribute_rhs

    def enterMeasure_attribute_id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitMeasure_attribute_id(self, ctx):
        ctx.parentCtx.set_name_value_pair(token_name(LEXER.S_id), ctx.parsed_ii_rhs)

    def enterMeasure_attribute_code(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitMeasure_attribute_code(self, ctx):
        ctx.parentCtx.parsed_measure_attribute_rhs.set_name_value_pair(token_name(LEXER.S_code), ctx.parsed_cd_rhs)

    def enterMeasure_attribute_nullfalvor(self, ctx):
        ctx.parentCtx.parsed_measure_attribute_rhs.set_name_value_pair(token_name(LEXER.A_nullFlavor), self.token2string(ctx.any_string()))

    def enterMeasure_attribute_value(self, ctx):
        ctx.parsed_measure_attr_value_rhs = MeasureAttrValueRhs()

    def enterMeasure_attr_value_rhs(self, ctx):
        ctx.parsed_measure_attr_value_rhs = ctx.parentCtx.parsed_measure_attr_value_rhs

    def enterMeasure_attr_value_entry(self, ctx):
        ctx.parsed_measure_attr_value_rhs = ctx.parentCtx.parsed_measure_attr_value_rhs

    def exitMeasure_attribute_value(self, ctx):
        ctx.parentCtx.parsed_measure_attribute_rhs.set_name_value_pair(token_name(LEXER.S_value), ctx.parsed_measure_attr_value_rhs)

    def enterMeasure_attr_value_media_entry(self, ctx):
        ctx.parsed_measure_attr_value_rhs = ctx.parentCtx.parsed_measure_attr_value_rhs

    def enterMeasure_attr_value_code_entry(self, ctx):
        ctx.parsed_cd_rhs = ctx.parentCtx.parsed_measure_attr_value_rhs

    def enterMeasure_attr_any(self, ctx):
        ctx.any_rhs = ctx.parentCtx.parsed_measure_attr_value_rhs

    def enterMeasure_attr_mediaType(self, ctx):
        ctx.parentCtx.parsed_measure_attr_value_rhs.set_name_value_pair(token_name(LEXER.A_mediaType), self.token2string(ctx.any_string()))

    def enterMeasure_attr_value(self, ctx):
        ctx.parentCtx.parsed_measure_attr_value_rhs.set_name_value_pair(token_name(LEXER.A_value), self.token2string(ctx.any_string()))

    def enterMeasure_attr_type(self, ctx):
        ctx.parentCtx.parsed_measure_attr_value_rhs.set_name_value_pair(token_name(LEXER.C_NS_XSI_TYPE), self.token2string(ctx.any_string()))

    def enterPopulation_criteria_section(self, ctx):
        ctx.parsed_population_criteria_section_rhs = PopulationCriteriaSectionRhs()

    def exitPopulation_criteria_section(self, ctx):
        self.measure.add_population(ctx.parsed_population_criteria_section_rhs)

    def enterPCS_id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitPCS_id(self, ctx):
        ctx.parentCtx.parsed_population_criteria_section_rhs.set_name_value_pair(token_name(LEXER.S_id), ctx.parsed_ii_rhs)

    def enterPCS_code(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitPCS_code(self, ctx):
        ctx.parentCtx.parsed_population_criteria_section_rhs.set_name_value_pair(token_name(LEXER.S_code), ctx.parsed_cd_rhs)

    def enterPCS_title(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitPCS_title(self, ctx):
        ctx.parentCtx.parsed_population_criteria_section_rhs.set_name_value_pair(token_name(LEXER.S_title), ctx.parsed_st_rhs)

    def enterPCS_localVariable(self, ctx):
        ctx.parsed_st_rhs = StRhs()

    def exitPCS_localVariable(self, ctx):
        ctx.parentCtx.parsed_population_criteria_section_rhs.set_name_value_pair(token_name(LEXER.S_localVariableName), ctx.parsed_st_rhs)

    def enterPCS_component(self, ctx):
        ctx.parsed_population_criteria_section_rhs = ctx.parentCtx.parsed_population_criteria_section_rhs

    def enterWrapped_pop_crit(self, ctx):
        ctx.parsed_population_criteria_section_rhs = ctx.parentCtx.parsed_population_criteria_section_rhs

    def enterWrapped_pop_crit_entry(self, ctx):
        ctx.parsed_population_criteria_section_rhs = ctx.parentCtx.parsed_population_criteria_section_rhs

    def enterPopulation_criterion(self, ctx):
        ctx.parsed_population_criterion = PopulationCriterion()

    def exitPopulation_criterion(self, ctx):
        ctx.parentCtx.parsed_population_criteria_section_rhs.add_population_criterion(ctx.parsed_population_criterion)
        self.symbol_table.set_population_criterion(ctx.parsed_population_criterion)

    def enterInitial_population_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion
        
    def enterIpp_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterPop_id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitPop_id(self, ctx):
        ctx.parentCtx.parsed_population_criterion.set_name_value_pair(token_name(LEXER.S_id), ctx.parsed_ii_rhs)

    def enterPop_code(self, ctx):
        ctx.parsed_cd_rhs = CdRhs()

    def exitPop_code(self, ctx):
        ctx.parentCtx.parsed_population_criterion.set_name_value_pair(token_name(LEXER.S_code), ctx.parsed_cd_rhs)

    def enterPop_precondition(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion 

    def enterPrecondition_rhs(self, ctx):
        ctx.parsed_precondition_rhs = PreconditionRhs()

    def exitPrecondition_rhs(self, ctx):
        if hasattr(ctx.parentCtx, 'parsed_population_criterion'):
            ctx.parentCtx.parsed_population_criterion.set_preconditions(ctx.parsed_precondition_rhs)
        elif hasattr(ctx.parentCtx, 'parsed_boolean_grouping_rhs'):
            ctx.parentCtx.parsed_boolean_grouping_rhs.set_preconditions(ctx.parsed_precondition_rhs)
        else:
            self.unimplemented(ctx)

    def enterSingle_precondition(self, ctx):
        ctx.parsed_precondition = Precondition()

    def exitSingle_precondition(self, ctx):
        ctx.parentCtx.parsed_precondition_rhs.add_precondition(ctx.parsed_precondition)

    def enterPrec_conjunction(self, ctx):
        ctx.parsed_cs_rhs = CsRhs()
    def exitPrec_conjunction(self, ctx):
        ctx.parentCtx.parsed_precondition.set_name_value_pair(token_name(LEXER.S_conjunctionCode), ctx.parsed_cs_rhs)

    def enterPrec_criteria_reference(self, ctx):
        ctx.parsed_criteria_reference_rhs = CriteriaReferenceRhs()

    def exitPrec_criteria_reference(self, ctx):
        ctx.parentCtx.parsed_precondition.set_name_value_pair(token_name(LEXER.S_criteriaReference), ctx.parsed_criteria_reference_rhs)

    def enterPrec_boolean_group(self, ctx):
        ctx.parsed_boolean_grouping_rhs = BooleanGroupingRhs(self.token2string(ctx.boolean_grouping_keyword()))

    def exitPrec_boolean_group(self, ctx):
        ctx.parentCtx.parsed_precondition.set_grouping(ctx.parsed_boolean_grouping_rhs)

    def enterBoolean_grouping_rhs(self, ctx):
        ctx.parsed_boolean_grouping_rhs = ctx.parentCtx.parsed_boolean_grouping_rhs

    def enterBoolan_grouping_ir_element(self, ctx):
        ctx.parsed_infrastructure = ctx.parentCtx.parsed_boolean_grouping_rhs

    def enterBoolean_grouping_id(self, ctx):
        ctx.parsed_ii_rhs = IiRhs()

    def exitBoolean_grouping_id(self, ctx):
        ctx.parentCtx.parsed_boolean_grouping_rhs.set_name_value_pair(token_name(LEXER.S_id), ctx.parsed_ii_rhs)

    def enterBoolean_grouping_precondition(self, ctx):
        ctx.parsed_boolean_grouping_rhs = ctx.parentCtx.parsed_boolean_grouping_rhs

    def enterNumerator_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion


    def enterDenominator_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion


    def enterMeasure_population_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterDenominator_exception_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterDenominator_exclusion_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterNumerator_exclusion_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterMeasure_population_exclusion_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterStratifier_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterTemp_criteria_entry(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterNumerator_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterDenominator_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterMeasure_population_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterDenominator_exception_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterDenominator_exclusion_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterNumerator_exclusion_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterMeasure_population_exclusion_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    def enterStratifier_criteria(self, ctx):
        ctx.parsed_population_criterion = ctx.parentCtx.parsed_population_criterion

    @staticmethod
    def token2string(token):
        return strip_all_quotes(token.getText())

    @staticmethod
    def token2boolean(token):
        return string_to_boolean(token.getText())

        
