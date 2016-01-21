/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
parser grammar HQMFParser;

options {
    tokenVocab = HQMFLexer;
}

hqmf: LCURLY clause (COMMA clause)* RCURLY;
        
clause: population_criteria 
    | measure_period        
    | data_criteria         
    | source_data_criteria  
    | populations           
    | metadata
    | attributes
      ;


population_criteria: S_POPULATION_CRITERIA COLON LCURLY population_criterion (COMMA population_criterion)* RCURLY;

population_criterion: any_string COLON LCURLY population_clause (COMMA population_clause)* RCURLY;
                     
population_clause: pop_crit_string_metadata_name COLON any_string            # PopCritStringMetadata
                 | pop_crit_boolean_metadata_name COLON boolean_value        # PopCritBooleanMetadata
                 | preconditions                       # PopulationPreconditions
                 ;

pop_crit_string_metadata : pop_crit_string_metadata_name COLON any_string;
pop_crit_boolean_metadata : pop_crit_boolean_metadata_name COLON boolean_value;

preconditions : S_PRECONDITIONS COLON LBRACKET 
                ( preconditions | single_precondition)
                (COMMA (preconditions | single_precondition))*
                RBRACKET
              ;

single_precondition: LCURLY (pc_element | preconditions) (COMMA (pc_element | preconditions))* RCURLY;

/*
data_precondition : LCURLY data_pc_element (COMMA data_pc_element)* RCURLY;

data_pc_element : S_ID COLON NUMBER                            # DataPCID
                | S_REFERENCE COLON any_string                 # DataPCReference
                ;
*/
pc_element : S_ID COLON NUMBER                            # PCID
           | S_CONJUNCTION_CODE COLON conjunction_type    # PCConjunctionType
           | S_NEGATION COLON boolean_value               # PCNegation
           | S_CONJUNCTION COLON boolean_value            # PCConjunction
           | S_REFERENCE COLON any_string                 # PCReference
           ;
/*

conjunction_precondition: LCURLY conjunction_pc_metadata (COMMA conjunction_pc_metadata)* RCURLY;

conjunction_pc_metadata : S_ID COLON NUMBER                            # ConjunctionPCID
                       | S_CONJUNCTION_CODE COLON conjunction_type    # ConjunctionPCConjunctionCode
                       | S_NEGATION COLON boolean_value               # ConjunctionPCNegation
                       | S_CONJUNCTION COLON boolean_value            # ConjunctionPCConjunction
                       | preconditions                                # ConjunctionPreconditions
                       ;

*/

data_criteria: S_DATA_CRITERIA COLON LCURLY data_criterion (COMMA data_criterion)* RCURLY;

data_criterion: any_string COLON LCURLY data_clause (COMMA data_clause)* RCURLY;

data_clause: data_string_attribute COLON any_string                 # StringDataClause
           | data_bool_attribute COLON boolean_value                # BooleanDataClause
           | inline_code_list                                       # InlineCodeList
           | S_DERIVATION_OPERATOR COLON derivation_operator        # DerivationOperator
           | S_CHILDREN_CRITERIA COLON LBRACKET
             any_string (COMMA any_string)*
             RBRACKET                                               # ChildrenCriteria
           | S_SUBSET_OPERATORS COLON LBRACKET
             subset_operator (COMMA subset_operator)* 
             RBRACKET                                               # SubsetOperators
           | S_TEMPORAL_REFERENCES COLON LBRACKET temporal_reference (COMMA temporal_reference)* RBRACKET # TemporalReferences
           | value_spec                                             # ValueDataClause
           | S_FIELD_VALUES COLON LCURLY
             field_value (COMMA field_value)*
             RCURLY                                               # FieldValues
	   ;

field_value: field_name COLON LCURLY field_value_clause (COMMA field_value_clause)* RCURLY;

field_value_clause: field_metadata_type COLON any_string;

inline_code_list : S_INLINE_CODE_LIST COLON LCURLY code_type COLON LBRACKET
                   any_string (COMMA any_string)*
                   RBRACKET RCURLY;

subset_operator : LCURLY subset_element (COMMA subset_element)* RCURLY;

subset_element: S_TYPE COLON subset_operator_name    # SubsetType
              | value_spec                           # SubsetValue
              ;

value_spec : S_VALUE COLON LCURLY value_attribute (COMMA value_attribute)* RCURLY;

value_attribute : value_attribute_name COLON any_string          # ValueAttribute
                | range_element                                  # ValueRange
                ;

populations: S_POPULATIONS COLON LBRACKET population (COMMA population)* RBRACKET;

population: LCURLY population_attribute (COMMA population_attribute)* RCURLY;

population_attribute : population_type COLON any_string               # PopulationType
                     | population_metadata COLON any_string           # MeasurePopulationMetadata
                     ;


measure_period: S_MEASURE_PERIOD COLON LCURLY
                range_element (COMMA range_element)*
                RCURLY;


source_data_criteria: S_SOURCE_DATA_CRITERIA COLON LCURLY data_criterion (COMMA data_criterion)* RCURLY;

