#!/usr/bin/python

from xml.dom.minidom import parse, parseString, Element
from os import path
import re
import json
import sys

class QRDACat3:
    reporting_parameters_templateids = [{"root" : "2.16.840.1.113883.10.20.17.2.1"}, {"root" : "2.16.840.1.113883.10.20.27.2.2"}]
    measure_section_templateids = [{"root" : "2.16.840.1.113883.10.20.24.2.2"}, {"root" : "2.16.840.1.113883.10.20.27.2.1"}]
    observation_parameters_templateids = [{"root" : "2.16.840.1.113883.10.20.17.3.8"}]
    standard_entry_elements = ["templateId", "code", "id"]
    effective_time_elements = {"low" : "measure_period_start", "high" : "measure_period_end"}

    stratum_headers = [ \
        ["templateId", {"root" : "2.16.840.1.113883.10.20.27.3.4"}], \
            ["code",  {"code" : "ASSERTION", "codeSystem" : "2.16.840.1.113883.5.4", "displayName" : "Assertion",   "codeSystemName" : "ActCode"}], \
            ["statusCode", {"code" : "completed"}]]

    supplemental_headers = { \
        "race" : [["templateId", {"root" : "2.16.840.1.113883.10.20.27.3.8"}], \

                      ["code", {"code" : "103579009", "displayName" : "Race", \
                                    "codeSystem" : "2.16.840.1.113883.6.96", "codeSystemName" : "SNOMED-CT"}], \
                      ["statusCode", {"code" : "completed"}]], \
            "ethnicity" : [["templateId", {"root" : "2.16.840.1.113883.10.20.27.3.7"}], \
                               ["code",  {"code" : "364699009", "displayName" : "Ethnic Group", \
                                              "codeSystem" : "2.16.840.1.113883.6.96", "codeSystemName" : "SNOMED CT"}], \
                               ["statusCode", {"code" : "completed"}]], \
            "payer" : [["templateId", {"root" : "2.16.840.1.113883.10.20.24.3.55"}], \
                           ["templateId", {"root" : "2.16.840.1.113883.10.20.27.3.9"}], \
                           ["id", {"nullFlavor" : "NA"}], \
                           ["code", {"code" : "48768-6", "displayName" : "Payment source", \
                                         "codeSystem" : "2.16.840.1.113883.6.1", "codeSystemName" : "SNOMED-CT"}], \
                           ["statusCode", {"code" : "completed"}]], \
            "sex" : [["templateId", {"root" : "2.16.840.1.113883.10.20.27.3.6"}], \
                         ["code", {"code" : "184100006", "displayName" : "patient sex", \
                                       "codeSystem" : "2.16.840.1.113883.6.96", "codeSystemName" : "SNOMED-CT"}], \
                         ["statusCode", {"code" : "completed"}]], \
            "zip" : [["templateId", {"root" : "2.16.840.1.113883.10.20.27.3.10"}], \
                         ["code", {"code" : "184102003", "displayName" : "patient postal code", \
                                       "codeSystem" : "2.16.840.1.113883.6.96", "codeSystemName" : "SNOMED-CT"}], \
                         ["statusCode", {"code" : "completed"}]]}

    supplemental_value_attributes = { \
        "race" : {"xsi:type" : "CD", "codesystem" : "2.16.840.1.113883.6.238", "codeSystemName" : "Race &amp; Ethnicity - CDC"}, \
            "ethnicity" : {"xsi:type" : "CD", "codesystem" : "2.16.840.1.113883.6.238", "codeSystemName" : "Race &amp; Ethnicity - CDC"}, \
            "payer" : {"xsi:type" : "CD", "codesystem" : "2.16.840.1.113883.3.221.5", "codeSystemName" : "Source of Payment Typology"}, \
            "sex" : {"xsi:type" : "CD", "codesystem" : "2.16.840.1.113883.5.1", "codeSystemName" : "HL7AdministrativeGenderCode"}, \
            "zip" : {"xsi:type" : "ST"}}

    # Cypress 2.6.0 considers it an error if you include a zero-valued supplemental result
    def __init__(self, filename="simple_template.xml", skip_zero_valued_supplemental_results=False):
        self.doc = parse(filename)
        self.doc.normalize()
        self.skip_zero_valued_supplemental_results = True
        clinicalDoc = self.findSingleChild(self.doc, "ClinicalDocument")
        structuredBodies = clinicalDoc.getElementsByTagName("structuredBody")
        self.body = self.singleListValue(structuredBodies)
        reportingParameters = []
        measureSections = []
        for child in self.body.childNodes:
            if child.localName == 'component':
                reportingParameters = reportingParameters + self.findNodesWithTemplate(child, self.reporting_parameters_templateids)
                measureSections = measureSections + self.findNodesWithTemplate(child, self.measure_section_templateids)
        self.reportingParameters = self.singleListValue(reportingParameters)
        self.reportingParametersParent = self.reportingParameters.parentNode
        self.measureSection = self.singleListValue(measureSections)

    def singleListValue(self, things):
        assert(len(things) == 1)
        return things[0]

    def findSingleChild(self, node, childName, allow_empty = False):
        matches = []
        for child in node.childNodes:
            if child.localName == childName:
                matches.append(child)
        if allow_empty:
            if len(matches) == 0:
                return None
        return self.singleListValue(matches)

    def findNodesWithTemplate(self, node, idlist):
        matches = []
        for child in node.childNodes:
            if self.hasTemplateIn(child, idlist):
                matches.append(child)
        return matches

    def hasTemplateIn(self, node, idlist):
        return self.hasIdIn(node, idlist, "templateId")

    def hasIdIn(self, node, idlist, idname):
        for child in node.childNodes:
            if child.localName == idname:
                for id in idlist:
                    if self.matchesId(child, id):
                        return True
        return False
        
    def matchesId(self, node, id):
        for key in id.keys():
            if node.getAttribute(key) != id.get(key):
                return False
        return True


    def updateReportingParameters(self, parameters):
        self.reporting_parameters = parameters
        for child in self.reportingParameters.childNodes:
            if child.localName == "text":
                newTextNode = self.doc.createElement("text")
                listNode = self.doc.createElement("list")
                newTextNode.appendChild(listNode)
                itemNode = self.doc.createElement("item")
                listNode.appendChild(itemNode)
                itemNode.appendChild(self.doc.createTextNode("Reporting period: " + parameters.get(self.effective_time_elements['low']) + ' - ' + parameters.get(self.effective_time_elements['high'])))
                child.parentNode.replaceChild(newTextNode, child)
            elif child.localName == "entry":
                newEntry = self.generateReportingParameterEntry(child, parameters)
                if newEntry == None:
                    child.parentNode.removeChild(child)
                    child.unlink()
                else:
                    child.parentNode.replaceChild(newEntry, child)
    
    def generateReportingParameterEntry(self, node, parameters):
        is_observation_parameters = False

        for child in node.childNodes:
            if self.hasTemplateIn(child, self.observation_parameters_templateids):
                etime = self.findSingleChild(child, 'effectiveTime', True)
                if etime != None:
                    child.removeChild(etime)
                    etime.unlink()
                etime = self.generateEffectiveTime(parameters)
                if etime != None:
                    child.appendChild(etime)
                return node

        return None

    def generateEffectiveTime(self, parameters):
        node = self.doc.createElement('effectiveTime')
        for attr in ['low', 'high']:
            child = self.createElementWithAttributes(attr, {'value' : parameters.get(self.effective_time_elements[attr])})
            node.appendChild(child)
        return node

    def createElementWithAttributes(self, name, attributes):
        node = self.doc.createElement(name)
        for k in attributes.keys():
            node.setAttribute(k, str(attributes[k]))
        return node

    def createMeasureOrganizer(self, measure_data, measure_metadata):
        organizer=self.createElementWithAttributes('organizer', {'classCode' : 'CLUSTER', 'moodCode' : 'EVN'})
        organizer.appendChild(self.createElementWithAttributes('templateId', {'root' : '2.16.840.1.113883.10.20.24.3.98'}))
        organizer.appendChild(self.createElementWithAttributes('templateId', {'root' : '2.16.840.1.113883.10.20.27.3.1'}))
        organizer.appendChild(self.createElementWithAttributes('statusCode', {'code' : 'completed'}))
        organizer.appendChild(self.createMeasureReference(measure_metadata))
        population_names = measure_data.keys()

        unstratified_populations = []
        stratified_populations = []
        for name in population_names:
            population = measure_data.get(name)
            if population.get('stratification') == None:
                unstratified_populations.append(population)
            else:
                stratified_populations.append(population)

        processed_subpopulations = set()
        for population in unstratified_populations:
            for mptype in ['ipp', 'denom', 'denex', 'numer', 'denexcep']:
                subpopulation = population.get(mptype)
                if subpopulation != None:
                    subpop_name = subpopulation.get('population_criterion_name')
                    if subpop_name not in processed_subpopulations:
                        obs = self.createResultObservation(subpopulation, stratified_populations)
                        if obs != None:
                            organizer.appendChild(obs)
        return organizer
    
