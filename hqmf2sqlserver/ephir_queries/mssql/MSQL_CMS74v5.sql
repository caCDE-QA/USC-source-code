--set search_path = results;
create view results.measure_74_0_all 
as SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_22.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_22.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_22.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_22.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0) AS dc_22))
   AND (EXISTS
          (SELECT dc_23.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                  dc_23.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                  dc_23.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                  dc_23.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                AND patient_characteristic_birthdate_1.start_dt < CAST('2015-01-01T00:00:00' AS DATETIME)
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0
                AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) < 20) AS dc_23))
   AND (EXISTS
          (SELECT anon_2.patient_id,
                  anon_2.start_dt,
                  anon_2.end_dt,
                  anon_2.audit_key_value
           FROM
             (SELECT dc_32.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
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
                 valuesets.code_lists AS code_lists_1 ON code_lists_1.code = encounter_performed_1.code
                 AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
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
                 valuesets.code_lists AS code_lists_2 ON code_lists_2.code = encounter_performed_1.code
                 AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1024'
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
                 valuesets.code_lists AS code_lists_3 ON code_lists_3.code = encounter_performed_1.code
                 AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1022'
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
                 valuesets.code_lists AS code_lists_4 ON code_lists_4.code = encounter_performed_1.code
                 AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1025'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_35
              UNION SELECT dc_36.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
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
                 valuesets.code_lists AS code_lists_5 ON code_lists_5.code = encounter_performed_1.code
                 AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1023'
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
                 valuesets.code_lists AS code_lists_6 ON code_lists_6.code = encounter_performed_1.code
                 AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
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
                 valuesets.code_lists AS code_lists_7 ON code_lists_7.code = encounter_performed_1.code
                 AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.125.12.1003'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_38) AS anon_2)) 
						THEN cast( 1 as bit)--AS anon_1) 
						ELSE cast( 0 as bit) 
						END AS anon_1) [initialPopulation],

  (SELECT CASE WHEN EXISTS
     (SELECT dc_39.hqmf_cypress_ep_procedure_performed_patient_id,
             dc_39.hqmf_cypress_ep_procedure_performed_start_dt,
             dc_39.hqmf_cypress_ep_procedure_performed_end_dt,
             dc_39.hqmf_cypress_ep_procedure_performed_audit_key_value
      FROM
        (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
         FROM hqmf_test.procedure_performed AS procedure_performed_1
         JOIN
         valuesets.code_lists AS code_lists_8 ON code_lists_8.code = procedure_performed_1.code
         AND code_lists_8.code_list_id = '2.16.840.1.113883.3.464.1003.125.12.1002'
         WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
           AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                OR CAST(procedure_performed_1.negation AS BIT) = 0)
           AND procedure_performed_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND procedure_performed_1.end_dt <= CAST('2015-12-31 00:00:00' AS DATETIME)) AS dc_39) 
		   THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_3) numerator
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) patient_base;

CREATE TABLE results.measure_74_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp bit, 
	effective_denom bit, 
	effective_denex bit, 
	effective_numer bit, 
	effective_denexcep bit
);




INSERT INTO results.measure_74_0_patient_summary 
(patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) 
SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, 
[initialPopulation] AS effective_denom, 
CAST(NULL AS BIT) AS effective_denex, ([initialPopulation] & numerator) AS effective_numer, 
CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id 
ORDER BY ([initialPopulation] & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_74_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

