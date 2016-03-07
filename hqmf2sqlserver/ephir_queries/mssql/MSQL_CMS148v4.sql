--set search_path = results;
create view results.measure_148_0_all 
as WITH var_1 AS
  (SELECT ordinal_1.hqmf_cypress_ep_encounter_performed_patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          ordinal_1.hqmf_cypress_ep_encounter_performed_start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          ordinal_1.hqmf_cypress_ep_encounter_performed_end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          ordinal_1.hqmf_cypress_ep_encounter_performed_audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value,
          ordinal_1.row_number_1 AS row_number_1
   FROM
     (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
             encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
             encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
             encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value,
             row_number() OVER (PARTITION BY encounter_performed_1.patient_id
                                ORDER BY coalesce(encounter_performed_1.start_dt, encounter_performed_1.end_dt) DESC) AS row_number_1
      FROM hqmf_test.encounter_performed AS encounter_performed_1
      JOIN
      valuesets.code_lists AS code_lists_2 ON code_lists_2.code = encounter_performed_1.code
      AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.103.12.1012'
      WHERE (CAST(encounter_performed_1.negation AS BIT) IS NULL
             OR CAST(encounter_performed_1.negation AS BIT) = 0)
        AND encounter_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
        AND encounter_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS ordinal_1
   WHERE ordinal_1.row_number_1 = 1)
SELECT patient_base.base_patient_id,
       patient_base.hqmf_cypress_ep_encounter_performed_audit_key_value,
       patient_base.hqmf_cypress_ep_encounter_performed_start_dt,
       patient_base.hqmf_cypress_ep_encounter_performed_end_dt,

  (SELECT CASE WHEN EXISTS
     (SELECT dc_16.hqmf_cypress_ep_laboratory_test_performed_patient_id,
             dc_16.hqmf_cypress_ep_laboratory_test_performed_start_dt,
             dc_16.hqmf_cypress_ep_laboratory_test_performed_end_dt,
             dc_16.hqmf_cypress_ep_laboratory_test_performed_audit_key_value
      FROM
        (SELECT laboratory_test_performed_1.patient_id AS hqmf_cypress_ep_laboratory_test_performed_patient_id,
                laboratory_test_performed_1.start_dt AS hqmf_cypress_ep_laboratory_test_performed_start_dt,
                laboratory_test_performed_1.end_dt AS hqmf_cypress_ep_laboratory_test_performed_end_dt,
                laboratory_test_performed_1.audit_key_value AS hqmf_cypress_ep_laboratory_test_performed_audit_key_value
         FROM hqmf_test.laboratory_test_performed AS laboratory_test_performed_1
         JOIN
         valuesets.code_lists AS code_lists_1 ON code_lists_1.code = laboratory_test_performed_1.code
         AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.198.12.1013'
         WHERE laboratory_test_performed_1.patient_id = patient_base.base_patient_id
           AND (CAST(laboratory_test_performed_1.negation AS BIT) IS NULL
                OR CAST(laboratory_test_performed_1.negation AS BIT) = 0)
           AND laboratory_test_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND laboratory_test_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
           AND laboratory_test_performed_1.value IS NOT NULL) AS dc_16) 
		   THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_1) AS numerator,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_17.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_17.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_17.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_17.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 5) AS dc_17))
   AND (EXISTS
          (SELECT dc_18.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                  dc_18.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                  dc_18.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                  dc_18.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) < 17) AS dc_18))
   AND (EXISTS
          (SELECT dc_19.hqmf_cypress_ep_encounter_performed_patient_id,
                  dc_19.hqmf_cypress_ep_encounter_performed_start_dt,
                  dc_19.hqmf_cypress_ep_encounter_performed_end_dt,
                  dc_19.hqmf_cypress_ep_encounter_performed_audit_key_value
           FROM
             (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                     encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                     encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                     encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
              FROM var_1,
                   hqmf_test.encounter_performed AS encounter_performed_1
              JOIN
              valuesets.code_lists AS code_lists_3 ON code_lists_3.code = encounter_performed_1.code
              AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.103.12.1012'
              WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                     OR CAST(encounter_performed_1.negation AS BIT) = 0)
                AND encounter_performed_1.start_dt < var_1.hqmf_cypress_ep_encounter_performed_start_dt
                AND results.month_delta(encounter_performed_1.start_dt, var_1.hqmf_cypress_ep_encounter_performed_start_dt) >= 12) AS dc_19))
   AND (EXISTS
          (SELECT dc_20.hqmf_cypress_ep_diagnosis_active_patient_id,
                  dc_20.hqmf_cypress_ep_diagnosis_active_start_dt,
                  dc_20.hqmf_cypress_ep_diagnosis_active_end_dt,
                  dc_20.hqmf_cypress_ep_diagnosis_active_audit_key_value
           FROM
             (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                     diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                     diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                     diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
              FROM var_1,
                   hqmf_test.diagnosis_active AS diagnosis_active_1
              JOIN
              valuesets.code_lists AS code_lists_4 ON code_lists_4.code = diagnosis_active_1.code
              AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.103.12.1001'
              WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                     OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                AND (diagnosis_active_1.end_dt >= var_1.hqmf_cypress_ep_encounter_performed_start_dt
                     AND var_1.hqmf_cypress_ep_encounter_performed_end_dt >= diagnosis_active_1.start_dt
                     OR diagnosis_active_1.start_dt <= var_1.hqmf_cypress_ep_encounter_performed_end_dt
                     AND diagnosis_active_1.end_dt IS NULL
                     OR var_1.hqmf_cypress_ep_encounter_performed_start_dt <= diagnosis_active_1.end_dt
                     AND var_1.hqmf_cypress_ep_encounter_performed_end_dt IS NULL
                     OR diagnosis_active_1.start_dt IS NULL
                     AND diagnosis_active_1.end_dt IS NULL)) AS dc_20)) 
					 THEN cast( 1 as bit) 
					   ELSE cast(0 as bit)
					   END AS anon_2) AS [initialPopulation]
FROM
  (SELECT base_patients.patient_id AS base_patient_id,
          var_1.hqmf_cypress_ep_encounter_performed_audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value,
          var_1.hqmf_cypress_ep_encounter_performed_start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          var_1.hqmf_cypress_ep_encounter_performed_end_dt AS hqmf_cypress_ep_encounter_performed_end_dt
   FROM hqmf_test.patients AS base_patients
   LEFT OUTER JOIN var_1 ON var_1.hqmf_cypress_ep_encounter_performed_patient_id = base_patients.patient_id) AS patient_base;

CREATE TABLE results.measure_148_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_148_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, [initialPopulation] AS effective_denom, CAST(NULL AS BIT) AS effective_denex, [initialPopulation] & numerator AS effective_numer, CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_148_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

