/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
lexer grammar HQMFv2JSONLexer;


LCURLY : '{';
RCURLY : '}';
LBRACKET : '[';
RBRACKET : ']';
COMMA : ',';
COLON : ':';
TRUE : 'true';
FALSE : 'false';
NULL : 'null';
QUOTE : '"';

// Strings I've assigned names to, for clarity

C_effectiveTime_low : '"effectiveTime.low"';
C_effectiveTime_high : '"effectiveTime.high"';
C_TEXT : '"#text"';
C_HQMFv2 : '"POQM_HD000001UV02"';
C_HQMF_ROOT : '"2.16.840.1.113883.1.3"';
C_HQMF_TMPL_STATUS : '"2.16.840.1.113883.10.20.28.3.94"';
C_HQMF_TMPL_RESULT : '"2.16.840.1.113883.10.20.28.3.101"';
C_HQMF_TMPL_CUMULATIVE_MEDICAL_DURATION : '"2.16.840.1.113883.10.20.28.3.100"';
C_LOINC : '"2.16.840.1.113883.6.1"';
C_NSVAL_XSI : '"http://www.w3.org/2001/XMLSchema-instance: "http://www.w3.org/2001/XMLSchema-instance"';
C_NSVAL_QDM : '"urn:hhs-qdm:hqmf-r2-extensions:v1"';
C_NSVAL_XMLNS : '"urn:hl7-org:v3"';
C_NS_QDM : '"@xmlns:qdm"';
C_NS_XSI : '"@xmlns:xsi"';
C_NS_XSI_TYPE : '"@xsi:type"';
C_Not_Applicable : '"Not Applicable"';
C_ANY_NONNULL  : '"ANY.NONNULL"';
C_NQF_Number : '"NQF Number"';
C_SNOMED_active : '"55561003"';
C_qdm_delta : '"qdm:delta"';
C_qdm_subsetCode : '"qdm:subsetCode"';
C_qdm_temporalInformation : '"qdm:temporalInformation"';



// Verbatim strings

