parser grammar HQMFv1XMLParser;
options { tokenVocab=HQMFv1XMLLexer; }

// from code/lexmagic/XMLParser.g4

document    :   prolog? misc* quality_measure_document misc*;

prolog      :   XMLDeclOpen attribute* SPECIAL_CLOSE ;

content     :   text?
                ((any_element | reference | CDATA | PI | comment) chardata?)* ;


quality_measure_document  : '<' S_QUALITY_MEASURE_DOCUMENT attribute* '>' content SEA_WS? '<' '/' S_QUALITY_MEASURE_DOCUMENT '>';

qmd_content  : subject_of                                      # SubjectOf
             | component                                       # qmdComponent
             | metadata_element                                 # MiscMetadata
             | comment                                         # HeaderComment
             ;
             

component : '<' S_COMPONENT attribute* '>'
            '<' S_SECTION attribute* '>'
         (population_criteria_section
         | data_criteria_section
         | stratification_section
         | supplemental_reporting_section
         | any_element)*
            '<' '/' S_SECTION '>'
            '<' '/' S_COMPONENT '>'
          ;


population_criteria_section : population_criteria_element*
                              population_criteria_section_tag
                              population_criteria_element*
                            ;

data_criteria_section : data_criteria_element*
                              data_criteria_section_tag
                              data_criteria_element*
                            ;

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

title_element : '<' S_TITLE attribute* '>' content '<' '/' S_TITLE '>' ;
text_element : '<' S_TEXT attribute* '>' content '<' '/' S_TEXT '>' ;
entry_element :  '<' S_ENTRY attribute* '>' content '<' '/' S_ENTRY '>' ;
act_element : '<' S_ACT attribute* '>' content '<' '/' S_ACT '>' ;

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
             | S_CODE
             | S_CODESYSTEM
             | S_COMPONENT
             | S_DISPLAYNAME
             | S_ENTRY
             | S_SECTION
             | S_SUBJECTOF
             | S_TEXT
             | S_TITLE
             | S_ACT
             ;

value_keyword : C_LOINC
              | C_LOINC_POPULATION_CRITERIA
              | C_LOINC_DATA_CRITERIA
              | C_LOINC_STRATIFICATION
              | C_LOINC_SUPPLEMENTAL
              | C_HL7_OBSERVATIONVALUE
              | C_HL7_IPP
              ;

any_element : component
            | metadata_element
            | element
            ;

element     :   '<' Name attribute* '>' content '<' '/' Name '>'
            |   '<' Name attribute* '/>'
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
