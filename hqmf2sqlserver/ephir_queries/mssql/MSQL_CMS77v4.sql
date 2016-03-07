--set search_path = results;
create view results.measure_77_0_all as SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN (EXISTS
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
                 valuesets.individual_code_map AS individual_code_map_1 ON individual_code_map_1.code = patient_characteristic_birthdate_1.code
                 AND individual_code_map_1.code_system_oid = '2.16.840.1.113883.6.1'
                 AND individual_code_map_1.measure_code = '21112-8'
                 WHERE patient_characteristic_birthdate_1.patient_id = patient_base.base_patient_id
                   AND (CAST(patient_characteristic_birthdate_1.negation AS BIT) IS NULL
                        OR CAST(patient_characteristic_birthdate_1.negation AS BIT) = 0)
                   AND patient_characteristic_birthdate_1.start_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 13) AS dc_18))
   AND (EXISTS
          (SELECT dc_19.hqmf_cypress_ep_diagnosis_active_patient_id,
                  dc_19.hqmf_cypress_ep_diagnosis_active_start_dt,
                  dc_19.hqmf_cypress_ep_diagnosis_active_end_dt,
                  dc_19.hqmf_cypress_ep_diagnosis_active_audit_key_value
           FROM
             (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                     diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                     diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                     diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
              FROM hqmf_test.diagnosis_active AS diagnosis_active_1
              JOIN
              valuesets.code_lists AS code_lists_1 ON code_lists_1.code = diagnosis_active_1.code
              AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.120.12.1003'
              WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                     OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                AND diagnosis_active_1.start_dt < CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_19))
   AND (EXISTS
          (SELECT anon_2.patient_id,
                  anon_2.start_dt,
                  anon_2.end_dt,
                  anon_2.audit_key_value
           FROM
             (SELECT dc_25.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                     dc_25.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                     dc_25.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                     dc_25.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_2 ON code_lists_2.code = encounter_performed_1.code
                 AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1047'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)
                   AND encounter_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                   AND encounter_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_25
              WHERE dc_25.hqmf_cypress_ep_encounter_performed_start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                AND dc_25.hqmf_cypress_ep_encounter_performed_end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME) INTERSECT
                SELECT dc_26.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                       dc_26.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                       dc_26.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                       dc_26.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
                FROM
                  (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                          encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                          encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                          encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                   FROM
                     (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                             encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                             encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                             encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                      FROM hqmf_test.encounter_performed AS encounter_performed_1
                      JOIN
                      valuesets.code_lists AS code_lists_3 ON code_lists_3.code = encounter_performed_1.code
                      AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1047'
                      WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                        AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                             OR CAST(encounter_performed_1.negation AS BIT) = 0)
                        AND encounter_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                        AND encounter_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_27,
                        hqmf_test.encounter_performed AS encounter_performed_1
                   JOIN
                   valuesets.code_lists AS code_lists_4 ON code_lists_4.code = encounter_performed_1.code
                   AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1047'
                   WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                     AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                          OR CAST(encounter_performed_1.negation AS BIT) = 0)
                     AND encounter_performed_1.start_dt > dc_27.hqmf_cypress_ep_encounter_performed_end_dt
                     AND results.day_delta(encounter_performed_1.start_dt, dc_27.hqmf_cypress_ep_encounter_performed_end_dt) >= 90) AS dc_26,

                  (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                          encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                          encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                          encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                   FROM hqmf_test.encounter_performed AS encounter_performed_1
                   JOIN
                   valuesets.code_lists AS code_lists_5 ON code_lists_5.code = encounter_performed_1.code
                   AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1047'
                   WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                     AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                          OR CAST(encounter_performed_1.negation AS BIT) = 0)
                     AND encounter_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                     AND encounter_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_28 WHERE dc_26.hqmf_cypress_ep_encounter_performed_start_dt > dc_28.hqmf_cypress_ep_encounter_performed_end_dt
                AND results.day_delta(dc_26.hqmf_cypress_ep_encounter_performed_start_dt, dc_28.hqmf_cypress_ep_encounter_performed_end_dt) >= 90) AS anon_2)) 
						THEN cast( 1 as bit)--AS anon_1) 
						ELSE cast( 0 as bit) 
						END AS anon_1) AS [initialPopulation],

  (SELECT CASE WHEN EXISTS
     (SELECT anon_4.patient_id,
             anon_4.start_dt,
             anon_4.end_dt,
             anon_4.audit_key_value
      FROM
        (SELECT dc_32.hqmf_cypress_ep_laboratory_test_performed_patient_id AS patient_id,
                dc_32.hqmf_cypress_ep_laboratory_test_performed_start_dt AS start_dt,
                dc_32.hqmf_cypress_ep_laboratory_test_performed_end_dt AS end_dt,
                dc_32.hqmf_cypress_ep_laboratory_test_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT ordinal_1.hqmf_cypress_ep_laboratory_test_performed_patient_id AS hqmf_cypress_ep_laboratory_test_performed_patient_id,
                   ordinal_1.hqmf_cypress_ep_laboratory_test_performed_start_dt AS hqmf_cypress_ep_laboratory_test_performed_start_dt,
                   ordinal_1.hqmf_cypress_ep_laboratory_test_performed_end_dt AS hqmf_cypress_ep_laboratory_test_performed_end_dt,
                   ordinal_1.hqmf_cypress_ep_laboratory_test_performed_audit_key_value AS hqmf_cypress_ep_laboratory_test_performed_audit_key_value,
                   ordinal_1.row_number_7 AS row_number_7
            FROM
              (SELECT laboratory_test_performed_1.patient_id AS hqmf_cypress_ep_laboratory_test_performed_patient_id,
                      laboratory_test_performed_1.start_dt AS hqmf_cypress_ep_laboratory_test_performed_start_dt,
                      laboratory_test_performed_1.end_dt AS hqmf_cypress_ep_laboratory_test_performed_end_dt,
                      laboratory_test_performed_1.audit_key_value AS hqmf_cypress_ep_laboratory_test_performed_audit_key_value,
                      row_number() OVER (PARTITION BY laboratory_test_performed_1.patient_id
                                         ORDER BY coalesce(laboratory_test_performed_1.start_dt, laboratory_test_performed_1.end_dt) DESC) AS row_number_7
               FROM hqmf_test.laboratory_test_performed AS laboratory_test_performed_1
               JOIN
               valuesets.code_lists AS code_lists_6 ON code_lists_6.code = laboratory_test_performed_1.code
               AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.120.12.1002'
               WHERE laboratory_test_performed_1.patient_id = patient_base.base_patient_id
                 AND (CAST(laboratory_test_performed_1.negation AS BIT) IS NULL
                      OR CAST(laboratory_test_performed_1.negation AS BIT) = 0)
                 AND laboratory_test_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                 AND laboratory_test_performed_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
                 AND laboratory_test_performed_1.value IS NOT NULL) AS ordinal_1
            WHERE ordinal_1.row_number_7 = 1) AS dc_32
         WHERE dc_32.hqmf_cypress_ep_laboratory_test_performed_start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND dc_32.hqmf_cypress_ep_laboratory_test_performed_end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME) INTERSECT
           SELECT dc_33.hqmf_cypress_ep_laboratory_test_performed_patient_id AS patient_id,
                  dc_33.hqmf_cypress_ep_laboratory_test_performed_start_dt AS start_dt,
                  dc_33.hqmf_cypress_ep_laboratory_test_performed_end_dt AS end_dt,
                  dc_33.hqmf_cypress_ep_laboratory_test_performed_audit_key_value AS audit_key_value
           FROM
             (SELECT laboratory_test_performed_1.patient_id AS hqmf_cypress_ep_laboratory_test_performed_patient_id,
                     laboratory_test_performed_1.start_dt AS hqmf_cypress_ep_laboratory_test_performed_start_dt,
                     laboratory_test_performed_1.end_dt AS hqmf_cypress_ep_laboratory_test_performed_end_dt,
                     laboratory_test_performed_1.audit_key_value AS hqmf_cypress_ep_laboratory_test_performed_audit_key_value
              FROM hqmf_test.laboratory_test_performed AS laboratory_test_performed_1
              JOIN
              valuesets.code_lists AS code_lists_7 ON code_lists_7.code = laboratory_test_performed_1.code
              AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.120.12.1002'
              WHERE laboratory_test_performed_1.patient_id = patient_base.base_patient_id
                AND (CAST(laboratory_test_performed_1.negation AS BIT) IS NULL
                     OR CAST(laboratory_test_performed_1.negation AS BIT) = 0)
                AND laboratory_test_performed_1.value < 200) AS dc_33) AS anon_4) 
				   THEN cast( 1 as bit) --AS anon_3) 
				   ELSE cast(0 as bit)
				   END AS anon_3) AS numerator
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) AS patient_base;

CREATE TABLE results.measure_77_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_77_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, 
[initialPopulation] AS effective_denom, CAST(NULL AS BIT) AS effective_denex, 
[initialPopulation] & numerator AS effective_numer, CAST(NULL AS BIT) AS effective_denexcep, 
rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_77_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

