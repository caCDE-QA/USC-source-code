import json
from HQMFParserListener import HQMFParserListener
from HQMFParser import *
from HQMFUtil import *
from collections.abc import Mapping
from HQMFData import *

class HQMFCustomEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, DataCriterion) or isinstance(obj, ValueSpec) or isinstance(obj, MeasurePeriod):
            return obj.to_json()

        return json.JSONEncoder.default(self, obj)

class MeasurePopulation:
    def __init__(self):
        self.population_names = dict()
        self.population_metadata = dict()

    def set_population_name(self, population_type, population_name):
        self.population_names[population_type] = population_name

    def get_population_name(self, population_type):
        return self.population_names.get(population_type)

    def set_population_metadata(self, name, val):
        self.population_metadata[name] = val

    def get_population_metadata(self, name):
        return self.population_metadata.get(name)

class SymbolTable:
    def __init__(self):
        self.data_criteria = dict()
        self.data_criteria_names_used = set()
        self.specific_occurrences_used = dict()
        self.measure_period = None
        self.so_temporal_dependencies = dict()
        self.metadata = dict()
        self.populations = []

# population_names -- names of population criteria for IPP, DENOM, etc.
        self.population_names = []

    def add_so_dependency(self, lhs, rhs):
        so_set = self.so_temporal_dependencies.get(lhs)
        if so_set == None:
            self.so_temporal_dependencies[lhs] = set()
        self.so_temporal_dependencies.get(lhs).add(rhs)

    def get_data_criterion(self, name):
        return self.data_criteria.get(name)

    def add_data_criterion(self, name, data_criterion):
        self.data_criteria[name] = data_criterion

    def get_data_criteria_names(self):
        return self.data_criteria.keys()

    def get_measure_period(self):
        return self.measure_period

    def set_measure_period(self, mp):
        self.measure_period = mp

    def get_specific_occurrence(self, so_const, so_inst):
        d = self.specific_occurrences_used(so_const)
        if d == None:
            return None
        return d.get(so_inst)
    
    def get_data_criteria_names_used(self):
        return self.data_criteria_names_used

    def add_data_criteria_names_used(self, name):
        self.data_criteria_names_used.add(name)

    def add_metadata(self, name, value):
        self.metadata[name] = value

    def get_metadata(self, name):
        return self.metadata.get(name)

