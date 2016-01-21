/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
lexer grammar HQMFLexer;




LCURLY : '{';
RCURLY : '}';
LBRACKET : '[';
RBRACKET : ']';
COMMA : ',';
COLON : ':';
TRUE : 'true';
FALSE : 'false';
NULL : 'null';

S_ATTRIBUTES : '"attributes"';
S_ALLTRUE : '"allTrue"';
S_ATLEASTONETRUE: '"atLeastOneTrue"';
S_CHILDREN_CRITERIA: '"children_criteria"';
S_CODE : '"code"';
S_CODE_LIST_ID : '"code_list_id"';
S_CONJUNCTION : '"conjunction?"';
S_CONJUNCTION_CODE : '"conjunction_code"';
S_COUNT : '"COUNT"';
S_DATA_CRITERIA : '"data_criteria"';
S_DEFINITION : '"definition"';
S_DESCRIPTION : '"description"';
S_FIRST : '"FIRST"';
S_FIELD_VALUES : '"field_values"';
S_HARD_STATUS : '"hard_status"';
S_HIGH : '"high"';
S_HQMF_ID : '"hqmf_id"';
S_INCLUSIVE : '"inclusive?"';
S_DERIVED : '"derived?"';
S_DERIVATION_OPERATOR : '"derivation_operator"';
S_ID : '"id"';
S_INLINE_CODE_LIST : '"inline_code_list"';
S_LOW : '"low"';
S_MEASURE_PERIOD : '"measure_period"';
S_NEGATION : '"negation"';
S_NEGATION_CODE_LIST_ID : '"negation_code_list_id"';
S_ORDINALITY : '"ORDINALITY"';
S_OVERLAP : '"OVERLAP"';
S_POPULATIONS : '"populations"';
S_POPULATION_CRITERIA : '"population_criteria"';
S_PRECONDITIONS : '"preconditions"';
S_PROPERTY : '"property"';
S_RANGE : '"range"';
S_REASON : '"REASON"';
S_RECENT : '"RECENT"';
S_REFERENCE : '"reference"';
S_SOURCE_DATA_CRITERIA :  '"source_data_criteria"';
S_SPECIFIC_OCCURRENCE : '"specific_occurrence"';
S_SPECIFIC_OCCURRENCE_CONST : '"specific_occurrence_const"';
S_STRAT : '"STRAT"';
S_STRATIFICATION : '"stratification"';
S_STATUS : '"status"';
S_SYSTEM : '"system"';
S_SUBSET_OPERATORS : '"subset_operators"';
S_TITLE : '"title"';
S_TYPE : '"type"';
S_UNIT : '"unit"';
S_UNION: '"UNION"';
S_VALUE : '"value"';
S_VARIABLE : '"variable"';
S_WIDTH : '"width"';
S_XPRODUCT : '"XPRODUCT"';
S_INTERSECT : '"INTERSECT"';
S_TEMPORAL_REFERENCES : '"temporal_references"';

S_IPP : '"IPP"';
S_DENOM : '"DENOM"';
S_NUMER : '"NUMER"';
S_DENEX : '"DENEX"';
S_DENEXCEP : '"DENEXCEP"';

S_SBS : '"SBS"';
S_SBE : '"SBE"';
S_EBS : '"EBS"';
S_EBE : '"EBE"';
S_SAS : '"SAS"';
S_SAE : '"SAE"';
S_EAS : '"EAS"';
S_EAE : '"EAE"';
S_DURING : '"DURING"';
S_SDU : '"SDU"';
S_EDU : '"EDU"';
S_CONCURRENT : '"CONCURRENT"';
S_ECWS : '"ECWS"';
S_SCW : '"SCW"';
S_ECW : '"ECW"';

STRING :  '"' (ESC | ~["\\])* '"' ;

fragment ESC :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

NUMBER
    :   '-'? INT '.' [0-9]+ EXP? // 1.35, 1.35E-9, 0.3, -4.5
    |   '-'? INT EXP             // 1e10 -3e4
    |   '-'? INT                 // -3, 45
    ;
fragment INT :   '0' | [1-9] [0-9]* ; // no leading zeros
fragment EXP :   [Ee] [+\-]? INT ; // \- since - means "range" inside [...]

WS  :   [ \t\n\r]+ -> skip ;

