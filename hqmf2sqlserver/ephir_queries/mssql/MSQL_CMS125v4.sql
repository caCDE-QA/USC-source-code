--set search_path = results;
create view results.measure_125_0_all as SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_23.hqmf_cypress_ep_procedure_performed_patient_id,
                     dc_23.hqmf_cypress_ep_procedure_performed_start_dt,
                     dc_23.hqmf_cypress_ep_procedure_performed_end_dt,
                     dc_23.hqmf_cypress_ep_procedure_performed_audit_key_value
              FROM
                (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                        procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                        procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                        procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
                 FROM hqmf_test.procedure_performed AS procedure_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_1 ON code_lists_1.code = procedure_performed_1.code
                 AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.198.12.1005'
                 WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                        OR CAST(procedure_performed_1.negation AS BIT) = 0)
                   AND procedure_performed_1.end_dt < CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_23))
   AND (EXISTS
          (SELECT dc_24.anon_2
           FROM
             (SELECT NULL AS anon_2 HAVING count(*) >= 2
              AND count(*) <= 2) AS dc_24)) 
			  THEN cast( 1 as bit)  
				ELSE cast(0 as bit)
				END AS anon_1) AS [denominatorExclusions],

  (SELECT CASE WHEN EXISTS
     (SELECT dc_25.hqmf_cypress_ep_diagnostic_study_performed_patient_id,
             dc_25.hqmf_cypress_ep_diagnostic_study_performed_start_dt,
             dc_25.hqmf_cypress_ep_diagnostic_study_performed_end_dt,
             dc_25.hqmf_cypress_ep_diagnostic_study_performed_audit_key_value
      FROM
        (SELECT diagnostic_study_performed_1.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
                diagnostic_study_performed_1.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
                diagnostic_study_performed_1.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
                diagnostic_study_performed_1.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_value
         FROM hqmf_test.diagnostic_study_performed AS diagnostic_study_performed_1
         JOIN
         valuesets.code_lists AS code_lists_2 ON code_lists_2.code = diagnostic_study_performed_1.code
         AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.108.12.1018'
         WHERE diagnostic_study_performed_1.patient_id = patient_base.base_patient_id
           AND (CAST(diagnostic_study_performed_1.negation AS BIT) IS NULL
                OR CAST(diagnostic_study_performed_1.negation AS BIT) = 0)
           AND diagnostic_study_performed_1.end_dt < CAST('2015-12-31T00:00:00' AS DATETIME)
           AND results.month_delta(diagnostic_study_performed_1.end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) >= 0
           AND results.month_delta(diagnostic_study_performed_1.end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) < 24) AS dc_25) 
		   THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_3) AS numerator,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_26.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_26.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_26.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_26.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
              FROM
                (SELECT patient_characteristic_birthdate_1.patient_id AS hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                        patient_characteristic_birthdate_1.start_dt AS hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                        patient_characteristic_birthdate_1.end_dt AS hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                        patient_characteristic_birthdate_1.audit_key_value AS hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
                 FROM hqmf_test.patient_characteristic_birthdate AS patient_characteristic_birthdate_1
                 JOIN
                 valuesets.individual_code_map AS individual_code_map_1 ON individual_code_map_1.code = patient_characteristic_birthdate_1.code
                 AND individual_code_map_1.code_system_oid = '2.16.840.1.113883.6.1'
                 AND individual_code_map_1.measure_code = '21112-8'
                 WHERE patient_characteristic_birthdate_1.patient_id = patient_base.base_patient_id
                   AND (CAST(patient_characteristic_birthdate_1.negation AS BIT) IS NULL
                        OR CAST(patient_characteristic_birthdate_1.negation AS BIT) = 0)
                   AND patient_characteristic_birthdate_1.start_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 41) AS dc_26))
   AND (EXISTS
          (SELECT dc_27.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                  dc_27.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                  dc_27.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                  dc_27.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
           FROM
             (SELECT patient_characteristic_birthdate_1.patient_id AS hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     patient_characteristic_birthdate_1.start_dt AS hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     patient_characteristic_birthdate_1.end_dt AS hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     patient_characteristic_birthdate_1.audit_key_value AS hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
              FROM hqmf_test.patient_characteristic_birthdate AS patient_characteristic_birthdate_1
              JOIN
              valuesets.individual_code_map AS individual_code_map_2 ON individual_code_map_2.code = patient_characteristic_birthdate_1.code
              AND individual_code_map_2.code_system_oid = '2.16.840.1.113883.6.1'
              AND individual_code_map_2.measure_code = '21112-8'
              WHERE patient_characteristic_birthdate_1.patient_id = patient_base.base_patient_id
                AND (CAST(patient_characteristic_birthdate_1.negation AS BIT) IS NULL
                     OR CAST(patient_characteristic_birthdate_1.negation AS BIT) = 0)
                AND patient_characteristic_birthdate_1.start_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) < 69) AS dc_27))
   AND (EXISTS
          (SELECT dc_28.hqmf_cypress_ep_patient_characteristic_sex_patient_id,
                  dc_28.hqmf_cypress_ep_patient_characteristic_sex_start_dt,
                  dc_28.hqmf_cypress_ep_patient_characteristic_sex_end_dt,
                  dc_28.hqmf_cypress_ep_patient_characteristic_sex_audit_key_value
           FROM
             (SELECT patient_characteristic_sex_1.patient_id AS hqmf_cypress_ep_patient_characteristic_sex_patient_id,
                     patient_characteristic_sex_1.start_dt AS hqmf_cypress_ep_patient_characteristic_sex_start_dt,
                     patient_characteristic_sex_1.end_dt AS hqmf_cypress_ep_patient_characteristic_sex_end_dt,
                     patient_characteristic_sex_1.audit_key_value AS hqmf_cypress_ep_patient_characteristic_sex_audit_key_value
              FROM hqmf_test.patient_characteristic_sex AS patient_characteristic_sex_1
              JOIN
              valuesets.code_lists AS code_lists_3 ON code_lists_3.code = patient_characteristic_sex_1.code
              AND code_lists_3.code_list_id = '2.16.840.1.113883.3.560.100.2'
              WHERE patient_characteristic_sex_1.patient_id = patient_base.base_patient_id
                AND (CAST(patient_characteristic_sex_1.negation AS BIT) IS NULL
                     OR CAST(patient_characteristic_sex_1.negation AS BIT) = 0)) AS dc_28))
   AND (EXISTS
          (SELECT anon_5.patient_id,
                  anon_5.start_dt,
                  anon_5.end_dt,
                  anon_5.audit_key_value
           FROM
             (SELECT dc_36.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                     dc_36.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                     dc_36.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                     dc_36.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_4 ON code_lists_4.code = encounter_performed_1.code
                 AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_36
              UNION SELECT dc_37.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_37.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_37.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_37.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_5 ON code_lists_5.code = encounter_performed_1.code
                 AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_37
              UNION SELECT dc_38.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_38.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_38.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_38.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_6 ON code_lists_6.code = encounter_performed_1.code
                 AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1025'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_38
              UNION SELECT dc_39.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_39.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_39.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_39.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_7 ON code_lists_7.code = encounter_performed_1.code
                 AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1023'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_39
              UNION SELECT dc_40.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_40.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_40.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_40.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_8 ON code_lists_8.code = encounter_performed_1.code
                 AND code_lists_8.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1016'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_40
              UNION SELECT dc_41.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_41.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_41.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_41.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_9 ON code_lists_9.code = encounter_performed_1.code
                 AND code_lists_9.code_list_id = '2.16.840.1.113883.3.526.3.1240'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_41) AS anon_5)) 
						THEN cast( 1 as bit) --AS anon_3) 
							ELSE cast(0 as bit)
							END AS anon_4) AS [initialPopulation]
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) AS patient_base;

CREATE TABLE results.measure_125_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_125_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, 
[initialPopulation] AS effective_denom, [initialPopulation] & [denominatorExclusions] AS effective_denex, 
[initialPopulation] & ~ ([initialPopulation] & [denominatorExclusions]) & numerator AS effective_numer, CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id 
ORDER BY ([initialPopulation] & [denominatorExclusions]) DESC, ([initialPopulation] & ~ ([initialPopulation] & [denominatorExclusions]) & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_125_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

