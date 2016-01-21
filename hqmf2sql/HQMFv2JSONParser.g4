            /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
parser grammar HQMFv2JSONParser;

options {
    tokenVocab = HQMFv2JSONLexer;
}

hqmf : LCURLY quality_measure_document RCURLY;

quality_measure_document
    : S_QualityMeasureDocument COLON
      LCURLY
      measure_clause (COMMA measure_clause)*
      RCURLY
     ;

measure_clause
    : infrastructure_root_element            #MeasureInfrastructureRoot
    | xml_header_keyword COLON any_string    #MeasureXMLHeader
    | S_id COLON ii_rhs                      #MeasureId
    | S_code COLON cd_rhs                    #MeasureCode
    | S_title COLON st_rhs                  #MeasureTitle
    | S_text COLON ed_rhs                    #MeasureText
    | S_statusCode COLON cs_rhs              #MeasureStatusCode
    | S_effectiveTime COLON ivl_ts_rhs       #MeasureEffectiveTime
    | S_availabilityTime COLON ts_rhs        #MeasureAvailabilityTime
    | S_languageCode COLON cd_rhs            #MeasureLanguageCode
    | S_setId COLON ii_rhs                   #MeasureSetId
    | S_versionNumber COLON st_rhs           #MeasureVersionNumber
    | S_author COLON json_value              #MeasureAuthor
    | S_custodian COLON json_value           #MeasureCustodian
    | S_verifier COLON json_value            #MeasureCustodian
    | S_participation COLON json_value       #MeasureParticipation
    | S_definition COLON json_value          #MeasureDefinition
    | S_relatedDocument COLON json_value     #MeasureRelatedDocument
    | measure_type_clause                    #MeasureTypeClause
    | control_variable_section               #MeasureControlSection
    | measure_attribute_section              #MeasureAttributeSection
    | component_of_section                   #MeasureComponentOfSection
    | components_section                     #MeasureComponentsSection
    ;

components_section
    : S_component COLON LBRACKET
      criteria_section (COMMA criteria_section)*
      RBRACKET
    ;

criteria_section: data_criteria_section | population_criteria_section;

data_criteria_section
    : LCURLY S_dataCriteriaSection COLON
      LCURLY data_criteria_section_entry (COMMA data_criteria_section_entry)* RCURLY
      RCURLY
    ;

data_criteria_section_entry
    : data_criteria_metadata_element
    | S_entry COLON LBRACKET data_criterion (COMMA data_criterion)* RBRACKET
    ;

data_criterion : LCURLY data_criterion_entry (COMMA data_criterion_entry)* RCURLY;

data_criterion_entry
    : data_criterion_metadata_element
    | observation_criterion
    | encounter_criterion
    | grouper_criterion
    | substance_administration_criterion
    | procedure_criterion
    | act_criterion
    | pair
    ;

labelled_data_criterion
    : observation_criterion
    | encounter_criterion
    | substance_administration_criterion
    | grouper_criterion
    | procedure_criterion
    | act_criterion
    ;

data_criterion_metadata_element
    : S_localVariableName COLON LCURLY
      A_value COLON any_string
      RCURLY                                                # DCM_localVariableName
    | A_typeCode COLON S_DRIV                               # DCM_typeCode
    ;

observation_criterion : S_observationCriteria COLON LCURLY
                        observation_criterion_entry (COMMA observation_criterion_entry)*
                        RCURLY
                      ;

observation_criterion_entry
    : A_classCode COLON S_OBS                               # OC_classcode_obs
    | S_templateId COLON list_ii_rhs                        # OC_TemplateId
    | generic_data_criterion_entry                          # OC_generic
    | pair #OC_foo
    ;

encounter_criterion : S_encounterCriteria COLON LCURLY
                      encounter_criterion_entry (COMMA encounter_criterion_entry)*
                      RCURLY
                    ;

encounter_criterion_entry
    : A_classCode COLON S_ENC                               # EC_classcode_enc
    | S_templateId COLON list_ii_rhs                        # EC_TemplateId
    | generic_data_criterion_entry                          # EC_generic
    ;

substance_administration_criterion
    : S_substanceAdministrationCriteria COLON LCURLY
      substance_administration_criterion_entry (COMMA substance_administration_criterion_entry)*
      RCURLY
    ;

substance_administration_criterion_entry
    : A_classCode COLON S_OBS                               # SA_classcode_obs
    | S_templateId COLON list_ii_rhs                        # SA_TemplateId
    | generic_data_criterion_entry                          # SA_generic
    ;

procedure_criterion
    : S_procedureCriteria COLON LCURLY
      procedure_criterion_entry (COMMA procedure_criterion_entry)*
      RCURLY
    ;

procedure_criterion_entry
    : A_classCode COLON S_PROC                              # PRC_classcode_proc
    | S_templateId COLON list_ii_rhs                        # PRC_TemplateId
    | generic_data_criterion_entry                          # PRC_generic
    ;

act_criterion
    : S_actCriteria COLON LCURLY
      act_criterion_entry (COMMA act_criterion_entry)*
      RCURLY
    ;

act_criterion_entry
    : A_classCode COLON S_ACT                              # ACT_classcode_act
    | S_templateId COLON list_ii_rhs                        # ACT_TemplateId
    | generic_data_criterion_entry                          # ACT_generic
    | pair #xxxxx
    ;

grouper_criterion : S_grouperCriteria COLON LCURLY
                    grouper_criterion_entry (COMMA grouper_criterion_entry)*
                    RCURLY
                  ;

grouper_criterion_entry
    : A_classCode COLON S_GROUPER                           # GRP_class
    | S_templateId COLON list_ii_rhs                        # GRP_templateId
    | generic_data_criterion_entry                          # GRP_generic
    ;