S_ACT  : '"ACT"';
S_ANY  : '"ANY"';
S_ASSIGNED : '"ASSIGNED"';
S_Active : '"Active"';
S_CD : '"CD"';
S_COMP : '"COMP"';
S_COMPLETED : '"COMPLETED"';
S_CSM : '"CSM"';
S_DENEX : '"DENEX"';
S_DENEXCEP : '"DENEXCEP"';
S_DENOM : '"DENOM"';
S_DRIV : '"DRIV"';
S_DURING : '"DURING"';
S_Denominator : '"Denominator"';
S_ED : '"ED"';
S_ENC : '"ENC"';
S_EVN : '"EVN"';
S_GROUPER : '"GROUPER"';
S_IPOP : '"IPOP"';
S_IVL_PQ : '"IVL_PQ"';
S_LOINC : '"LOINC"';
S_MSRADJ : '"MSRADJ"';
S_MSRAGG : '"MSRAGG"';
S_MSRPOPL : '"MSRPOPL"';
S_MSRPOPLEX : '"MSRPOPLEX"';
S_MSRSCORE : '"MSRSCORE"';
S_MSRTP : '"MSRTP"';
S_MSRTYPE : '"MSRTYPE"';
S_NUMER : '"NUMER"';
S_NUMEX : '"NUMEX"';
S_None : '"None"';
S_OBS : '"OBS"';
S_OCCR : '"OCCR"';
S_ORG : '"ORG"';
S_OTH : '"OTH"';
S_OVERLAP : '"OVERLAP"';
S_PINF : '"PINF"';
S_PIVL_TS : '"PIVL_TS"';
S_PQ : '"PQ"';
S_PRCN : '"PRCN"';
S_PROC : '"PROC"';
S_PROCESS : '"PROCESS"';
S_PROPOR : '"PROPOR"';
S_QDM_AVERAGE : '"QDM_AVERAGE"';
S_QDM_LAST : '"QDM_LAST"';
S_QDM_MAX : '"QDM_MAX"';
S_QDM_MEDIAN : '"QDM_MEDIAN"';
S_QDM_MIN : '"QDM_MIN"';
S_QDM_SUM : '"QDM_SUM"';   // Should really be called QDM_COUNT, not QDM_SUM
S_QualityMeasureDocument : '"QualityMeasureDocument"';
S_RAT : '"RAT"';
S_REF : '"REF"';
S_REFR : '"REFR"';
S_RQO : '"RQO"';
S_SBS : '"SBS"';
S_SDE : '"SDE"';
S_STRAT : '"STRAT"';
S_Stratifiers : '"Stratifiers"';
S_SUM : '"SUM"';
S_TBD : '"TBD"';
S_TRANF : '"TRANF"';
S_actCriteria : '"actCriteria"';
S_activityTime : '"activityTime"';
S_allTrue : '"allTrue"';
S_allFalse : '"allFalse"';
S_atLeastOneTrue : '"atLeastOneTrue"';
S_atLeastOneFalse : '"atLeastOneFalse"';
S_any : '"any"';
S_author : '"author"';
S_availabilityTime : '"availabilityTime"';
S_code : '"code"';
S_component : '"component"';
S_componentOf : '"componentOf"';
S_conjunctionCode : '"conjunctionCode"';
S_content : '"content"';
S_controlVariable : '"controlVariable"';
S_count : '"count"';
S_criteriaReference : '"criteriaReference"';
S_custodian : '"custodian"';
S_dataCriteriaSection : '"dataCriteriaSection"';
S_definition: '"definition"';
S_delta : '"delta"';
S_denominator : '"denominator"';
S_denominatorCriteria : '"denominatorCriteria"';
S_denominatorExceptionCriteria : '"denominatorExceptionCriteria"';
S_denominatorExclusionCriteria : '"denominatorExclusionCriteria"';
S_description : '"description"';
S_displayName : '"displayName"';
S_effectiveTime : '"effectiveTime"';
S_encounterCriteria : '"encounterCriteria"';
S_entry : '"entry"';
S_excerpt : '"excerpt"';
S_expression : '"expression"';
S_false : '"false"';
S_frequency : '"frequency"';
S_grouperCriteria : '"grouperCriteria"';
S_high : '"high"';
S_id : '"id"';
S_initialPopulation : '"initialPopulation"';
S_initialPopulationCriteria : '"initialPopulationCriteria"';
S_interpretationCode : '"interpretationCode"';
S_item : '"item"';
S_languageCode : '"languageCode"';
S_list : '"list"';
S_localVariableName : '"localVariableName"';
S_low : '"low"';
S_measureAttribute : '"measureAttribute"';
S_measurePeriod : '"measurePeriod"';
S_measurePopulationCriteria : '"measurePopulationCriteria"';
S_measurePopulationExclusionCriteria : '"measurePopulationExclusionCriteria"';
S_methodCode : '"methodCode"';
S_min : '"min"';
S_name : '"name"';
S_numerator : '"numerator"';
S_numeratorCriteria : '"numeratorCriteria"';
S_numeratorExclusionCriteria : '"numeratorExclusionCriteria"';
S_observationCriteria : '"observationCriteria"';
S_onlyOneTrue : '"onlyOneTrue"';
S_onlyOneFalse : '"onlyOneFalse"';
S_originalText : '"originalText"';
S_outboundRelationship : '"outboundRelationship"';
S_part : '"part"';
S_participation: '"participation"';
S_pauseQuantity : '"pauseQuantity"';
S_period : '"period"';
S_phase : '"phase"';
S_playingMaterial : '"playingMaterial"';
S_populationCriteriaSection : '"populationCriteriaSection"';
S_precondition : '"precondition"';
S_precisionUnit : '"precisionUnit"';
S_priorityCode : '"priorityCode"';
S_procedureCriteria : '"procedureCriteria"';
S_qualityMeasureSet : '"qualityMeasureSet"';
S_realmCode : '"realmCode"';
S_reasonCode : '"reasonCode"';
S_relatedDocument : '"relatedDocument"';
S_repeatNumber : '"repeatNumber"';
S_representedResponsibleOrganization : '"representedResponsibleOrganization"';
S_responsibleParty : '"responsibleParty"';
S_role : '"role"';
S_sequenceNumber : '"sequenceNumber"';
S_setId : '"setId"';
S_source : '"source"';
S_sourceAttribute : '"sourceAttribute"';
S_statusCode : '"statusCode"';
S_stratifierCriteria : '"stratifierCriteria"';
S_subject: '"subject"';
S_subjectOf : '"subjectOf"';
S_subsetCode : '"subsetCode"';
S_substanceAdministrationCriteria : '"substanceAdministrationCriteria"';
S_supplyCriteria : '"supplyCriteria"';
S_targetAttribute : '"targetAttribute"';
S_targetSiteCode : '"targetSiteCode"';
S_templateId : '"templateId"';
S_temporallyRelatedInformation : '"temporallyRelatedInformation"';
S_text : '"text"';
S_thumbnail : '"thumbnail"';
S_title : '"title"';
S_translation : '"translation"';
S_true : '"true"';
S_typeId : '"typeId"';
S_uncertainty : '"uncertainty"';
S_uncertainRange : '"uncertainRange"';
S_value : '"value"';
S_valueNegationInd : '"valueNegationInd"';
S_verifier : '"verifier"';
S_versionNumber : '"versionNumber"';
S_width : '"width"';
S_xml : '"xml"';