attributes : S_ATTRIBUTES COLON array;

temporal_reference : LCURLY temporal_element (COMMA temporal_element)* RCURLY;

temporal_element : S_TYPE COLON temporal_operator            # TemporalOperator
                 | S_REFERENCE COLON any_string              # TemporalRef
                 | temporal_range                                     # TemporalRange
                 ;

temporal_range : | S_RANGE COLON LCURLY
                   range_element (COMMA range_element)*
                   RCURLY
                 ;


range_element : S_TYPE COLON any_string                      # RangeType
              | highlow COLON LCURLY range_attribute (COMMA range_attribute)* RCURLY  # RangeHighLow
              ;

range_attribute: range_string_attribute_name COLON any_string       # RangeStringAttribute
               | range_boolean_attribute_name COLON boolean_value   # RangeBooleanAttribute
               ;



metadata: any_string COLON simple_value;



identifier: population_type;


json_object
    :   LCURLY pair (COMMA pair)* RCURLY
    |   LCURLY RCURLY // empty json_object
    ;
pair:   any_string COLON value ;

any_string: STRING
          | keyword
          ;

array
    :   LBRACKET value (COMMA value)* RBRACKET
    |   LBRACKET RBRACKET // empty array
    ;

simple_value
    :   STRING
    |   keyword
    |   NUMBER
    |   TRUE  // keywords
    |   FALSE
    |   NULL
    ;

value
    :   STRING
    |   keyword
    |   NUMBER
    |   json_object  // recursion
    |   array   // recursion
    |   TRUE  // keywords
    |   FALSE
    |   NULL
    ;

boolean_value
    : TRUE
    | FALSE
    | NULL
    ;

keyword
    : population_type  
    | data_string_attribute
    | data_bool_attribute
    | data_other
    | highlow
    | range_boolean_attribute_name
    | range_string_attribute_name
    | temporal_operator
    | value_attribute_name
    | subset_operator_name
    | population_metadata
    | pc_metadata_name
    | conjunction_type
    | pop_crit_boolean_metadata_name
    | pop_crit_string_metadata_name
    | S_REFERENCE
    | S_DATA_CRITERIA
    | S_MEASURE_PERIOD
    | S_POPULATIONS
    | S_POPULATION_CRITERIA
    ;

data_string_attribute 
    : S_TITLE
    | S_DESCRIPTION
    | S_CODE_LIST_ID
    | S_NEGATION_CODE_LIST_ID
    | S_TYPE
    | S_DEFINITION
    | S_STATUS
    | S_PROPERTY
    | S_SPECIFIC_OCCURRENCE
    | S_SPECIFIC_OCCURRENCE_CONST
    | S_SOURCE_DATA_CRITERIA
    ;
    
data_bool_attribute    
    : S_HARD_STATUS
    | S_NEGATION
    | S_VARIABLE
    ;

data_other    
    : S_INLINE_CODE_LIST
    | S_VALUE
    | S_SUBSET_OPERATORS
    | S_TEMPORAL_REFERENCES
    ;

population_type: S_IPP
                | S_DENOM
                | S_NUMER
                | S_DENEX
                | S_DENEXCEP
                ;

population_metadata
    : S_ID
    | S_TYPE
    | S_TITLE
    | S_STRAT
    | S_STRATIFICATION
    ;

highlow
    : S_HIGH
    | S_LOW
    | S_WIDTH
    ;

range_string_attribute_name
    : S_TYPE
    | S_UNIT
    | S_VALUE
    ;

range_boolean_attribute_name
    : S_INCLUSIVE
    | S_DERIVED
    ;

temporal_operator
    : S_SBS
    | S_SBE
    | S_EBS
    | S_EBE
    | S_SAS
    | S_SAE
    | S_EAS
    | S_EAE
    | S_DURING
    | S_SDU
    | S_EDU
    | S_CONCURRENT
    | S_ECWS
    | S_SCW
    | S_ECW
    | S_OVERLAP
    ;

value_attribute_name
    : S_TYPE
    | S_SYSTEM
    | S_CODE
    | S_CODE_LIST_ID
    | S_TITLE
    ;

subset_operator_name
    : S_FIRST
    | S_RECENT
    | S_COUNT
    ;

code_type : STRING;

conjunction_type
    : S_ALLTRUE
    | S_ATLEASTONETRUE
    ;

pc_metadata_name
    : S_ID
    | S_REFERENCE
    | S_CONJUNCTION_CODE
    | S_NEGATION
    ;

pop_crit_string_metadata_name
    : S_HQMF_ID
    | S_TYPE
    | S_TITLE
    ;

pop_crit_boolean_metadata_name
    : S_CONJUNCTION
    ;

derivation_operator
    : S_UNION
    | S_INTERSECT
    ;

field_metadata_type
    : S_TYPE
    | S_CODE_LIST_ID
    | S_TITLE
    ;

field_name
    : S_REASON
    | S_ORDINALITY
    ;