generic_data_criterion_entry
    : S_realmCode COLON dset_cs_rhs                         # DC_RealmCode
    | S_typeId COLON ii_rhs                                 # DC_TypeId
    | dc_boolean_keyword COLON boolean_string_value         # DC_boolean
    | dc_string_keyword COLON any_string                    # DC_string
    | dc_cd_keyword COLON cd_rhs                            # DC_cd
    | A_moodCode COLON mood                                 # DC_MoodCode
    | A_classCode COLON any_string                          # DC_classCode
    | S_id COLON ii_rhs                                     # DC_id
    | dc_cs_keyword COLON cs_rhs                            # DC_cs
    | dc_ivl_ts_keyword COLON ivl_ts_rhs                    # DC_ivl_ts
    | S_title COLON LCURLY A_value COLON any_string RCURLY  # DC_title
    | S_text COLON ed_rhs                                   # DC_text
    | dc_ts_keyword COLON ts_rhs                            # DC_ts
    | dc_dset_cd_keyword COLON dset_cd_rhs                  # DC_dset_cd
    | S_repeatNumber COLON ivl_int_rhs                      # DC_repeatNumber
    | S_value COLON value_rhs                               # DC_value
    | S_valueNegationInd COLON bl_rhs                       # DC_valueNegationInd
    | S_participation COLON participation_rhs               # DC_participation
    | S_definition COLON json_value                         # DC_definition
    | S_temporallyRelatedInformation COLON temporally_related_rhs # DC_temporallyRelated
    | S_outboundRelationship COLON outbound_relationship_list    # DC_outboundRelationship
    | S_excerpt COLON excerpt_rhs                           # DC_excerpt
    ;

mood
    : S_EVN
    | S_RQO
    ;

participation_rhs
    : participation_material
    | json_value
    ;

participation_material : LCURLY participation_material_entry (COMMA participation_material_entry)* RCURLY ;

participation_material_entry
    : A_typeCode COLON S_CSM                                # PART_mat_type
    | S_role COLON role_rhs                                 # PART_role
    ;
      
 role_rhs : LCURLY role_entry (COMMA role_entry)* RCURLY ;
 
 role_entry
     : A_classCode COLON any_string                         # role_class
     | S_playingMaterial COLON playing_material_rhs         # role_playing_material
     ;
 
 playing_material_rhs : LCURLY playing_material_entry (COMMA playing_material_entry)* RCURLY;
 
 playing_material_entry
     : A_classCode COLON any_string                         # playing_material_class
     | A_determinerCode COLON any_string                    # playing_material_determiner
     | S_code COLON cd_rhs                                  # playing_material_code
     ;


excerpt_rhs
    : sequence_rhs                                          # EX_sequence
    | recent_rhs                                            # EX_recent
    | count_rhs                                             # EX_count
    ;

sequence_rhs: LCURLY sequence_entry (COMMA sequence_entry)* RCURLY;

sequence_entry
    : S_sequenceNumber COLON LCURLY A_value COLON any_string RCURLY  # SE_sequence
    | labelled_data_criterion                                  # SE_dc
    ;

recent_rhs: LCURLY recent_entry (COMMA recent_entry)* RCURLY;

recent_entry
    : recent_subset_entry                     # RecentSubsetEntry
    | labelled_data_criterion                 # RecentDataCriterion
    ;

recent_subset_entry : subset_keyword COLON recent_cd_rhs;

recent_cd_rhs
    : LCURLY recent_code (COMMA recent_cd_entry)* RCURLY
    | LCURLY recent_cd_entry (COMMA recent_cd_entry)* COMMA recent_code (COMMA recent_cd_entry)* RCURLY
    ;

recent_cd_entry
    : recent_code
    | cd_entry
    ;

recent_code: A_code COLON S_QDM_LAST;

count_rhs: LCURLY count_rhs_entry (COMMA count_rhs_entry)* RCURLY;

count_rhs_entry
    : subset_keyword COLON count_cd_rhs         # COUNT_RHS_subset
    | labelled_data_criterion                                 # COUNT_RHS_data_criterion
    | pair  #count_rhs_argh
    ;

count_cd_rhs
    : LCURLY count_code (COMMA cd_entry)* RCURLY
    | LCURLY cd_entry (COMMA cd_entry)* COMMA count_code (COMMA cd_entry)* RCURLY
    ;

count_code
    : A_code COLON S_SUM
    | A_code COLON S_QDM_SUM
    | json_value
    ;


/*
count_code_rhs
    : cd_rhs
    | data_criterion
    ;
*/

subset_keyword
    : C_qdm_subsetCode
    | S_subsetCode
    ;

outbound_relationship_list
    : LBRACKET outbound_relationship (COMMA outbound_relationship)* RBRACKET
    | outbound_relationship
    ;

outbound_relationship
    : outbound_status
    | outbound_result
    | outbound_specific_occurrence
    | outbound_conjunction
    | outbound_field_value
    | json_value
    ;

outbound_conjunction: LCURLY outbound_conjunction_entry (COMMA outbound_conjunction_entry)* RCURLY;

outbound_conjunction_entry
    : A_typeCode COLON S_COMP                                # out_conj_type
    | S_conjunctionCode COLON cd_rhs                         # out_conj_code
    | S_criteriaReference COLON criteria_reference_rhs       # out_conj_ref
    ;

outbound_status: LCURLY outbound_status_entry (COMMA outbound_status_entry)* RCURLY;

outbound_status_entry
    : A_typeCode COLON S_REFR
    | S_observationCriteria COLON LCURLY
       status_criterion_entry (COMMA status_criterion_entry)*
       RCURLY
    ;

outbound_field_value: LCURLY outbound_field_value_entry (COMMA outbound_field_value_entry)* RCURLY;

outbound_field_value_entry
    : A_typeCode COLON S_REFR
    | S_observationCriteria COLON LCURLY
       field_value_criterion_entry (COMMA field_value_criterion_entry)*
       RCURLY
    ;    


list_ii_result_rhs : LCURLY ii_result_item (COMMA ii_result_item)* RCURLY;

