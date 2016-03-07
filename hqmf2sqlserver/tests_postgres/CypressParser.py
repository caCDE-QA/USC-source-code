#!/usr/bin/python

from xml.dom.minidom import parse, parseString, Element
from os import path
import re

class CypressParser:
    patient_section_templateIds = ['2.16.840.1.113883.10.20.17.2.4', '2.16.840.1.113883.10.20.24.2.1']
#    patient_id_root='2.16.840.1.113883.4.572'
    patient_id_root="2.16.840.1.113883.3.1257"

    def parsePatientFile(self, filename):
        patient = CypressPatient(filename)
        structuredBody = None
        node = parse(filename)
        metadata = self.parseMetadata(node, filename)
        patientRole = node.getElementsByTagName('patientRole')
        assert patientRole.length == 1
        patient.setCharacteristics(self.parse_patient_role(patientRole[0]))
        nl = node.getElementsByTagName('structuredBody')
        if len(nl) != 1:
            raise ValueError('more or less than 1 structuredBody element in clinical document')
        structuredBody = nl[0]
        patientSection = self.findPatientSection(structuredBody)
        patient.setEvents(self.parsePatientSection(patientSection))
        return {'metadata' : metadata, 'patient_data' : patient.asDict()}

    def parseMetadata(self, node, filename):
        metadata = dict()
        metadata['filepath'] = filename
        metadata['filename'] = path.basename(filename)
        metadata['patient_number'] = re.sub('_.*', '', metadata['filename'])
        return metadata

    def parseGenericElement(self, element, expectedName):
        result = None
        for child in element.childNodes:
            if child.localName == expectedName:
                fn = getattr(self, 'parse_' + expectedName)
                result = fn(child)
                if (result != None):
                    break
            elif child.localName != None:
                raise ValueError('unexpected child ' + child.localName + ' of ' + element.localName + ' element')
        return result

    def findPatientSection(self, node):
        return self.parseGenericElement(node, 'component')

    def parse_component(self, node):
        return self.parseGenericElement(node, 'section')

    def parse_section(self, node):
        patient_section = None
        for child in node.childNodes:
            if child.localName == 'templateId' and child.getAttribute('root') in self.patient_section_templateIds:
                patient_section = node
                patient_section.normalize()
        return patient_section

    def parsePatientSection(self, patientSection):
        resultList = []
        for child in patientSection.childNodes:
            if child.localName == 'entry':
                res = self.parseEntry(child)
                if res != None:
                    resultList.append({child.localName : res})
            elif child.localName in ['templateId', 'code', 'title', 'text', None]:
                continue
            else:
                raise ValueError('unexpected ' + child.localName + ' in patient section')
        return resultList

    def parseEntry(self, entry):
        for child in entry.childNodes:
            if child.localName != None:
                fn = getattr(self, 'parse_patient_' + child.localName)
                result = fn(child)
                if result != None:
                    break
        return result

    def parse_patient_role(self, node):
        result = dict()
        unique_id = None
        for child in node.childNodes:
            if child.localName == 'id' and child.getAttribute('root') == self.patient_id_root:
                unique_id = child.getAttribute('extension')
            if unique_id != None:
                break
        if unique_id != None:
            result['unique_patient_id'] = unique_id
        zipcode = self.getSingleValue(node.getElementsByTagName('postalCode'))
        for child in zipcode.childNodes:
            if child.nodeType == child.TEXT_NODE:
                result['zip'] = child.data
        patient = self.getSingleValue(node.getElementsByTagName('patient'))
        if patient.localName != None:
            if patient.attributes != None and patient.attributes.length > 0:
                for i in range(patient.attributes.length):
                    a = patient.attributes.item(i)
                    result[a.localName] = a.value

        for child in patient.childNodes:
            if child.nodeType == child.TEXT_NODE:
                result[child.localName] = child.data
            elif child.nodeType != child.ATTRIBUTE_NODE:
                cr = self.parse_patient_node(child)
                if cr != None:
                    if result.get(child.localName) == None:
                        result[child.localName] = [cr]
                    else:
                        result[child.localName].append(cr)

        if len(result.items()) == 0:
            result = None
        return result

    def getSingleValue(self, list):
        assert len(list) == 1
        return list[0]

    def parse_patient_node(self, node):
        result = dict()

        if node.localName != None:
            if node.attributes != None and node.attributes.length > 0:
                for i in range(node.attributes.length):
                    a = node.attributes.item(i)
                    result[a.localName] = a.value

        for child in node.childNodes:
            if child.nodeType == child.TEXT_NODE:
                result[child.localName] = child.data
            elif child.nodeType != child.ATTRIBUTE_NODE:
                cr = self.parse_patient_node(child)
                if cr != None:
                    if result.get(child.localName) == None:
                        result[child.localName] = [cr]
                    else:
                        result[child.localName].append(cr)

        if len(result.items()) == 0:
            result = None
        return result

    def parse_patient_observation(self, observation):
        return {'observation' : self.parse_patient_node(observation)}

    def parse_patient_procedure(self, procedure):
        return {'procedure' : self.parse_patient_node(procedure)}

    def parse_patient_substanceAdministration(self, substanceAdministration):
        return {'substanceAdministration' : self.parse_patient_node(substanceAdministration)}

    def parse_patient_act(self, act):
        return {'act' : self.parse_patient_node(act)}

    def parse_patient_supply(self, supply):
        return {'supply' : self.parse_patient_node(supply)}

    def parse_patient_encounter(self, encounter):
        return {'encounter' : self.parse_patient_node(encounter)}