#     def createMeasureOrganizer(self, population_name, measure_population_info):
#         organizer=self.createElementWithAttributes('organizer', {'classCode' : 'CLUSTER', 'moodCode' : 'EVN'})
#         organizer.appendChild(self.createElementWithAttributes('templateId', {'root' : '2.16.840.1.113883.10.20.24.3.98'}))
#         organizer.appendChild(self.createElementWithAttributes('templateId', {'root' : '2.16.840.1.113883.10.20.27.3.1'}))
#         organizer.appendChild(self.createElementWithAttributes('statusCode', {'code' : 'completed'}))
#         organizer.appendChild(self.createMeasureReference(measure_population_info))
#         for mptype in ['ipp', 'denom', 'denex', 'numer', 'denexcep']:
#             if measure_population_info.get(mptype) != None:
#                 organizer.appendChild(self.createResultObservation(measure_population_info[mptype], measure_population_info['stratification']))
#         return organizer

    def createMeasureReference(self, measure_metadata):
        node = self.doc.createElement('reference')
        node.setAttribute('typeCode', 'REFR')
        ext = self.doc.createElement('externalDocument')
        node.appendChild(ext)
        ext.setAttribute('classCode', 'DOC')
        ext.setAttribute('moodCode', 'EVN')
        ext.appendChild(self.createElementWithAttributes('id', {'root' : str.upper(str(measure_metadata['hqmf_id']))}))
        ext.appendChild(self.createElementWithAttributes('id', {'root' : '2.16.840.1.113883.3.560.1', 
                                                                'extension' : measure_metadata['hqmf_id']}))
        ext.appendChild(self.createElementWithAttributes('id', {'root' : '2.16.840.1.113883.4.738', 
                                                                'extension' : measure_metadata['hqmf_id']}))
        ext.appendChild(self.createElementWithAttributes('code', \
                                                             {'code' : "57024-2", \
                                                                  "codeSystem" :"2.16.840.1.113883.6.1", \
                                                                  "codeSystemName" : "LOINC", \
                                                                  "displayName" : "Health Quality Measure Document"}))
        t = self.doc.createElement("text")
        ext.appendChild(t)
        t.appendChild(self.doc.createTextNode(measure_metadata.get('title')))
        ext.appendChild(self.createElementWithAttributes('setId', {'root' : str.upper(str(measure_metadata['hqmf_set_id']))}))
        ext.appendChild(self.createElementWithAttributes('versionNumber', {'value' : measure_metadata['hqmf_version_number']}))
        return node

            
    # subpopulation is ipp, denom, etc. info
    def createResultObservation(self, subpopulation, stratified_populations):
        node = self.doc.createElement('component')
        md = self.createMeasureDataElement(subpopulation)
        node.appendChild(md)

        results = subpopulation.get('results')
        if results == None:
            sys.stderr.write("No results for subpopulation " + subpopulation.get('population_criterion_name') + "\n")
            sys.stderr.write(str(subpopulation) + "\n")
        else:
            total = results.get('total')
            er = self.createCountObservation(total)
            md.appendChild(er)
        for strat in stratified_populations:
            sp_strat = strat.get(subpopulation.get('population_criterion_type'))
            if sp_strat.get('population_criterion_name') == subpopulation.get('population_criterion_name'):
                result = sp_strat.get('results')
                if result != None:
                    md.appendChild(self.createStratification(sp_strat, result.get('total'), strat.get('stratification'), strat.get('stratum_name')))