ii_result_item
    : S_item COLON LBRACKET? ii_result_rhs (COMMA ii_rhs)* RBRACKET?
    | S_item COLON LBRACKET?
      ii_rhs (COMMA ii_rhs)* COMMA ii_result_rhs (COMMA ii_rhs)*
      RBRACKET?
    ;

ii_result_rhs
    : LCURLY ii_result_template (COMMA ii_entry)* RCURLY
    | LCURLY ii_entry (COMMA ii_entry)* COMMA ii_result_template (COMMA ii_entry)* RCURLY
    ;

ii_result_template: A_root COLON C_HQMF_TMPL_RESULT;

outbound_specific_occurrence: LCURLY outbound_specific_occurrence_entry (COMMA outbound_specific_occurrence_entry)* RCURLY;

outbound_specific_occurrence_entry
    : A_typeCode COLON S_OCCR                               #SO_type
    | S_criteriaReference COLON criteria_reference_rhs      # SO_ref
    ;

status_criterion_entry
    : S_templateId COLON list_ii_status_rhs                 # SC_status
    | generic_data_criterion_entry                          # SC_generic
    ;      

field_value_criterion_entry
    : S_templateId COLON list_ii_field_value_rhs                  # VC_template
    | generic_data_criterion_entry                          # VC_generic
    ;

list_ii_field_value_rhs : LCURLY ii_field_value_item (COMMA ii_field_value_item)* RCURLY;

ii_field_value_item
    : S_item COLON LBRACKET? ii_field_value_rhs (COMMA ii_rhs)* RBRACKET?
    | S_item COLON LBRACKET?
      ii_rhs (COMMA ii_rhs)* COMMA ii_field_value_rhs (COMMA ii_rhs)*
      RBRACKET?
    ;

ii_field_value_rhs
    : LCURLY ii_field_value_template (COMMA ii_entry)* RCURLY
    | LCURLY ii_entry (COMMA ii_entry)* COMMA ii_field_value_template (COMMA ii_entry)* RCURLY
    ;

ii_field_value_template: A_root COLON field_value_oid;

field_value_oid
    : C_HQMF_TMPL_CUMULATIVE_MEDICAL_DURATION
    ;

outbound_result: LCURLY outbound_result_entry (COMMA outbound_result_entry)* RCURLY;

      
outbound_result_entry
    : A_typeCode COLON S_REFR
    | S_observationCriteria COLON LCURLY
       result_criterion_entry (COMMA result_criterion_entry)*
       RCURLY
    ;

result_criterion_entry
    : generic_data_criterion_entry                          # RC_generic
    | A_classCode COLON any_string                          # RC_classCode
    | S_templateId COLON list_ii_result_rhs                 # RC_template
    ; 

dc_ivl_int_keyword
    : S_repeatNumber
    ;

dc_dset_cd_keyword
    : S_priorityCode
    | S_reasonCode
    | S_interpretationCode
    | S_methodCode
    | S_targetSiteCode
    ;

dc_ts_keyword
    : S_activityTime
    | S_availabilityTime
    ;

dc_ivl_ts_keyword
    : S_effectiveTime
    ;

dc_boolean_keyword
    : A_isCriterionInd
    | A_actionNegationInd
    ;
      
dc_string_keyword
    : A_nullFlavor
    ;

dc_cd_keyword
    : S_code
    | S_languageCode
    ;

dc_cs_keyword
    : S_statusCode
    ;

temporally_related_rhs : LCURLY temporally_related_entry (COMMA temporally_related_entry)* RCURLY ;

temporally_related_entry
    : S_sequenceNumber COLON integer_string_value               # TR_SequenceNumber
    | S_pauseQuantity COLON pq_rhs                              # TR_PauseQuantity
    | S_localVariableName COLON st_rhs                          # TR_LocalVariableName
    | S_subsetCode COLON cs_rhs                                 # TR_SubsetCode    
    | C_qdm_temporalInformation COLON temporal_information_rhs  # TR_TemporalInformation
    | S_criteriaReference COLON criteria_reference_rhs          # TR_CriteriaReference
    | S_observationCriteria COLON observation_criterion         # TR_ObservationCriteria
    | S_encounterCriteria COLON json_object                     # TR_encounterCriteria
    | S_procedureCriteria COLON json_object                     # TR_procedureCriteria
    | S_supplyCriteria COLON json_object                        # TR_supplyCriteria
    | S_grouperCriteria COLON json_object                       # TR_grouperCriteria
    | A_nullFlavor COLON any_string                             # TR_nullFlavor
    | A_typeCode COLON temporal_operator                        # TR_typeCode
    | infrastructure_root_element                               # TR_InfrastructureRootElement
    ;

temporal_operator: any_string;

criteria_reference_rhs : LCURLY criteria_reference_entry (COMMA criteria_reference_entry)* RCURLY;

criteria_reference_entry
    : infrastructure_root_element                               # CritRef_InfrastructureRoot
    | A_classCode COLON any_string                              # CritRefClassCode
    | A_moodCode COLON any_string                               # CritrefMoodCode
    | S_id COLON ii_rhs                                         # CritRef_Id
    | S_participation COLON json_object                         # CritRef_participation
    | S_temporallyRelatedInformation COLON temporally_related_rhs # CritRef_temporallyRelated
    | S_excerpt COLON json_object                               # CritRef_excerpt
    ;

temporal_information_rhs: LCURLY temporal_information_entry (COMMA temporal_information_entry)* RCURLY;

temporal_information_entry
    : ti_who_keyword COLON temporal_information_attribute_rhs    # TI_who
    | C_qdm_delta COLON ivl_pq_rhs                                   # TI_delta
    | A_precisionUnit COLON any_string                           # TI_precisionUnit
    ;

ti_who_keyword
    : S_sourceAttribute
    | S_targetAttribute
    ;

temporal_information_attribute_rhs: LCURLY 
                                    temporal_information_attribute_entry
                                    (COMMA temporal_information_attribute_entry)*
                                    RCURLY
                                  ;