class CypressPatient:
    fake_text_value_code='Unmapped text result'
    fake_code_system_oid = '2.16.840.1.113883.5.4'

    def __init__(self, patient_id):
        self.patient_id = patient_id
        self.canonical_representation = dict()

    def setCharacteristics(self, characteristics):
        self.characteristics = {'characteristics' : characteristics}
        self.canonical_representation['individual_characteristics'] = self.canonicalize_characteristics(characteristics)

    def setEvents(self, events):
        self.events = {'events' : events}
        self.canonical_representation['events'] = self.canonicalize_events(events)

    def asDict(self):
        return self.canonical_representation

    def canonicalize_characteristics(self, characteristics):
        res = dict()
        res['birthTime'] = self.convertTime(characteristics['birthTime'])
        res['name'] = self.getSingleDictListTextValue(characteristics['name'], 'given') + \
                      ' ' + self.getSingleDictListTextValue(characteristics['name'], 'family')
        assert len(characteristics['administrativeGenderCode']) == 1
        for code in ['administrativeGenderCode', 'ethnicGroupCode', 'raceCode']:
            res[code] = self.getSingleValue(characteristics[code])
        res['unique_patient_id'] = characteristics['unique_patient_id']
        res['zip'] = characteristics['zip']
        return res

    def canonicalize_events(self, events):
        res = []
        for event in self.events['events']:
            cr = self.canonicalize_event(event)
            if cr != None:
                res = res + cr
        return res

    def canonicalize_event(self, event):
        entry = event['entry']
        if entry == None:
            return None
        return self.canonicalize_entry(entry)

    def canonicalize_entry(self, entry):
        if isinstance(entry, str):
            return [{'notImplemented' : entry}]
        keys = entry.keys()
        assert len(keys) == 1
        event_type = keys[0]
        fn = getattr(self, 'canonicalize_' + event_type)
        res = fn(entry.get(event_type), event_type)
        if len(res) == 0:
            return None
        return res

    def canonicalize_base(self, event, event_type):
        res = dict()
        res['event_type'] = event_type
        unprocessed_items = self.fill_standard_event_values(res, event)
        res['codes'] = []
        codes = event.get('code')
        if codes != None:
            for code in event['code']:
                res['codes'].append(self.canonicalize_code(code))
        res['unprocessed_items'] = unprocessed_items
        return res

    def canonicalize_simple(self, event, event_type):
        canonicalized_event = self.canonicalize_base(event, event_type)
        result = [canonicalized_event]
        d = canonicalized_event['unprocessed_items']
        if d.has_key('entryRelationship'):
            del d['entryRelationship']
        for related_event in self.find_related_events(event):
            if related_event != None:
                for key in related_event.keys():
                    if not (key in [None, 'typeCode']):
                        entry = self.getSingleValue(related_event[key])
                        result = result + self.canonicalize_entry({key : entry})
        return result


    def canonicalize_encounter(self, encounter, event_type):
        canonicalized_events = self.canonicalize_simple(encounter, event_type)
        canonicalized_event = canonicalized_events[0]
        u = canonicalized_event.get('unprocessed_items')
        if u != None:
            if u.has_key('participant'):
                for p in u['participant']:
                    if p != None:
                        if p.get('typeCode') == 'LOC':
                            t = self.getSingleValue(p.get('time'))
                            high=self.getSingleValue(t.get('high'))
                            low=self.getSingleValue(t.get('low'))
                            if high != None and high.has_key('value'):
                                canonicalized_event['FACILITY_LOCATION_DEPARTURE_DATETIME'] = self.convertScalarTime(high.get('value'))
                            if low != None and low.has_key('value'):
                                canonicalized_event['FACILITY_LOCATION_ARRIVAL_DATETIME'] = self.convertScalarTime(low.get('value'))
            if u.has_key('dischargeDispositionCode'):
                canonicalized_event['dischargeDispositionCode'] =  self.getSingleValue(u.get('dischargeDispositionCode'))
        return canonicalized_events
                                                
                    

    def canonicalize_observation(self, observation, event_type):
        return self.canonicalize_simple(observation, event_type)

    def canonicalize_procedure(self, procedure, event_type):
        return self.canonicalize_simple(procedure, event_type)

    def canonicalize_substanceAdministration(self, substanceAdministration, event_type):
        canonicalized_event = self.canonicalize_base(substanceAdministration, event_type)
        canonicalized_event['codes'] = []
        result = [canonicalized_event]
        consumable = self.getSingleValue(substanceAdministration.get('consumable'))
        if consumable != None:
            product = self.getSingleValue(consumable.get('manufacturedProduct'))
            codes = self.getCodesFromManufacturedProduct(product)
            if codes != None:
                for code in codes:
                    canonicalized_event['codes'].append(self.canonicalize_code(code))
        return [canonicalized_event]

    def canonicalize_supply(self, supply, event_type):
        canonicalized_event = self.canonicalize_base(supply, event_type)
        canonicalized_event['codes'] = []
        result = [canonicalized_event]
        product = self.getSingleValue(supply.get('product'))
        if product != None:
            mfgProduct = self.getSingleValue(product.get('manufacturedProduct'))
            codes = self.getCodesFromManufacturedProduct(mfgProduct)
        if codes != None:
            for code in codes:
                canonicalized_event['codes'].append(self.canonicalize_code(code))
        return [canonicalized_event]

    def getCodesFromManufacturedProduct(self, product):
        if product == None:
            return None
        material = self.getSingleValue(product.get('manufacturedMaterial'))
        if material != None:
            codes = material.get('code')
            if codes != None and len(codes) == 0:
                codes = None
        return codes

    def canonicalize_act(self, act, event_type):
        return self.canonicalize_simple(act, event_type)

    def find_related_event(self, event):
        rel = event.get('entryRelationship')
        if rel == None:
            return None
        return self.getSingleValue(rel)

    def find_related_events(self, event):
        events = event.get('entryRelationship')
        if events == None:
            return []
        else:
            return events

    def canonicalize_code(self, code):
        if code == None:
            return None
        res = dict()
        text = self.getTextValue(code.get('originalText'))
        if text != None:
            res['original_text'] = text
        for k in code.keys():
            if k != 'originalText':
                res[k] = code.get(k)
        if len(res.items()) == 0:
            return None
        return res

    def fill_standard_event_values(self, res, event):
        simple_event_keys = ['classCode', 'moodCode', 'templateId', 'id']
        single_code_keys = ['routeCode', 'targetSiteCode', 'priorityCode']
        other_handled_keys = ['effectiveTime', 'statusCode', 'code', 'text', 'value', 'negationInd']
        effective_time = self.getEffectiveTime(event)
        start_time = self.getSingleDictListValue(effective_time, 'low')
        res['start_time'] = self.convertTime(start_time)
        end_time = self.getSingleDictListValue(effective_time, 'high')
        res['end_time'] = self.convertTime(end_time)
        res['effective_time'] = self.convertTime(effective_time)
        res['status_code'] = self.getSingleDictListValue(event.get('statusCode'), 'code')
        res['text'] = self.getTextValue(event.get('text'))
        if event.has_key('negationInd'):
            res['negationInd'] = event.get('negationInd')
        val = event.get('value')
        if val != None:
            val = self.getSingleValue(val)
            if val.get('type') == 'ST':
                val = self.make_fake_code(val)
            res['value'] = self.canonicalize_code(val)

        codelist = []
        codes = event.get('code')
        if codes != None:
            for item in codes:
                cr = self.canonicalize_code(item)
                if cr != None:
                    codelist.append(cr)
        for key in single_code_keys:
            if event.has_key(key):
                res[key] =  self.getSingleValue(event.get(key))
        for key in simple_event_keys:
            res[key] = event.get(key)
        unprocessed_items = dict()
        for key in event.keys():
            if not (key in simple_event_keys or key in single_code_keys or key in other_handled_keys):
                unprocessed_items[key] = event.get(key)
        return(unprocessed_items)

    def make_fake_code(self, value):
        fake = dict()
        fake['type'] = 'CD'
        fake['codeSystem'] = self.fake_code_system_oid
        fake['original_text'] = value.get(None)
        fake['code'] = self.fake_text_value_code
        return fake

    def getEffectiveTime(self, event):
        times = event.get('effectiveTime')
        if times == None:
            return None
        if len(times) == 1:
            return times
        possible_times = []
        for t in times:
            if (t.get('type') == None and t.get('xsi:type') == None) or t.get('type') == 'IVL_TS' or t.get('xsi:type') == 'IVL_TS':
                possible_times.append(t)
        return possible_times

    def convertScalarTime(self, tstr):
        if tstr == None:
            return None
        result = dict()
        result['string'] = tstr
        result['date'] = tstr[0:8]
        result['time'] = tstr[8:]
        return result


    def convertTime(self, time):
        if time == None:
            return None
        return self.convertScalarTime(self.getSingleDictListValue(time, 'value'))
        
    def getSingleValue(self, list):
        assert len(list) == 1
        return list[0]

    def getSingleDictListValue(self, dictlist, label):
        if dictlist == None:
            return None
        assert len(dictlist) == 1
        return dictlist[0].get(label)

    def getSingleDictListTextValue(self, dictlist, label):
        return(self.getTextValue(self.getSingleDictListValue(dictlist, label)))

    def getTextValue(self, map):
        return self.getSingleDictListValue(map, None)