#        if stratification != None:
#            md.appendChild(self.createStratification(subpopulation, total, stratification))
        for key in self.supplemental_headers.keys():
            if results != None:
                self.addSupplementalResults(md, key, subpopulation, results.get('supplemental').get(key))
        popref = self.createElementWithAttributes("reference", {"typeCode" : "REFR"})
        md.appendChild(popref)
        e = self.createElementWithAttributes("externalObservation", {"classCode" : "OBS", "moodCode" : "EVN"})
        popref.appendChild(e)
        e.appendChild(self.createElementWithAttributes('id', {'root' : str.upper(str(subpopulation['hqmf_id']))}))
        return node

    def createStratification(self, subpopulation, result, strat_code, strat_name):
        er = self.createElementWithAttributes("entryRelationship", {"typeCode" : "COMP"})
        obs = self.createElementWithAttributes("observation", {"classCode" : "OBS", "moodCode" : "EVN"})
        er.appendChild(obs)
        for attr in self.stratum_headers:
            obs.appendChild(self.createElementWithAttributes(attr[0], attr[1]))
        val = self.createElementWithAttributes("value", {"xsi:type" : "CD", "nullFlavor" : "OTH"})
        obs.appendChild(val)
        t = self.doc.createElement("originalText")
        val.appendChild(t)
        t.appendChild(self.doc.createTextNode(strat_name))
        obs.appendChild(self.createCountObservation(result))
        stratref = self.createElementWithAttributes("reference", {"typeCode" : "REFR"})
        obs.appendChild(stratref)
        e = self.createElementWithAttributes("externalObservation", {"classCode" : "OBS", "moodCode" : "EVN"})
        stratref.appendChild(e)
        e.appendChild(self.createElementWithAttributes('id', {'root' : strat_code}))
        return er


    def addSupplementalResults(self, parent, key, subpopulation, supplemental_results):
        if supplemental_results == None:
            return
        er = self.createElementWithAttributes("entryRelationship", {"typeCode" : "COMP"})
        has_supplemental_results = False
        for result in supplemental_results:
            if result['total'] == None:
                continue
            if self.skip_zero_valued_supplemental_results and result['total'] == 0:
                continue
            has_supplemental_results = True
            obs = self.createSingleSupplementalEntry(key)
            value = self.createElementWithAttributes("value", self.supplemental_value_attributes[key])
            if self.supplemental_value_attributes[key]["xsi:type"] == "CD":
                value.setAttribute("code", result['supplemental_value'])
                if result.get("display_name") != None:
                    value.setAttribute("displayName", result["display_name"])
            elif self.supplemental_value_attributes[key]["xsi:type"] == "ST":
                value.appendChild(self.doc.createTextNode(result['supplemental_value']))
            obs.appendChild(value)
            obs.appendChild(self.createCountObservation(result['total']))
            er.appendChild(obs)
        if has_supplemental_results:
            parent.appendChild(er)      

    def createSingleSupplementalEntry(self, key):
        obs = self.createElementWithAttributes("observation", {"classCode" : "OBS", "moodCode" : "EVN"})
        obs.appendChild(self.generateEffectiveTime(self.reporting_parameters))
        for attr in self.supplemental_headers[key]:
            obs.appendChild(self.createElementWithAttributes(attr[0], attr[1]))
        return obs

    def createMeasureDataElement(self, subpopulation):
        obs = self.createElementWithAttributes("observation", {"classCode" : "OBS", "moodCode" : "EVN"})
        obs.appendChild(self.createElementWithAttributes('templateId', {'root' : "2.16.840.1.113883.10.20.27.3.5"}))
        obs.appendChild(self.createElementWithAttributes("code", {"code" :"ASSERTION", \
                                                                      "codeSystem" : "2.16.840.1.113883.5.4", \
                                                                      "displayName" : "Assertion", \
                                                                      "codeSystemName" :"ActCode"}))
        obs.appendChild(self.createElementWithAttributes("statusCode", {"code" : "completed"}))
        val = self.createElementWithAttributes("value", {"codeSystem" : "2.16.840.1.113883.5.1063", \
                                                             "code" : str.upper(str(subpopulation['population_criterion_type'])), \
                                                             "displayName" : subpopulation['population_criterion_name'], \
                                                             "codeSystemName" : "ObservationValue"})
        obs.appendChild(self.generateEffectiveTime(self.reporting_parameters))
        val.setAttribute("xsi:type", 'CD')
        obs.appendChild(val)
        return obs


    def createCountObservation(self, count):
        er = self.createElementWithAttributes("entryRelationship", {"typeCode" : "SUBJ", "inversionInd" : "true"})
        obs = self.createElementWithAttributes("observation", {"classCode" : "OBS", "moodCode" : "EVN"})
        er.appendChild(obs)
        obs.appendChild(self.generateEffectiveTime(self.reporting_parameters))
        obs.appendChild(self.createElementWithAttributes('templateId', {'root' : "2.16.840.1.113883.10.20.27.3.3"}))
        obs.appendChild(self.createElementWithAttributes("code", {"code" : "MSRAGG", \
                                                                     "displayName" : "rate aggregation", \
                                                                     "codeSystem" : "2.16.840.1.113883.5.4", \
                                                                     "codeSystemName" : "ActCode"}))
        val = self.createElementWithAttributes("value", {"value" : str(count)})
        val.setAttribute("xsi:type", "INT")
        obs.appendChild(val)
        obs.appendChild(self.createElementWithAttributes("methodCode", {"code" : "COUNT", \
                                                                           "displayName" : "Count", \
                                                                           "codeSystem" : "2.16.840.1.113883.5.84", \
                                                                           "codeSystemName" : "ObservationMethod"}))
        return er



    def addMeasure(self, hr, measure):
        measure_data =  hr.measures.get(measure)
        measure_metadata =  hr.measure_metadata.get(measure)
        entry = self.doc.createElement("entry")
        entry.appendChild(self.createMeasureOrganizer(measure_data, measure_metadata))
        self.measureSection.appendChild(entry)
#        for population_name in measure_data.keys():
#            population = measure_data.get(population_name)
#            entry = self.doc.createElement("entry")
#            entry.appendChild(self.createMeasureOrganizer(population_name, population))
#            self.measureSection.appendChild(entry)
        
        
                                     