temporal_information_attribute_entry
    : S_id COLON ii_rhs                                          # TIAttr_id
    | A_name COLON any_string                                    # TIAttr_name
    | A_bound COLON ti_bound_keyword                             # TIAttr_bound
    ;

data_criteria_metadata_element
    : data_criteria_metadata_keyword COLON json_value 
    ;

population_criteria_section
    : LCURLY S_populationCriteriaSection COLON
      LCURLY population_criteria_section_rhs (COMMA population_criteria_section_rhs)* RCURLY
      RCURLY
    ;

population_criteria_section_rhs
    : S_id COLON ii_rhs                #PCS_id
    | S_code COLON cd_rhs              #PCS_code
    | S_title COLON st_rhs             #PCS_title
    | population_criteria_metadata_element   #PCS_metadata
    | S_localVariableName COLON st_rhs       #PCS_localVariable
    | S_component COLON LBRACKET wrapped_pop_crit (COMMA wrapped_pop_crit)* RBRACKET #PCS_component
    ;

wrapped_pop_crit : LCURLY wrapped_pop_crit_entry (COMMA wrapped_pop_crit_entry)* RCURLY;

wrapped_pop_crit_entry
    : A_typeCode COLON S_COMP
    | population_criterion
    ;

population_criterion
    : initial_population_criteria
    | numerator_criteria
    | denominator_criteria
    | measure_population_criteria
    | denominator_exception_criteria
    | denominator_exclusion_criteria
    | numerator_exclusion_criteria
    | measure_population_exclusion_criteria
    | stratifier_criteria
    ;

temp_criteria_entry
    : ipp_entry
    | pair
    ;

numerator_criteria: S_numeratorCriteria COLON LCURLY 
                    numerator_entry (COMMA numerator_entry)* RCURLY;

denominator_criteria: S_denominatorCriteria COLON LCURLY 
                    denominator_entry (COMMA denominator_entry)* RCURLY;

measure_population_criteria: S_measurePopulationCriteria COLON LCURLY 
                    measure_population_entry (COMMA measure_population_entry)* RCURLY;

denominator_exception_criteria: S_denominatorExceptionCriteria COLON LCURLY 
                    denominator_exception_entry (COMMA denominator_exception_entry)* RCURLY;

denominator_exclusion_criteria: S_denominatorExclusionCriteria COLON LCURLY 
                    denominator_exclusion_entry (COMMA denominator_exclusion_entry)* RCURLY;

numerator_exclusion_criteria: S_numeratorExclusionCriteria COLON LCURLY 
                    numerator_exclusion_entry (COMMA numerator_exclusion_entry)* RCURLY;

measure_population_exclusion_criteria: S_measurePopulationExclusionCriteria COLON LCURLY 
                   measure_population_exclusion_entry (COMMA measure_population_exclusion_entry)* RCURLY;

stratifier_criteria: S_stratifierCriteria COLON LCURLY 
                    stratifier_entry (COMMA stratifier_entry)* RCURLY;


initial_population_criteria: S_initialPopulationCriteria COLON LCURLY
                             ipp_entry (COMMA ipp_entry)* RCURLY;

numerator_entry: temp_criteria_entry;
denominator_entry: temp_criteria_entry;
measure_population_entry: temp_criteria_entry;
denominator_exception_entry: temp_criteria_entry;
denominator_exclusion_entry: temp_criteria_entry;
numerator_exclusion_entry: temp_criteria_entry;
measure_population_exclusion_entry: temp_criteria_entry;
stratifier_entry: temp_criteria_entry;



ipp_entry
    : generic_population_criteria_entry
;

generic_population_criteria_entry
    : A_typeCode COLON S_COMP                      # pop_typecode_check
    | A_classCode COLON S_OBS                      # pop_classcode_check
    | A_moodCode COLON S_EVN                       # pop_moodcode_check
    | A_nullFlavor COLON any_string                # pop_nullflavor
    | A_isCriterionInd COLON S_true                # pop_isCriterion
    | S_id COLON ii_rhs                            # pop_id
    | S_code COLON cd_rhs                          # pop_code
    | S_precondition COLON precondition_rhs        # pop_precondition
    | S_subject COLON subject_rhs                  # pop_subject
    | S_component COLON component_rhs              # pop_component
    ;

component_rhs: LCURLY component_entry (COMMA component_entry)* RCURLY;

component_entry
    : infrastructure_root_element                  # component_ir
    | S_measureAttribute COLON measure_attribute_rhs  # component_measure_attribute
    | A_nullFlavor COLON any_string                # component_nullflavor
    | A_typeCode COLON any_string                  # component_typeCode
    ;

measure_attribute_rhs: LCURLY measure_attribute_entry (COMMA measure_attribute_entry)* RCURLY;

measure_attribute_entry
    : infrastructure_root_element                  # measure_attribute_ir
    | S_id COLON ii_rhs                            # measure_attribute_id
    | S_code COLON cd_rhs                          # measure_attribute_code
    | S_value COLON measure_attr_value_rhs         # measure_attribute_value
    | A_nullFlavor COLON any_string                # measure_attribute_nullflavor
    | A_classCode COLON S_OBS                      # measure_attribute_classcode
    | A_moodCode COLON S_EVN                       # measure_attribute_moodcode
    ;

measure_attr_value_rhs: LCURLY measure_attr_value_entry (COMMA measure_attr_value_entry)* RCURLY;

measure_attr_value_entry
    : measure_attr_value_media_entry
    | measure_attr_value_code_entry
    ;

measure_attr_value_code_entry: cd_entry;

measure_attr_value_media_entry
    : any_entry                                    # measure_attr_any
    | A_mediaType COLON any_string                 # measure_attr_mediaType
    | A_value COLON any_string                     # measure_attr_value
    | C_NS_XSI_TYPE COLON any_string               # measure_attr_type
    | ii_entry                                     # measure_attr_ii_entry
    ;

subject_rhs: LCURLY subject_entry (COMMA subject_entry)* RCURLY;

