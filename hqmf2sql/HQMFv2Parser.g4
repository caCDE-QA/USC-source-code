parser grammar HQMFv2Parser;
options { tokenVocab=HQMFv2Lexer; }

// from code/lexmagic/XMLParser.g4

document    :   prolog? misc* quality_measure_document misc*;

prolog      :   XMLDeclOpen attribute* SPECIAL_CLOSE ;

content     :   text?
              ((any_element | reference | CDATA | PI | comment) chardata?)* ;


quality_measure_document  : '<' S_QUALITY_MEASURE_DOCUMENT attribute* '>' qmd_content* SEA_WS? '<' '/' S_QUALITY_MEASURE_DOCUMENT '>';

qmd_content  : subject_of                                      # SubjectOf
             | component                                       # QMDComponent
             | header_element                                  # HeaderMetadata
             | comment                                         # HeaderComment
             ;
             
header_element     :   '<' header_keyword attribute* '>' content '<' '/' header_keyword '>'
            |   '<' header_keyword attribute* '/>'
            ;

component : '<' S_COMPONENT attribute* '>'
         (data_criteria_section | population_criteria_section | measure_description_section | measure_observations_section)*
            '<' '/' S_COMPONENT '>'
          ;

data_criteria_section : '<' S_DATACRITERIASECTION '>' data_criterion_section_entry* '<' '/' S_DATACRITERIASECTION '>' ;
population_criteria_section : '<' S_POPULATIONCRITERIASECTION '>' content '<' '/' S_POPULATIONCRITERIASECTION '>' ;
measure_description_section : '<' S_MEASUREDESCRIPTIONSECTION '>' content '<' '/' S_MEASUREDESCRIPTIONSECTION '>' ;
measure_observations_section : '<' S_MEASUREOBSERVATIONSSECTION '>' content '<' '/' S_MEASUREOBSERVATIONSSECTION '>' ;

data_criterion_section_entry : data_criteria_section_header_element
                            | data_criterion
                            | local_variable_name
                            | data_criterion
                            | comment
                            ;

data_criteria_section_header_element     :
            '<' data_criteria_section_header_keyword attribute* '>' content '<' '/' data_criteria_section_header_keyword '>'
                                          | '<' data_criteria_section_header_keyword attribute* '/>'
            ;

data_criterion : '<' S_ENTRY attribute* '>'
                 data_criterion_entry_content*
                 '<' '/' S_ENTRY '>'
               ;

data_criterion_entry_content : local_variable_name | act_criterion ;

act_criterion : '<' act_criteria_type attribute* '>' act_criteria_content* '<' '/' act_criteria_type '>' ;

act_criteria_content : template_id_element
                     | id_element
                     | code_element
                     | title_element
                     | status_code_element
                     | outbound_relationship_element
                     | value_element
                     ;

local_variable_name : '<' S_LOCALVARIABLENAME S_VALUE '=' any_value '/>' ;

stratification_section : stratification_element*
                              stratification_section_tag
                              stratification_element*
                            ;

supplemental_reporting_section : supplemental_reporting_element*
                              supplemental_reporting_section_tag
                              supplemental_reporting_element*
                            ;


population_criteria_section_tag : '<' S_CODE attribute* S_CODE '=' C_LOINC_POPULATION_CRITERIA attribute* '/>' ;
data_criteria_section_tag : '<' S_CODE attribute* S_CODE '=' C_LOINC_DATA_CRITERIA attribute* '/>' ;
stratification_section_tag : '<' S_CODE attribute* S_CODE '=' C_LOINC_STRATIFICATION attribute* '/>' ;
supplemental_reporting_section_tag : '<' S_CODE attribute* S_CODE '=' C_LOINC_SUPPLEMENTAL attribute* '/>' ;

title_element : '<' S_TITLE attribute* '>' content '<' '/' S_TITLE '>'
              | '<' S_TITLE attribute* '/>'
              ;
text_element : '<' S_TEXT attribute* '>' content '<' '/' S_TEXT '>' ;
id_element : '<' S_ID attribute* '/>' ;
code_element: '<' S_CODE attribute* '>' content '<' '/' S_CODE '>' ;
template_id_element : '<' S_TEMPLATEID attribute* '>' 
 '<' S_ITEM attribute* '/>'