class SymbolTableBuilder (HQMFParserListener) :
    def __init__(self, symbol_table):
        self.symbol_table = symbol_table
    
    def enterData_criterion(self, ctx):
        ctx.parsed_data_criterion = DataCriterion(ctx)

    def exitData_criterion(self, ctx):
        self.symbol_table.add_data_criterion(ctx.parsed_data_criterion.name, ctx.parsed_data_criterion)
        child=self.symbol_table.get_data_criterion(ctx.parsed_data_criterion.name)

    def enterStringDataClause(self, ctx) :
        cname = strip_quotes(ctx.data_string_attribute().getText())
        cval = strip_quotes(ctx.any_string().getText())
        ctx.parentCtx.parsed_data_criterion.set_attribute(cname, cval)

    def enterBooleanDataClause(self, ctx) :
        cname = strip_quotes(ctx.data_bool_attribute().getText())
        bval = string_to_boolean(ctx.boolean_value().getText())
        ctx.parentCtx.parsed_data_criterion.set_attribute(cname, bval)

    def enterDerivationOperator(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_derivation_operator(strip_quotes(ctx.derivation_operator().getText()))

    def enterChildrenCriteria(self, ctx):
        ctx.parentCtx.parsed_data_criterion.children = []
        for c in ctx.any_string():
            ctx.parentCtx.parsed_data_criterion.add_child_criterion_name(strip_quotes(c.getText()))

    def enterTemporalReferences(self, ctx):
        ctx.parsed_temporal_references = []
        ctx.parentCtx.parsed_data_criterion.set_temporal_references(ctx.parsed_temporal_references)

    def enterTemporal_reference(self, ctx):
        ctx.parsed_range = None
        ctx.parsed_temporal_reference = TemporalReference(ctx)

    def exitTemporal_reference(self, ctx):
        if ctx.parsed_range != None:
            ctx.parsed_temporal_reference.set_range(ctx.parsed_range)
        ctx.parentCtx.parsed_temporal_references.append(ctx.parsed_temporal_reference)

    def enterTemporalOperator(self, ctx):
        ctx.parentCtx.parsed_temporal_reference.set_operator(strip_quotes(ctx.temporal_operator().getText()))

    def enterTemporalRef(self, ctx):
        ref = strip_quotes(ctx.any_string().getText())
        ctx.parentCtx.parsed_temporal_reference.set_reference(ref)
        
    def enterTemporalRange(self, ctx):
        ctx.parsed_range = dict()

    def exitTemporalRange(self, ctx):
        ctx.parentCtx.parsed_range = ctx.parsed_range

    def enterTemporal_range(self, ctx):
        ctx.parsed_range = dict()

    def exitTemporal_range(self, ctx):
        ctx.parentCtx.parsed_range = ctx.parsed_range

    def enterRangeType(self, ctx):
        ctx.parentCtx.parsed_range['type'] = strip_quotes(ctx.any_string().getText())

    def enterRangeHighLow(self, ctx):
        ctx.parsed_high_or_low = dict()
        ctx.parsed_label = strip_quotes(ctx.highlow().getText())

    def exitRangeHighLow(self, ctx):
        ctx.parentCtx.parsed_range[ctx.parsed_label] = ctx.parsed_high_or_low

    def enterRangeStringAttribute(self, ctx):
        ctx.parentCtx.parsed_high_or_low[strip_quotes(ctx.range_string_attribute_name().getText())] = \
        strip_quotes(ctx.any_string().getText())

    def enterRangeBooleanAttribute(self, ctx):
        ctx.parentCtx.parsed_high_or_low[strip_quotes(ctx.range_boolean_attribute_name().getText())] = \
        string_to_boolean(ctx.boolean_value().getText())
        
    def enterValueDataClause(self, ctx):
        ctx.parsed_value = ValueSpec(ctx)

    def exitValueDataClause(self, ctx):
        ctx.parentCtx.parsed_data_criterion.set_value(ctx.parsed_value)

    def enterSubsetValue(self, ctx):
        ctx.parsed_value = ValueSpec(ctx)

    def exitSubsetValue(self, ctx):
        ctx.parentCtx.parsed_subset['value'] = ctx.parsed_value

    def enterValueAttribute(self, ctx):
        ctx.parentCtx.parentCtx.parsed_value.set_value(
            strip_quotes(ctx.value_attribute_name().getText()),
            strip_quotes(ctx.any_string().getText()))

    def enterValueRange(self, ctx):
        ctx.parsed_range = dict()

    def exitValueRange(self, ctx):
        ctx.parentCtx.parentCtx.parsed_value.set_range(ctx.parsed_range)

    def enterInline_code_list(self, ctx):
        ctx.parsed_inline_code_list = InlineCodeList(ctx)
        ctx.parsed_inline_code_list.code_type = strip_quotes(ctx.code_type().getText())
        for s in ctx.any_string():
            ctx.parsed_inline_code_list.codes.append(strip_quotes(s.getText()))
            

    def exitInline_code_list(self, ctx):
        ctx.parentCtx.parentCtx.parsed_data_criterion.set_inline_code_list(ctx.parsed_inline_code_list)

    def enterSubset_operator(self, ctx):
        ctx.parsed_subset = dict()

    def exitSubset_operator(self, ctx):
        ctx.parentCtx.parentCtx.parsed_data_criterion.add_subset_operator(ctx.parsed_subset)

    def enterSubsetType(self, ctx):
        ctx.parentCtx.parsed_subset['type'] = strip_quotes(ctx.subset_operator_name().getText())

    def enterMeasure_period(self, ctx):
        ctx.parsed_range = dict()
        ctx.parsed_measure_period = MeasurePeriod(ctx)

    def exitMeasure_period(self, ctx):
        ctx.parsed_measure_period.set_range(ctx.parsed_range)
        self.symbol_table.set_measure_period(ctx.parsed_measure_period)

    def enterPopulation(self, ctx):
        ctx.parsed_population = MeasurePopulation()

    def exitPopulation(self, ctx):
        self.symbol_table.populations.append(ctx.parsed_population)

    def enterPopulationType(self, ctx):
        ctx.parentCtx.parsed_population.set_population_name(strip_quotes(ctx.population_type().getText()), strip_quotes(ctx.any_string().getText()))

    def enterMeasurePopulationMetadata(self, ctx):
        ctx.parentCtx.parsed_population.set_population_metadata(strip_quotes(ctx.population_metadata().getText()), strip_quotes(ctx.any_string().getText()))

    def enterPCReference(self, ctx):
        self.symbol_table.add_data_criteria_names_used(strip_quotes(ctx.any_string().getText()))

    def exitHqmf(self, ctx):
        descendants = set()
        for name in self.symbol_table.get_data_criteria_names_used():
            self.dc_children(self.symbol_table.get_data_criterion(name), descendants)
            self.dc_temporal_children(self.symbol_table.get_data_criterion(name), descendants)
        for name in descendants:
            self.symbol_table.add_data_criteria_names_used(name)

    def dc_children(self, dc, children):
        if dc.children != None:
            for child in dc.get_child_criteria_names():
                children.add(child)
                self.dc_children(self.symbol_table.get_data_criterion(child), children)

    def dc_temporal_children(self, dc, children):
        for t in dc.temporal_references:
            ref = t.get_reference()
            if ref != None and ref != 'MeasurePeriod':
                children.add(ref)
                rdc = self.symbol_table.get_data_criterion(ref)
                self.dc_temporal_children(rdc, children)
                self.dc_children(rdc, children)
                if dc.is_specific_occurrence() and rdc.is_specific_occurrence:
                    self.symbol_table.add_so_dependency(dc.name, rdc.name)
                

    def enterMetadata (self, ctx):
        self.symbol_table.add_metadata(strip_quotes(ctx.any_string().getText()), strip_quotes(ctx.simple_value().getText()))

#    def exitMetadata (self, ctx):
#        print("exit metadata")