subject_entry
    : infrastructure_root_element                  # subject_ir
    | S_criteriaReference COLON criteria_reference_rhs  # subject_criteria_reference
    | A_nullFlavor COLON any_string                # subject_nullflavor
    | A_typeCode COLON any_string                  # subject_typecode
    ;

precondition_rhs
    : LBRACKET single_precondition (COMMA single_precondition)* RBRACKET
    | single_precondition
    ;

single_precondition: LCURLY precondition_entry (COMMA precondition_entry)* RCURLY;

precondition_entry
    : S_conjunctionCode COLON cs_rhs               # prec_conjunction
    | boolean_grouping_keyword COLON boolean_grouping_rhs  # prec_boolean_group
    | S_criteriaReference COLON criteria_reference_rhs  # prec_criteria_reference
    | A_typeCode COLON any_string                  # prec_typecode
    ;

boolean_grouping_keyword
    : S_allTrue
    | S_allFalse
    | S_atLeastOneTrue
    | S_atLeastOneFalse
    | S_onlyOneTrue
    | S_onlyOneFalse
    ;

boolean_grouping_rhs: LCURLY boolean_grouping_entry (COMMA boolean_grouping_entry)* RCURLY;

boolean_grouping_entry
    : infrastructure_root_element                    # boolean_grouping_ir_element
    | S_id COLON ii_rhs                                # boolean_grouping_id
    | S_precondition COLON precondition_rhs          # boolean_grouping_precondition
    ;

population_criteria_metadata_element
    : population_criteria_metadata_keyword COLON json_value;

component_of_section
    : S_componentOf COLON json_value;

measure_attribute_section
    : S_subjectOf COLON LBRACKET
      measure_attribute (COMMA measure_attribute)*
      RBRACKET
    ;

measure_attribute : LCURLY S_measureAttribute COLON measure_attribute_rhs RCURLY;

/*
measure_attribute
    : LCURLY S_measureAttribute COLON
      LCURLY measure_attribute_element (COMMA measure_attribute_element)* RCURLY
      RCURLY
    ;

measure_attribute_element
    : measure_attribute_code
    | measure_attribute_value
    ;

measure_attribute_code
    : S_code COLON LCURLY 
      measure_attribute_code_element (COMMA measure_attribute_code_element)*
      RCURLY
    | any_string COLON json_value

    ;

measure_attribute_code_element
    : S_originalText COLON
      LCURLY measure_attribute_text_element (COMMA measure_attribute_text_element)* RCURLY
    | measure_attribute_metadata_keyword COLON json_value
    ;

measure_attribute_value
    : S_value COLON LCURLY 
      measure_attribute_value_element (COMMA measure_attribute_value_element)*
      RCURLY
    ;

measure_attribute_value_element
    : measure_attribute_text_element
    | measure_attribute_metadata_keyword COLON json_value
    | any_string COLON json_value
    ;

measure_attribute_text_element
    : measure_attribute_text_keyword COLON any_string
    ;

*/

control_variable_section
    : S_controlVariable COLON LCURLY
      control_variable
      RCURLY
    ; 


control_variable
    : measure_period
    ;


measure_period
    : S_measurePeriod COLON LCURLY
      measure_period_element (COMMA measure_period_element)*                    
      RCURLY                                    
    ;

measure_period_element
    : S_value COLON time_value                   #MeasurePeriodTimeValue
    | infrastructure_root_element                #MeasurePeriodRootElement
    | S_id COLON ii_rhs                          #MeasurePeriodIiRhs
    | S_code COLON cd_rhs                        #MeasurePeriodCdRhs
    ;

time_value
    : LCURLY
      time_element (COMMA time_element)*
      RCURLY
    ;

time_element : pivl_ts_element
             | C_NS_XSI_TYPE COLON S_PIVL_TS
             ;

pivl_ts_element
    : S_phase COLON ivl_ts_rhs                    #PivlTsPhase
    | S_period COLON pq_rhs                       #PivlTsPeriod
    | S_frequency COLON rto_rhs                   #PivlTsFrequency
    | S_count COLON any_string                    #PivlTsCount
    | A_alignment COLON any_string                #PivlTsAlignment
    | A_isFlexible COLON boolean_string_value     #PivlTsIsFlexible
    ;

ivl_pq_rhs : LCURLY ivl_pq_element (COMMA ivl_pq_element)* RCURLY;

ivl_pq_element
    : S_originalText COLON ed_rhs                 # IvlPqOriginalText
    | ivl_pq_pq_keyword COLON pq_rhs                          # IvlPqPq
    | S_width COLON qty_rhs                       # IvlPqWidth
    | ivl_pq_boolean_keyword COLON boolean_string_value      # IvlPqBoolean
    ;

ivl_pq_pq_keyword
    : S_low
    | S_high
    | S_ANY
    ;

ivl_pq_boolean_keyword
    : A_lowClosed
    | A_highClosed
    ;

rto_rhs: LCURLY rto_entry (COMMA rto_entry)* RCURLY;
rto_entry
    : qty_entry
    | rto_qty_keyword COLON qty_rhs
    ;

pq_rhs: LCURLY pq_entry (COMMA pq_entry)* RCURLY;
pq_entry
    : qty_entry
    | S_translation COLON pqr_rhs
    | A_codingRationale COLON any_string
    ;

pqr_rhs: LCURLY pqr_entry (COMMA pqr_entry)* RCURLY;
pqr_entry
    : cd_entry
    | A_value COLON any_string
    ;

/*

infrastructure_root_attribute
    : A_nullFlavor COLON any_string                                   #IrNullFlavor
    | A_classCode COLON any_string                                    #IrClassCode
    | A_moodCode COLON any_string                                     #IrMoodCode
    | A_actionNegationInd COLON boolean_string_value                  #IrActionNegationInd
    | A_isCriterionInd COLON boolean_string_value                     #IrIsCriterionInd
    ;
*/

