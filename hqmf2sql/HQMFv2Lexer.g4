lexer grammar HQMFv2Lexer;

// From code/lexmagic/XMLLexer.g4

// Default "mode": Everything OUTSIDE of a tag
COMMENT     :   '<!--' .*? '-->'       ;
CDATA       :   '<![CDATA[' .*? ']]>' ;
/** Scarf all DTD stuff, Entity Declarations like <!ENTITY ...>,
 *  and Notation Declarations <!NOTATION ...>
 */
DTD         :   '<!' .*? '>'            -> skip ; 
EntityRef   :   '&' Name ';' ;
CharRef     :   '&#' DIGIT+ ';'
            |   '&#x' HEXDIGIT+ ';'
            ;
SEA_WS      :   (' '|'\t'|'\r'? '\n') ;

WS : ([ \t\r\n])+ -> skip;

OPEN        :   '<'                     -> pushMode(INSIDE) ;
XMLDeclOpen :   '<?xml' S               -> pushMode(INSIDE) ;
SPECIAL_OPEN:   '<?' Name               -> more, pushMode(PROC_INSTR) ;


QUOTE : '"' ;

TEXT        :   ~[<&]+ ;        // match any 16 bit char other than < and &

// ----------------- Everything INSIDE of a tag ---------------------
mode INSIDE;
S_QUALITY_MEASURE_DOCUMENT : 'QualityMeasureDocument';

// HQMF v2 headers
S_TYPEID : 'typeId' ;
S_TEMPLATEID : 'templateId' ;
S_ID : 'id' ;
S_CODE : 'code' ;
S_TITLE : 'title' ;
S_TEXT : 'text' ;
S_STATUSCODE : 'statusCode' ;
S_EFFECTIVETIME : 'effectiveTime' ;
S_AVAILABILITYTIME : 'availabilityTime' ;
S_LANGUAGECODE : 'languageCode' ;
S_SETID : 'setId' ;
S_VERSIONNUMBER : 'versionNumber' ;
S_AUTHOR : 'author';
S_CUSTODIAN : 'custodian' ;
S_VERIFIER : 'verifier' ;
S_CONTROLVARIABLE : 'controlVariable';
S_SUBJECTOF : 'subjectOf' ;
S_COMPONENTOF : 'componentOf' ;
S_COMPONENT : 'component' ;
S_DATACRITERIASECTION : 'dataCriteriaSection' ;
S_POPULATIONCRITERIASECTION : 'populationCriteriaSection' ;
S_MEASUREOBSERVATIONSSECTION : 'measureObservationsSection' ;
S_MEASUREDESCRIPTIONSECTION : 'measureDescriptionSection' ;
S_DEFINITION : 'definition' ;
S_ACTDEFINITION : 'actDefinition' ;
S_ENTRY : 'entry' ;
S_LOCALVARIABLENAME : 'localVariableName' ;
S_ACTCRITERIA : 'actCriteria' ;
S_ENCOUNTERCRITERIA : 'encounterCriteria' ;
S_OBSERVATIONCRITERIA : 'observationCriteria' ;
S_PROCEDURECRITERIA : 'procedureCriteria' ;
S_SUPPLYCRITERIA : 'supplyCriteria' ;
S_GROUPERCRITERIA : 'grouperCriteria' ;
S_VALUE : 'value' ;
S_DISPLAYNAME : 'displayName' ;
S_ITEM : 'item' ;
S_OUTBOUNDRELATIONSHIP : 'outboundRelationship' ;



S_SECTION : 'section' ;
S_CODESYSTEM : 'codeSystem' ;
S_ACT : 'act' ;

C_HL7_OID : '"2.16.840.1.113883.1.3"' ;
C_HL7_HQMFV2 : '"POQM_HD000001UV02 "' ;
C_QDM_TEMPLATE : '"2.16.840.1.113883.10.20.28.1.1"' ;


C_LOINC : '"2.16.840.1.113883.6.1"' ;
C_LOINC_POPULATION_CRITERIA : '"57026-7"' ;
C_LOINC_DATA_CRITERIA : '"57025-9"' ;
C_LOINC_STRATIFICATION : '"69669-0"' ;
C_LOINC_SUPPLEMENTAL : '"69670-8"' ;
C_HL7_OBSERVATIONVALUE : '"2.16.840.1.113883.5.1063"' ;
C_HL7_IPP : '"IPP"' ;

CLOSE       :   '>'                     -> popMode ;
SPECIAL_CLOSE:  '?>'                    -> popMode ; // close <?xml...?>
SLASH_CLOSE :   '/>'                    -> popMode ;
SLASH       :   '/' ;
EQUALS      :   '=' ;
STRING      :   '"' ~[<"]* '"'
            |   '\'' ~[<']* '\''
            ;

Name        :   NameStartChar NameChar* ;
S           :   [ \t\r\n]               -> skip ;

fragment
HEXDIGIT    :   [a-fA-F0-9] ;

fragment
DIGIT       :   [0-9] ;

fragment
NameChar    :   NameStartChar
            |   '-' | '.' | DIGIT | '_'
            |   '\u00B7'
            |   '\u0300'..'\u036F'
            |   '\u203F'..'\u2040'
            ;

fragment
NameStartChar
            :   [:a-zA-Z]
            |   '\u2070'..'\u218F' 
            |   '\u2C00'..'\u2FEF' 
            |   '\u3001'..'\uD7FF' 
            |   '\uF900'..'\uFDCF' 
            |   '\uFDF0'..'\uFFFD'
            ;



// ----------------- Handle <? ... ?> ---------------------
mode PROC_INSTR;
PI          :   '?>'                    -> popMode ; // close <?...?>
IGNORE      :   .                       -> more ;
