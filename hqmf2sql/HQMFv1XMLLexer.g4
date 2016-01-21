lexer grammar HQMFv1XMLLexer;

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
S_SUBJECTOF : 'subjectOf' ;
S_COMPONENT : 'component' ;
S_SECTION : 'section' ;
S_ENTRY : 'entry' ;
S_CODE : 'code' ;
S_CODESYSTEM : 'codeSystem' ;
S_DISPLAYNAME : 'displayName' ;
S_TITLE : 'title' ;
S_TEXT : 'text' ;
S_ACT : 'act' ;
S_OUTBOUNDRELATIONSHIP : 'outboundRelationship' ;

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
            |   '-' | '.' | DIGIT 
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