infrastructure_root_element
    : S_realmCode COLON dset_cs_rhs                                   #IrRealmCode
    | S_typeId COLON ii_rhs                                           #IrTypeId
    | S_templateId COLON list_ii_rhs                                  #IrTemplateId
        ;

value_rhs
    : value_set_rhs                                                   #ValueSet
    | value_code_rhs                                                  #ValueCode
    | value_any_non_null_rhs                                          #ValueAnyNonNull
    | value_ivl_pq_rhs                                                #ValueIvlPQ
    | json_value                                                      #ValueUnknownType
    ;

value_any_non_null_rhs : LCURLY value_any_non_null_entry (COMMA value_any_non_null_entry)* RCURLY;

value_any_non_null_entry
    : A_flavorId COLON C_ANY_NONNULL
    | C_NS_XSI_TYPE COLON S_ANY
    ;

value_code_rhs
    : LCURLY value_code_type (COMMA cd_entry)* RCURLY
    | LCURLY cd_entry (COMMA cd_entry)* COMMA value_code_type (COMMA cd_entry)* RCURLY
    ;

value_code_type: C_NS_XSI_TYPE COLON S_CD;

value_ivl_pq_rhs
    : LCURLY value_ivl_pq_type (COMMA ivl_pq_element)* RCURLY
    | LCURLY ivl_pq_element (COMMA ivl_pq_element)* COMMA value_ivl_pq_type (COMMA ivl_pq_element)* RCURLY
    ;

value_ivl_pq_type: C_NS_XSI_TYPE COLON S_IVL_PQ;


value_set_rhs: LCURLY value_set_entry (COMMA value_set_entry)* RCURLY;

value_set_entry
    : A_valueSet COLON any_string                                      #VS_valueSet
    | C_NS_XSI_TYPE COLON S_CD                                         #VS_confirmation
    | S_displayName COLON st_rhs                                       #VS_displayName
    ;

bl_rhs : LCURLY bl_entry (COMMA bl_entry)* RCURLY;

bl_entry
    : A_nullFlavor COLON any_string
    | A_flavorId COLON any_string
    | A_updateMode COLON any_string
    | hxit_entry
    ;

any_rhs: LCURLY any_entry (COMMA any_entry)* RCURLY;

any_entry
    : hxit_entry                               #AnyHxit
    | qdm_any_attribute COLON any_string       #AnyAny
    ;

qdm_any_attribute
    : A_nullFlavor
    | A_flavorId
    | A_updateMode
    ;

hxit_entry
    : hxit_attribute COLON any_string
    ;

hxit_attribute
    : A_validTimeLow
    | A_validTimeHigh
    | A_controlInformationRoot
    | A_controlInformationExtension
    ;


ivl_ts_rhs : LCURLY ivl_ts_entry (COMMA ivl_ts_entry)* RCURLY;

ivl_ts_entry
    : S_originalText COLON ed_rhs                            #IvlTsOriginalText
    | ivl_ts_ts_keyword COLON ts_rhs                         #IvlTsTs
    | ivl_ts_qty_keyword COLON qty_rhs                       #IvlTsQty
    | ivl_ts_boolean_keyword COLON boolean_string_value      #IvlTsBoolean
    ;

ivl_qty_entry : S_originalText COLON ed_rhs                         #IvlQtyOriginalText
              | ivl_qty_qty_keyword COLON qty_rhs                   #IvlQtyQty
              | ivl_qty_boolean_keyword COLON boolean_string_value  #IvlQtyBoolean
              ;

ts_rhs : LCURLY ts_entry (COMMA ts_entry)* RCURLY;

ts_entry
    : qty_entry                         #TSQty
    | A_value COLON any_string          #TSValue
    ;

qty_rhs : LCURLY qty_entry (COMMA qty_entry)* RCURLY;

qty_entry : A_value COLON any_string                    #QtyValue
         | S_expression COLON ed_rhs                    #QtyExpression
         | S_originalText COLON ed_rhs                  #QtyOriginalText
         | S_uncertainty COLON qty_rhs                  #QtyUncertainty
         | S_uncertainRange COLON ivl_qty_rhs           #QtyUncertainRange
         | A_unit COLON any_string                      #QtyUnit
         | C_NS_XSI_TYPE COLON any_string               #QtyType
         | any_entry                                    #QtyAny
          ;

ivl_qty_rhs : LCURLY ivl_qty_entry (COMMA ivl_qty_entry)* RCURLY;

ivl_int_rhs : LCURLY ivl_int_entry (COMMA ivl_int_entry)* RCURLY;

ivl_int_entry
    : S_originalText COLON ed_rhs                       #IvlIntOriginalText
    | S_low COLON qty_rhs                  #IvlIntLow
    | S_high COLON qty_rhs                 #IvlIntHigh
    | S_width COLON qty_rhs                             #IvlIntWidth
    | S_any COLON qty_rhs                  #IvlIntAny
    | A_lowClosed COLON boolean_string_value            #IvlIntLowClosed
    | A_highClosed COLON boolean_string_value           #IvlIntHighClosed
    ;

// in theory, a CS object can have any additional content
dset_cs_rhs : LCURLY dset_cs_item (COMMA dset_cs_item)* RCURLY;
dset_cs_item : S_item COLON cs_rhs;
cs_rhs : LCURLY cs_entry (COMMA cs_entry)* RCURLY;
cs_entry : cs_keyword COLON any_string;

// in theory, a LIST_II object can have any additional content.
list_ii_rhs : LCURLY ii_item (COMMA ii_item)* RCURLY;
ii_item : S_item COLON LBRACKET? ii_rhs (COMMA ii_rhs)* RBRACKET? ;

list_ii_status_rhs : LCURLY ii_status_item (COMMA ii_status_item)* RCURLY;

ii_status_item
    : S_item COLON LBRACKET? ii_status_rhs (COMMA ii_rhs)* RBRACKET?
    | S_item COLON LBRACKET?
      ii_rhs (COMMA ii_rhs)* COMMA ii_status_rhs (COMMA ii_rhs)*
      RBRACKET?
    ;

