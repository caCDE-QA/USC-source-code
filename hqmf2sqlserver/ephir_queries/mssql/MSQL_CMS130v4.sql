--set search_path = results;
create view results.measure_130_0_all as SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN EXISTS
     (SELECT anon_2.patient_id,
             anon_2.start_dt,
             anon_2.end_dt,
             anon_2.audit_key_value
      FROM
        (SELECT dc_32.hqmf_cypress_ep_diagnosis_resolved_patient_id AS patient_id,
                dc_32.hqmf_cypress_ep_diagnosis_resolved_start_dt AS start_dt,
                dc_32.hqmf_cypress_ep_diagnosis_resolved_end_dt AS end_dt,
                dc_32.hqmf_cypress_ep_diagnosis_resolved_audit_key_value AS audit_key_value
         FROM
           (SELECT diagnosis_resolved_1.patient_id AS hqmf_cypress_ep_diagnosis_resolved_patient_id,
                   diagnosis_resolved_1.start_dt AS hqmf_cypress_ep_diagnosis_resolved_start_dt,
                   diagnosis_resolved_1.end_dt AS hqmf_cypress_ep_diagnosis_resolved_end_dt,
                   diagnosis_resolved_1.audit_key_value AS hqmf_cypress_ep_diagnosis_resolved_audit_key_value
            FROM hqmf_test.diagnosis_resolved AS diagnosis_resolved_1
            JOIN
            valuesets.code_lists AS code_lists_1 ON code_lists_1.code = diagnosis_resolved_1.code
            AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.108.12.1001'
            WHERE diagnosis_resolved_1.patient_id = patient_base.base_patient_id
              AND (CAST(diagnosis_resolved_1.negation AS BIT) IS NULL
                   OR CAST(diagnosis_resolved_1.negation AS BIT) = 0)) AS dc_32
         UNION SELECT dc_33.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                      dc_33.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                      dc_33.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                      dc_33.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
         FROM
           (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                   diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                   diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                   diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
            FROM hqmf_test.diagnosis_active AS diagnosis_active_1
            JOIN
            valuesets.code_lists AS code_lists_2 ON code_lists_2.code = diagnosis_active_1.code
            AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.108.12.1001'
            WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
              AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                   OR CAST(diagnosis_active_1.negation AS BIT) = 0)) AS dc_33
         UNION SELECT dc_34.hqmf_cypress_ep_diagnosis_inactive_patient_id AS patient_id,
                      dc_34.hqmf_cypress_ep_diagnosis_inactive_start_dt AS start_dt,
                      dc_34.hqmf_cypress_ep_diagnosis_inactive_end_dt AS end_dt,
                      dc_34.hqmf_cypress_ep_diagnosis_inactive_audit_key_value AS audit_key_value
         FROM
           (SELECT diagnosis_inactive_1.patient_id AS hqmf_cypress_ep_diagnosis_inactive_patient_id,
                   diagnosis_inactive_1.start_dt AS hqmf_cypress_ep_diagnosis_inactive_start_dt,
                   diagnosis_inactive_1.end_dt AS hqmf_cypress_ep_diagnosis_inactive_end_dt,
                   diagnosis_inactive_1.audit_key_value AS hqmf_cypress_ep_diagnosis_inactive_audit_key_value
            FROM hqmf_test.diagnosis_inactive AS diagnosis_inactive_1
            JOIN
            valuesets.code_lists AS code_lists_3 ON code_lists_3.code = diagnosis_inactive_1.code
            AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.108.12.1001'
            WHERE diagnosis_inactive_1.patient_id = patient_base.base_patient_id
              AND (CAST(diagnosis_inactive_1.negation AS BIT) IS NULL
                   OR CAST(diagnosis_inactive_1.negation AS BIT) = 0)) AS dc_34
         UNION SELECT dc_35.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_35.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_35.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_35.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_4 ON code_lists_4.code = procedure_performed_1.code
            AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.198.12.1019'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_35) AS anon_2) 
				   THEN cast( 1 as bit) --AS anon_3) 
					ELSE cast(0 as bit)
					END AS anon_1) AS [denominatorExclusions],

  (SELECT CASE WHEN EXISTS
     (SELECT anon_4.patient_id,
             anon_4.start_dt,
             anon_4.end_dt,
             anon_4.audit_key_value
      FROM
        (SELECT dc_40.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                dc_40.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                dc_40.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                dc_40.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_5 ON code_lists_5.code = procedure_performed_1.code
            AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.108.12.1020'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)
              AND procedure_performed_1.end_dt < CAST('2015-12-31T00:00:00' AS DATETIME)
              AND results.year_delta(procedure_performed_1.end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) >= 0
              AND results.year_delta(procedure_performed_1.end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) <= 9) AS dc_40
         WHERE dc_40.hqmf_cypress_ep_procedure_performed_end_dt < CAST('2015-12-31T00:00:00' AS DATETIME)
           AND results.year_delta(dc_40.hqmf_cypress_ep_procedure_performed_end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) >= 0
           AND results.year_delta(dc_40.hqmf_cypress_ep_procedure_performed_end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) <= 9
         UNION SELECT dc_41.hqmf_cypress_ep_laboratory_test_performed_patient_id AS patient_id,
                      dc_41.hqmf_cypress_ep_laboratory_test_performed_start_dt AS start_dt,
                      dc_41.hqmf_cypress_ep_laboratory_test_performed_end_dt AS end_dt,
                      dc_41.hqmf_cypress_ep_laboratory_test_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT laboratory_test_performed_1.patient_id AS hqmf_cypress_ep_laboratory_test_performed_patient_id,
                   laboratory_test_performed_1.start_dt AS hqmf_cypress_ep_laboratory_test_performed_start_dt,
                   laboratory_test_performed_1.end_dt AS hqmf_cypress_ep_laboratory_test_performed_end_dt,
                   laboratory_test_performed_1.audit_key_value AS hqmf_cypress_ep_laboratory_test_performed_audit_key_value
            FROM hqmf_test.laboratory_test_performed AS laboratory_test_performed_1
            JOIN
            valuesets.code_lists AS code_lists_6 ON code_lists_6.code = laboratory_test_performed_1.code
            AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.198.12.1011'
            WHERE laboratory_test_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(laboratory_test_performed_1.negation AS BIT) IS NULL
                   OR CAST(laboratory_test_performed_1.negation AS BIT) = 0)
              AND laboratory_test_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
              AND laboratory_test_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
              AND laboratory_test_performed_1.value IS NOT NULL) AS dc_41
         WHERE dc_41.hqmf_cypress_ep_laboratory_test_performed_start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND dc_41.hqmf_cypress_ep_laboratory_test_performed_end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
         UNION SELECT dc_42.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_42.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_42.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_42.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_7 ON code_lists_7.code = procedure_performed_1.code
            AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.198.12.1010'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)
              AND procedure_performed_1.end_dt < CAST('2015-12-31T00:00:00' AS DATETIME)
              AND results.year_delta(procedure_performed_1.end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) >= 0
              AND results.year_delta(procedure_performed_1.end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) <= 4) AS dc_42
         WHERE dc_42.hqmf_cypress_ep_procedure_performed_end_dt < CAST('2015-12-31T00:00:00' AS DATETIME)
           AND results.year_delta(dc_42.hqmf_cypress_ep_procedure_performed_end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) >= 0
           AND results.year_delta(dc_42.hqmf_cypress_ep_procedure_performed_end_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) <= 4) AS anon_4) 
		   THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_3) AS numerator,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_43.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_43.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_43.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_43.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 50) AS dc_43))
   AND (EXISTS
          (SELECT dc_44.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                  dc_44.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                  dc_44.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                  dc_44.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) < 75) AS dc_44))
   AND (EXISTS
          (SELECT anon_6.patient_id,
                  anon_6.start_dt,
                  anon_6.end_dt,
                  anon_6.audit_key_value
           FROM
             (SELECT dc_52.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                     dc_52.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                     dc_52.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                     dc_52.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_8 ON code_lists_8.code = encounter_performed_1.code
                 AND code_lists_8.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_52
              UNION SELECT dc_53.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_53.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_53.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_53.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_9 ON code_lists_9.code = encounter_performed_1.code
                 AND code_lists_9.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_53
              UNION SELECT dc_54.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_54.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_54.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_54.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_10 ON code_lists_10.code = encounter_performed_1.code
                 AND code_lists_10.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1025'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_54
              UNION SELECT dc_55.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_55.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_55.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_55.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_11 ON code_lists_11.code = encounter_performed_1.code
                 AND code_lists_11.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1023'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_55
              UNION SELECT dc_56.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_56.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_56.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_56.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_12 ON code_lists_12.code = encounter_performed_1.code
                 AND code_lists_12.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1016'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_56
              UNION SELECT dc_57.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_57.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_57.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_57.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_13 ON code_lists_13.code = encounter_performed_1.code
                 AND code_lists_13.code_list_id = '2.16.840.1.113883.3.526.3.1240'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_57) AS anon_6)) 
						THEN cast( 1 as bit) --AS anon_3) 
					   ELSE cast(0 as bit)
					   END AS anon_5) AS [initialPopulation]
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) AS patient_base;

CREATE TABLE results.measure_130_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_130_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, 
[initialPopulation] AS effective_denom, [initialPopulation] & [denominatorExclusions] AS effective_denex, [initialPopulation] & ~ ([initialPopulation] & [denominatorExclusions]) & numerator AS effective_numer, 
CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & [denominatorExclusions]) DESC, ([initialPopulation] &~ ([initialPopulation] & [denominatorExclusions]) & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_130_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

