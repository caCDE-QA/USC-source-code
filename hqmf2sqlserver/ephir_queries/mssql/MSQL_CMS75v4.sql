--set search_path = results;
create view results.measure_75_0_all 
as 
SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN EXISTS
     (SELECT dc_18.hqmf_cypress_ep_diagnosis_active_patient_id,
             dc_18.hqmf_cypress_ep_diagnosis_active_start_dt,
             dc_18.hqmf_cypress_ep_diagnosis_active_end_dt,
             dc_18.hqmf_cypress_ep_diagnosis_active_audit_key_value
      FROM
        (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
         FROM hqmf_test.diagnosis_active AS diagnosis_active_1
         JOIN
         valuesets.code_lists AS code_lists_1 ON code_lists_1.code = diagnosis_active_1.code
         AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.125.12.1004'
         WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
           AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                OR CAST(diagnosis_active_1.negation AS BIT) = 0)
           AND (diagnosis_active_1.end_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                AND CAST('2015-12-31T00:00:00' AS DATETIME) >= diagnosis_active_1.start_dt
                OR diagnosis_active_1.start_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
                AND diagnosis_active_1.end_dt IS NULL
                OR CAST('2015-01-01 00:00:00' AS DATETIME) <= diagnosis_active_1.end_dt
                AND CAST('2015-12-31T00:00:00' AS DATETIME) IS NULL
                OR diagnosis_active_1.start_dt IS NULL
                AND diagnosis_active_1.end_dt IS NULL)) AS dc_18) 
					    THEN cast( 1 as bit)--AS anon_1) 
						ELSE cast( 0 as bit) 
						END AS anon_1) AS numerator,

  (SELECT CASE WHEN ( EXISTS
             (SELECT dc_19.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_19.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_19.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_19.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0) AS dc_19))
   AND (EXISTS
          (SELECT dc_20.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                  dc_20.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                  dc_20.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                  dc_20.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) < 20) AS dc_20))
   AND (EXISTS
          (SELECT anon_3.patient_id,
                  anon_3.start_dt,
                  anon_3.end_dt,
                  anon_3.audit_key_value
           FROM
             (SELECT dc_29.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                     dc_29.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                     dc_29.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                     dc_29.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_2 ON code_lists_2.code = encounter_performed_1.code
                 AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_29
              UNION SELECT dc_30.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_30.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_30.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_30.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_3 ON code_lists_3.code = encounter_performed_1.code
                 AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1024'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_30
              UNION SELECT dc_31.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_31.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_31.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_31.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_4 ON code_lists_4.code = encounter_performed_1.code
                 AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1022'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_31
              UNION SELECT dc_32.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_32.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_32.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_32.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_5 ON code_lists_5.code = encounter_performed_1.code
                 AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1025'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_32
              UNION SELECT dc_33.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_33.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_33.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_33.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_6 ON code_lists_6.code = encounter_performed_1.code
                 AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1023'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_33
              UNION SELECT dc_34.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_34.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_34.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_34.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_7 ON code_lists_7.code = encounter_performed_1.code
                 AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_34
              UNION SELECT dc_35.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_35.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_35.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_35.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_8 ON code_lists_8.code = encounter_performed_1.code
                 AND code_lists_8.code_list_id = '2.16.840.1.113883.3.464.1003.125.12.1003'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_35) AS anon_3)) 
						THEN cast( 1 as bit)--AS anon_1) 
						ELSE cast( 0 as bit) 
						END AS anon_2) AS [initialPopulation]
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) AS patient_base;

CREATE TABLE results.measure_75_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_75_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, [initialPopulation] AS effective_denom, 
CAST(NULL AS BIT) AS effective_denex, [initialPopulation] & numerator AS effective_numer, 
CAST(NULL AS BIT) AS effective_denexcep, 
rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_75_0_all 
WHERE [initialPopulation]=1) anon_1 
WHERE anon_1.rank = 1
;