ii_status_rhs
    : LCURLY ii_status_template (COMMA ii_entry)* RCURLY
    | LCURLY ii_entry (COMMA ii_entry)* COMMA ii_status_template (COMMA ii_entry)* RCURLY
    ;

ii_status_template: A_root COLON C_HQMF_TMPL_STATUS;
      
ii_rhs : LCURLY ii_entry (COMMA ii_entry)* RCURLY;
ii_entry : ii_keyword COLON any_string;

dset_cd_rhs : LCURLY dset_cd_item (COMMA dset_cd_item)* RCURLY;
dset_cd_item : S_item COLON cd_rhs;

cd_rhs : LCURLY cd_entry (COMMA cd_entry)* RCURLY;
cd_entry : cd_simple_keyword COLON any_string             #CdKeywordEntry
         | S_displayName COLON st_rhs                     #CdDisplayName
         | S_translation COLON st_rhs                     #CdTranslation
         | S_originalText COLON ed_rhs                    #CdOriginalText
         ;

xreference_rhs: LCURLY A_xref COLON any_string RCURLY;

st_rhs : LCURLY st_entry (COMMA st_entry)* RCURLY;
st_entry : S_translation COLON st_rhs                      #StTranslation
         | A_value COLON any_string                        #StValue
         | A_language COLON any_string                     #StLanguage
         ;

sc_rhs : LCURLY sc_entry (COMMA sc_entry)* RCURLY;
sc_entry : st_entry                                        #ScSt
         | S_code COLON cd_rhs                             #ScCode
         ;

// ED can contain many media types. We'll only support simple values
ed_rhs : LCURLY ed_entry (COMMA ed_entry)* RCURLY;
ed_entry : ed_simple_keyword COLON any_string               #EdSimpleKeywordEntry
         | S_thumbnail COLON ed_rhs                         #EdThumbnmailEntry
         | S_translation COLON ed_rhs                       #EdTranslationEntry
         ;


measure_type_clause
    : S_typeId COLON
      LCURLY
      measure_type_element (COMMA measure_type_element)*
      RCURLY
    ;

measure_type_element
    : A_extension COLON C_HQMFv2
    | A_root COLON C_HQMF_ROOT
    ;


// JSON object without enclosing {}
stripped_json_object : pair (COMMA pair)*;

// JSON object (possibly empty)
json_object: LCURLY stripped_json_object? RCURLY;

pair:   any_string COLON json_value ;


json_value
    :   simple_value
    |   json_object  // recursion
    |   array   // recursion
    ;

array
    :   LBRACKET json_value (COMMA json_value)* RBRACKET
    |   LBRACKET RBRACKET // empty array
    ;

simple_value
    :   any_string
    |   NUMBER
    ;

any_string: STRING
          | any_keyword
          ;

keyword 
    : boolean_value
    ;

boolean_value
    : TRUE
    | FALSE
    | NULL
    ;

boolean_string_value
    : S_true
    | S_false
    ;

integer_string_value : QUOTE INTEGER QUOTE;

phase_closed_keyword
    : A_highClosed
    | A_lowClosed
    ;

phase_highlow
    : S_high
    | S_low
    ;

phase_highlow_keyword
    : A_value
    ;

phase_width_keyword
    : A_unit
    | A_value
    | C_NS_XSI_TYPE
    ;

period_keyword
    : A_unit
    | A_value
    ;

/*
measure_metadata_keyword
    : A_xmlns
    | C_NS_QDM
    | C_NS_XSI
    | S_title
    | S_text
    | S_statusCode
    | S_id
    | S_code
    | S_setId
    | S_versionNumber
    | S_author
    | S_custodian
    | S_verifier
    | S_templateId
    | A_root
    | S_effectiveTime
    | S_availabilityTime
    ;
*/

measure_attribute_text_keyword
    : A_nullFlavor
    | A_value
    | A_mediaType
    | C_NS_XSI_TYPE
    ;

measure_attribute_metadata_keyword
    : A_nullFlavor
    ;

data_criteria_metadata_keyword
    : criteria_metadata_keyword
    ;

population_criteria_metadata_keyword
    : criteria_metadata_keyword
    ;


criteria_metadata_keyword
    : S_templateId
    | S_code
    | S_title
    | S_text
    | S_id
    ;

    
infrastructure_root_keyword
    : S_realmCode
    | S_typeId
    | S_templateId
    ;

ii_keyword
    : A_root
    | A_extension
    | ii_misc_keyword
    ;

ii_misc_keyword
    : A_identifierName
    | A_displayable
    | A_scope
    | A_reliability
    ;

ed_simple_keyword
    : S_description
    | A_value
    | A_mediaType
    | A_charset
    | A_language
    | A_compression
    | A_integrityCheckAlgorithm
    ;

cs_keyword
    : A_nullFlavor
    | A_code
    ;

cd_simple_keyword
    : S_originalText
    | S_source
    | A_code
    | A_codeSystem
    | A_codeSystemName
    | A_codeSystemVersion
    | A_valueSet
    | A_valueSetVersion
    | A_codingRationale
    | A_id
    | A_nullFlavor
    ;

ivl_ts_boolean_keyword : ivl_qty_boolean_keyword;

ti_bound_keyword
    : C_effectiveTime_high
    | C_effectiveTime_low
    ;

ivl_ts_ts_keyword
    : S_low
    | S_high
    | S_any
    ;

subset_type_keyword
    : S_QDM_AVERAGE
    | S_QDM_LAST
    | S_QDM_MAX
    | S_QDM_MEDIAN
    | S_QDM_MIN
    | S_QDM_SUM
    | S_sequenceNumber
    ;

ivl_ts_qty_keyword
    : S_width
    ;

ivl_qty_qty_keyword
    : S_low
    | S_high
    | S_width
    | S_any
    ;

ivl_qty_boolean_keyword
    : A_lowClosed
    | A_highClosed
    ;

