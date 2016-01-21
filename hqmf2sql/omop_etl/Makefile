DISTDIR=dist/omop_hqmf_etl

all:

dist:
	mkdir -p $(DISTDIR)/.
	cp README *.sh *.sql $(DISTDIR)/.
	cp -r raw $(DISTDIR)/.
	cp ../create_date_funcs.sql $(DISTDIR)/.
	cp ../valuesets/raw/hl7_template_xref.csv ../valuesets/raw/vocabulary_map.csv $(DISTDIR)/raw/.
	cp ../valuesets/add_to_omop_vocabulary.sql ../valuesets/create_valueset_omop_mappings.sql ../valuesets/create_valueset_tables.sql ../valuesets/load_hl7_tables.sql $(DISTDIR)/.