// Verbatim attribute strings

A_actionNegationInd : '"@actionNegationInd"';
A_alignment : '"@alignment"';
A_bound : '"@bound"';
A_charset : '"@charset"';
A_classCode : '"@classCode"';
A_code : '"@code"';
A_codeSystem : '"@codeSystem"';
A_codeSystemName : '"@codeSystemName"';
A_codeSystemVersion : '"@codeSystemVersion"';
A_codingRationale : '"@codingRationale"';
A_compression : '"@compression"';
A_controlInformationRoot : '"@controlInformationRoot"';
A_controlInformationExtension : '"@controlInformationExtension"';
A_determinerCode : '"@determinerCode"';
A_displayable : '"@displayable"';
A_extension : '"@extension"';
A_flavorId : '"@flavorId"';
A_id : '"@id"';
A_integrityCheckAlgorithm : '"@integrityCheckAlgorithm"';
A_isCriterionInd : '"@isCriterionInd"';
A_isFlexible : '"@isFlexible"';
A_highClosed : '"@highClosed"';
A_language : '"@language"';
A_lowClosed : '"@lowClosed"';
A_identifierName : '"@identifierName"';
A_mediaType : '"@mediaType"';
A_moodCode : '"@moodCode"';
A_name : '"@name"';
A_nullFlavor : '"@nullFlavor"';
A_precisionUnit : '"@precisionUnit"';
A_root : '"@root"';
A_scope : '"@scope"';
A_reliability : '"@reliability"';
A_styleCode : '"@styleCode"';
A_typeCode : '"@typeCode"';
A_unit : '"@unit"';
A_updateMode : '"@updateMode"';
A_value : '"@value"';
A_valueSet : '"@valueSet"';
A_valueSetVersion : '"@valueSetVersion"';
A_validTimeLow : '"@validTimeLow"';
A_validTimeHigh : '"@validTimeHigh"';
A_xmlns : '"@xmlns"';
A_xref : '"@xref"';


STRING :  '"' (ESC | ~["\\])* '"' ;

fragment ESC :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;

INTEGER : '-'? INT;

NUMBER
    :   '-'? INT '.' [0-9]+ EXP? // 1.35, 1.35E-9, 0.3, -4.5
    |   '-'? INT EXP             // 1e10 -3e4
    |   '-'? INT                 // -3, 45
    ;
fragment INT :   '0' | [1-9] [0-9]* ; // no leading zeros
fragment EXP :   [Ee] [+\-]? INT ; // \- since - means "range" inside [...]

WS  :   [ \t\n\r]+ -> skip ;