xml_header_keyword
    : A_xmlns
    | C_NS_XSI
    | C_NS_XSI_TYPE
    | C_NS_QDM
    ;

rto_qty_keyword
    : S_numerator
    | S_denominator
    ;

   
any_keyword : keyword
        | ( A_actionNegationInd
        | A_alignment
        | A_bound
        | A_charset
        | A_classCode
        | A_code
        | A_codeSystem
        | A_codeSystemName
        | A_codeSystemVersion
        | A_codingRationale
        | A_compression
        | A_controlInformationExtension
        | A_controlInformationRoot
        | A_determinerCode
        | A_displayable
        | A_extension
        | A_flavorId
        | A_highClosed
        | A_id
        | A_identifierName
        | A_integrityCheckAlgorithm
        | A_isCriterionInd
        | A_isFlexible
        | A_language
        | A_lowClosed
        | A_mediaType
        | A_moodCode
        | A_name
        | A_nullFlavor
        | A_precisionUnit
        | A_reliability
        | A_root
        | A_scope
        | A_styleCode
        | A_typeCode
        | A_unit
        | A_updateMode
        | A_validTimeHigh
        | A_validTimeLow
        | A_value
        | A_valueSet
        | A_valueSetVersion
        | A_xmlns
        | A_xref
        | C_ANY_NONNULL
        | C_HQMF_ROOT
        | C_HQMF_TMPL_CUMULATIVE_MEDICAL_DURATION
        | C_HQMF_TMPL_RESULT
     /*   | C_HQMF_TMPL_STATUS */
        | C_HQMFv2
	| C_LOINC
        | C_NQF_Number
        | C_NSVAL_QDM
        | C_NSVAL_XMLNS
        | C_NSVAL_XSI
        | C_NS_QDM
        | C_NS_XSI
        | C_NS_XSI_TYPE
        | C_Not_Applicable
        | C_SNOMED_active
        | C_TEXT
        | C_effectiveTime_high
        | C_effectiveTime_low
        | C_qdm_delta
        | C_qdm_subsetCode
        | C_qdm_temporalInformation
        | S_ACT
        | S_ANY
        | S_ASSIGNED
        | S_Active
        | S_CD
        | S_COMP
        | S_COMPLETED
        | S_CSM
        | S_DENEX
        | S_DENEXCEP
        | S_DENOM
        | S_DRIV
        | S_DURING
        | S_Denominator
        | S_ED
        | S_ENC
        | S_EVN
        | S_GROUPER
        | S_IPOP
        | S_IVL_PQ
        | S_LOINC
        | S_MSRADJ
        | S_MSRAGG
        | S_MSRPOPL
        | S_MSRPOPLEX
        | S_MSRSCORE
        | S_MSRTP
        | S_MSRTYPE
        | S_NUMER
        | S_NUMEX
        | S_None
        | S_OBS
        | S_OCCR
        | S_ORG
        | S_OTH
        | S_OVERLAP
        | S_PINF
        | S_PIVL_TS
        | S_PQ
        | S_PRCN
        | S_PROC
        | S_PROCESS
        | S_PROPOR
        | S_QDM_AVERAGE
        | S_QDM_LAST
        | S_QDM_MAX
        | S_QDM_MEDIAN
        | S_QDM_MIN
        | S_QDM_SUM
        | S_QualityMeasureDocument
        | S_RAT
        | S_REF
        | S_REFR
        | S_RQO
        | S_SBS
        | S_SDE
        | S_STRAT
        | S_SUM
        | S_Stratifiers
        | S_TBD
        | S_TRANF
        | S_actCriteria
        | S_activityTime
        | S_allTrue
        | S_allFalse
        | S_atLeastOneTrue
        | S_atLeastOneFalse
        | S_any
        | S_author
        | S_availabilityTime
        | S_code
        | S_component
        | S_componentOf
        | S_content
        | S_controlVariable
        | S_count
        | S_criteriaReference
        | S_custodian
        | S_dataCriteriaSection
        | S_definition
        | S_delta
        | S_denominator
        | S_denominatorCriteria
        | S_description
        | S_displayName
        | S_effectiveTime
        | S_encounterCriteria
        | S_entry
        | S_excerpt
        | S_expression
        | S_false
        | S_frequency
        | S_grouperCriteria
        | S_high
        | S_id
        | S_initialPopulation
        | S_initialPopulationCriteria
        | S_interpretationCode
        | S_item
        | S_languageCode
        | S_list
        | S_localVariableName
        | S_low
        | S_measureAttribute
        | S_measurePeriod
        | S_methodCode
        | S_min
        | S_name
        | S_numerator
        | S_numeratorCriteria
        | S_observationCriteria
        | S_onlyOneTrue
        | S_onlyOneFalse
        | S_originalText
        | S_outboundRelationship
        | S_part
        | S_participation
        | S_pauseQuantity
        | S_period
        | S_phase
        | S_playingMaterial
        | S_populationCriteriaSection
        | S_precisionUnit
        | S_precondition
        | S_priorityCode
        | S_procedureCriteria
        | S_qualityMeasureSet
        | S_realmCode
        | S_reasonCode
        | S_relatedDocument
        | S_repeatNumber
        | S_representedResponsibleOrganization
        | S_responsibleParty
        | S_role
        | S_sequenceNumber
        | S_setId
        | S_source
        | S_sourceAttribute
        | S_statusCode
        | S_stratifierCriteria
        | S_subject
        | S_subjectOf
        | S_subsetCode
        | S_substanceAdministrationCriteria
        | S_supplyCriteria
        | S_targetAttribute
        | S_targetSiteCode
        | S_templateId
        | S_temporallyRelatedInformation
        | S_text
        | S_thumbnail
        | S_title
        | S_translation
        | S_true
        | S_typeId
        | S_uncertainRange
        | S_uncertainty
        | S_value
        | S_valueNegationInd
        | S_verifier
        | S_versionNumber
        | S_width
        | S_xml
          )
;