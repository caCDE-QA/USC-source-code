#!/usr/bin/python

import sys
from sqlalchemy import *
from sqlalchemy.sql.expression import *
from sqlalchemy.types import Boolean, Integer, String, DateTime
from sqlalchemy.schema import CreateTable
from sqlalchemy.exc import *

class HQMFResults:

    supplemental_codes = {"race" : "(4013886)", \
                                "ethnicity" : "(4271761)", \
                                "payer" : "(3048872)", \
                                "sex" : "(8507,8532)", \
                                "zip" : "(4083591)"}

    def __init__(self, dburl, hqmf_schema, result_schema):
        self.dburl=dburl
        self.hqmf_schema=hqmf_schema
        self.result_schema=result_schema
        self.engine = create_engine(dburl)
        self.conn = self.engine.connect()
        self.meta = MetaData()
        self.meta.reflect(bind=self.engine, schema=hqmf_schema, views=True)
        self.meta.reflect(bind=self.engine, schema=result_schema, views=True)
        self.measures = dict()
        self.measure_metadata = dict()
        self.results = dict()
        self.supplemental_results = dict()
        self.parameters = dict()


    def exists(self, measure):
        return self.meta.tables.get(self.metadata_table_name(measure)) is not None

    def metadata_table_name(self, measure_name):
        return self.result_schema + '.' + measure_name + '_measure_metadata'

    def process_measure(self, measure_name):
        if self.measures.get(measure_name) != None:
            return
        measure_populations = dict()

        # first get measure metadata
        metadata_table = self.meta.tables.get(self.metadata_table_name(measure_name))
        if metadata_table == None:
            raise ValueError("Can't find metadata table " + metadata_table_name + "\n")

        sel = select(metadata_table.c)
        result = self.conn.execute(sel)
        for row in result.fetchall():
            if self.measure_metadata.get(measure_name) == None:
                md = dict()
                for key in ['measure_id', 'hqmf_id', 'hqmf_set_id', 'hqmf_version_number', 'title']:
                    md[key] = row[key]
                self.measure_metadata[measure_name] = md

            # global start/end - should really check that these are consistent for all measures in set
            if self.parameters.get('measure_period_start') == None:
                self.parameters['measure_period_start'] = row['measure_period_start']
            if self.parameters.get('measure_period_end') == None:
                self.parameters['measure_period_end'] = row['measure_period_end']
            key = self.measure_key(row['cms_id'], row['population_name'])
            measure_populations[row['population_name']] = self.row_to_dict(row)

        # Then get population metadata
        result_table_name = self.result_schema + '.' + measure_name + '_results'
        pop_table_name = self.result_schema + '.' + measure_name + '_population_metadata'
        pop_table = self.meta.tables.get(pop_table_name)
        sel = select(pop_table.c)
        result = self.conn.execute(sel)
        for row in result.fetchall():
            measure_populations.get(row['population_name'])[row['population_criterion_type'].lower()] = self.row_to_dict(row)

        # Then get results
        result_table_name = self.result_schema + '.' + measure_name + '_results'
        result_table = self.meta.tables.get(result_table_name)
        sel = select(result_table.c)
        result = self.conn.execute(sel)
        
        for row in result.fetchall():
            mp = measure_populations.get(row['population_name'])
            ptype = row['population_criterion_type']
            mp[ptype]['results'] = self.row_to_dict(row)
            mp[ptype]['results']['supplemental'] = dict()
            
        supplemental_result_table_name = self.result_schema + '.' + measure_name + '_supplemental_results'
        supplemental_result_table = self.meta.tables.get(supplemental_result_table_name)
        sel = select(supplemental_result_table.c)
        result = self.conn.execute(sel)

        for row in result.fetchall():
            mp = measure_populations.get(row['population_id'])
            ptype = row['population_criterion_type']
            supp = mp[ptype]['results']['supplemental']
            scode = row['supplemental_code']
            if supp.get(scode) == None:
                supp[scode] = []
            supp[scode].append(self.row_to_dict(row))

        self.measures[measure_name] = measure_populations
        
        
    def row_to_key(self, row):
        try:
            popid = row['population_id']
        except NoSuchColumnError:
            popid = row['population_name']
        return self.measure_key(row['cms_id'], popid)

    def row_to_dict(self, row):
        d = dict()
        for key in row.keys():
            d[key] = row[key]
        return d

    def measure_key(self, cms_id, population_name):
        if population_name == None:
           return cms_id
        else:
           return cms_id+population_name

if __name__ == '__main__':
    hr = HQMFResults("postgresql+psycopg2:///cqm", "hqmf_test", "results")
    hr.process_measure('cms69v3')
    print(str(hr.measure_populations))
                



            