'<' '/' S_TEMPLATEID '>' ;
entry_element :  '<' S_ENTRY attribute* '>' content '<' '/' S_ENTRY '>' ;
act_element : '<' S_ACT attribute* '>' content '<' '/' S_ACT '>' ;
status_code_element : '<' S_STATUSCODE attribute* '/>' ;
value_element : '<' S_VALUE attribute* '>' content '<' '/' S_VALUE '>'
              | '<' S_VALUE attribute* '/>'
              ;
outbound_relationship_element : '<' S_OUTBOUNDRELATIONSHIP attribute* '>' content '<' '/' S_OUTBOUNDRELATIONSHIP '>' ;

data_criteria_section_header_keyword : S_TEMPLATEID
                                     | S_CODE
                                     | S_TITLE
                                     | S_TEXT
                                     ;

population_criteria_element: title_element
                           | text_element
                           | entry_element
                           | act_element
                           ;

data_criteria_element: title_element
                           | text_element
                           | entry_element
                           ;

stratification_element: title_element
                           | text_element
                           | entry_element
                           ;

supplemental_reporting_element: title_element
                           | text_element
                           | entry_element
                           ;
                      
subject_of :  '<' S_SUBJECTOF attribute* '>' content '<' '/' S_SUBJECTOF '>'
          | '<' S_SUBJECTOF attribute* '/>'
          ;

              
metadata_element : '<' any_name attribute* '>' content '<' '/' any_name '>' 
                 | '<' any_name attribute* '/>'
                 ;

any_name : name_keyword | Name ;

any_value : value_keyword
          | QUOTE name_keyword QUOTE
          | STRING
          ;

name_keyword : S_QUALITY_MEASURE_DOCUMENT
             | header_keyword
             | S_DISPLAYNAME
             | S_COMPONENT
             | S_ENTRY
             | S_SECTION
             | S_ACT
             | S_DATACRITERIASECTION
             | S_POPULATIONCRITERIASECTION
             | S_MEASUREOBSERVATIONSSECTION
             | S_MEASUREDESCRIPTIONSECTION
             | S_VALUE
             | S_ITEM
             ;

act_criteria_type : S_ACTCRITERIA
                  | S_OBSERVATIONCRITERIA
                  | S_PROCEDURECRITERIA
                  | S_ENCOUNTERCRITERIA
                  | S_SUPPLYCRITERIA
                  | S_GROUPERCRITERIA
                  ;
                       
header_keyword : S_TYPEID 
             | S_TEMPLATEID 
             | S_ID 
             | S_CODE 
             | S_TITLE 
             | S_TEXT 
             | S_STATUSCODE 
             | S_EFFECTIVETIME 
             | S_AVAILABILITYTIME 
             | S_LANGUAGECODE 
             | S_SETID 
             | S_VERSIONNUMBER 
             | S_AUTHOR 
             | S_CUSTODIAN 
             | S_VERIFIER 
             | S_CONTROLVARIABLE 
             | S_SUBJECTOF 
             | S_COMPONENTOF 
             | S_CODESYSTEM
             | S_DEFINITION 
             | S_LOCALVARIABLENAME
             | S_ACTCRITERIA
             ;

value_keyword : C_HL7_OID
              | C_HL7_HQMFV2
              | C_QDM_TEMPLATE
              | C_LOINC
              | C_LOINC_POPULATION_CRITERIA
              | C_LOINC_DATA_CRITERIA
              | C_LOINC_STRATIFICATION
              | C_LOINC_SUPPLEMENTAL
              | C_HL7_OBSERVATIONVALUE
              | C_HL7_IPP
              ;


any_element : qmd_content
            | metadata_element
            | element
            ;


element     :   '<' any_name attribute* '>' content '<' '/' any_name '>'
            |   '<' any_name attribute* '/>'
            ;

reference   :   EntityRef | CharRef ;

attribute   :   any_name '=' any_value ; 

/** ``All text that is not markup constitutes the character data of
 *  the document.''
 */

comment : COMMENT ;

text : TEXT ;

chardata    :   TEXT | SEA_WS ;

misc        :   COMMENT | PI | SEA_WS ;
