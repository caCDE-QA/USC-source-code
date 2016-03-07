--set search_path = results;
--drop view results.measure_164_0_all;
create view results.measure_164_0_all as SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_24.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_24.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_24.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_24.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   --AND patient_characteristic_birthdate_1.start_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
				   AND DATEDIFF(day, patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME))>0
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 18) AS dc_24))
   AND (EXISTS
          (SELECT anon_2.patient_id,
                  anon_2.start_dt,
                  anon_2.end_dt,
                  anon_2.audit_key_value
           FROM
             (SELECT dc_31.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_31.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_31.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_31.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_1 ON code_lists_1.code = diagnosis_active_1.code
                 AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.104.12.1001'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   --AND diagnosis_active_1.start_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
				   AND DATEDIFF(day, diagnosis_active_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME))>0
                   AND results.month_delta(diagnosis_active_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0
                   AND results.month_delta(diagnosis_active_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) <= 12) AS dc_31
              WHERE dc_31.hqmf_cypress_ep_diagnosis_active_start_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
                AND results.month_delta(dc_31.hqmf_cypress_ep_diagnosis_active_start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0
                AND results.month_delta(dc_31.hqmf_cypress_ep_diagnosis_active_start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) <= 12
              UNION SELECT dc_32.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                           dc_32.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                           dc_32.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                           dc_32.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_2 ON code_lists_2.code = diagnosis_active_1.code
                 AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.104.12.1003'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   --AND (diagnosis_active_1.end_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
				   AND (DATEDIFF(day, diagnosis_active_1.end_dt , CAST('2015-01-01 00:00:00' AS DATETIME))<=0
                        AND CAST('2015-12-31 00:00:00' AS DATETIME) >= diagnosis_active_1.start_dt
                        --OR diagnosis_active_1.start_dt <= CAST('2015-12-31 00:00:00' AS DATETIME)
						OR DATEDIFF(day, diagnosis_active_1.start_dt, CAST('2015-12-31 00:00:00' AS DATETIME))>=0
                        AND diagnosis_active_1.end_dt IS NULL
                        --OR CAST('2015-01-01 00:00:00' AS DATETIME) <= diagnosis_active_1.end_dt
						OR DATEDIFF(day, CAST('2015-01-01 00:00:00' AS DATETIME), diagnosis_active_1.end_dt)>=0
                        AND CAST('2015-12-31 00:00:00' AS DATETIME) IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_32
              WHERE --dc_32.hqmf_cypress_ep_diagnosis_active_end_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
					DATEDIFF(day, dc_32.hqmf_cypress_ep_diagnosis_active_end_dt, CAST('2015-01-01 00:00:00' AS DATETIME))<=0
                --AND CAST('2015-12-31 00:00:00' AS DATETIME) >= dc_32.hqmf_cypress_ep_diagnosis_active_start_dt
				AND DATEDIFF(day, CAST('2015-12-31 00:00:00' AS DATETIME), dc_32.hqmf_cypress_ep_diagnosis_active_start_dt)<=0
                --OR dc_32.hqmf_cypress_ep_diagnosis_active_start_dt <= CAST('2015-12-31 00:00:00' AS DATETIME)
				OR DATEDIFF(day, dc_32.hqmf_cypress_ep_diagnosis_active_start_dt, CAST('2015-12-31 00:00:00' AS DATETIME))>=0
                AND dc_32.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
                --OR CAST('2015-01-01 00:00:00' AS DATETIME) <= dc_32.hqmf_cypress_ep_diagnosis_active_end_dt
				OR DATEDIFF(day, CAST('2015-01-01 00:00:00' AS DATETIME), dc_32.hqmf_cypress_ep_diagnosis_active_end_dt)>=0
                AND CAST('2015-12-31 00:00:00' AS DATETIME) IS NULL
                OR dc_32.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
                AND dc_32.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              UNION SELECT anon_3.patient_id AS patient_id,
                           anon_3.start_dt AS start_dt,
                           anon_3.end_dt AS end_dt,
                           anon_3.audit_key_value AS audit_key_value
              FROM
                (SELECT dc_34.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                        dc_34.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                        dc_34.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                        dc_34.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
                 FROM
                   (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                           procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                           procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                           procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
                    FROM hqmf_test.procedure_performed AS procedure_performed_1
                    JOIN
                    valuesets.code_lists AS code_lists_3 ON code_lists_3.code = procedure_performed_1.code
                    AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.104.12.1010'
                    WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
                      AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                           OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_34
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
                    AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.104.12.1002'
                    WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
                      AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                           OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_35) AS anon_3
              WHERE --anon_3.end_dt < CAST('2015-01-01 00:00:00' AS DATETIME)
					DATEDIFF(day, anon_3.end_dt , CAST('2015-01-01 00:00:00' AS DATETIME))>0
                AND results.month_delta(anon_3.end_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 0
				AND results.month_delta(anon_3.end_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) <= 12) AS anon_2))
   AND (EXISTS
          (SELECT anon_4.patient_id,
                  anon_4.start_dt,
                  anon_4.end_dt,
                  anon_4.audit_key_value
           FROM
             (SELECT dc_43.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                     dc_43.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                     dc_43.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                     dc_43.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_5 ON code_lists_5.code = encounter_performed_1.code
                 AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_43
              UNION SELECT dc_44.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_44.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_44.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_44.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_6 ON code_lists_6.code = encounter_performed_1.code
                 AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_44
              UNION SELECT dc_45.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_45.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_45.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_45.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_7 ON code_lists_7.code = encounter_performed_1.code
                 AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1025'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_45
              UNION SELECT dc_46.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_46.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_46.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_46.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_8 ON code_lists_8.code = encounter_performed_1.code
                 AND code_lists_8.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1023'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_46
              UNION SELECT dc_47.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_47.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_47.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_47.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_9 ON code_lists_9.code = encounter_performed_1.code
                 AND code_lists_9.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1016'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_47
              UNION SELECT dc_48.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_48.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_48.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_48.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_10 ON code_lists_10.code = encounter_performed_1.code
                 AND code_lists_10.code_list_id = '2.16.840.1.113883.3.526.3.1240'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_48) AS anon_4)) 
						THEN cast( 1 as bit) 
					   ELSE cast(0 as bit)
					   END AS anon_1) AS [initialPopulation],

  (SELECT CASE WHEN EXISTS
     (SELECT dc_49.hqmf_cypress_ep_medication_active_patient_id,
             dc_49.hqmf_cypress_ep_medication_active_start_dt,
             dc_49.hqmf_cypress_ep_medication_active_end_dt,
             dc_49.hqmf_cypress_ep_medication_active_audit_key_value
      FROM
        (SELECT medication_active_1.patient_id AS hqmf_cypress_ep_medication_active_patient_id,
                medication_active_1.start_dt AS hqmf_cypress_ep_medication_active_start_dt,
                medication_active_1.end_dt AS hqmf_cypress_ep_medication_active_end_dt,
                medication_active_1.audit_key_value AS hqmf_cypress_ep_medication_active_audit_key_value
         FROM hqmf_test.medication_active AS medication_active_1
         JOIN
         valuesets.code_lists AS code_lists_11 ON code_lists_11.code = medication_active_1.code
         AND code_lists_11.code_list_id = '2.16.840.1.113883.3.464.1003.196.12.1211'
         WHERE medication_active_1.patient_id = patient_base.base_patient_id
           AND (CAST(medication_active_1.negation AS BIT) IS NULL
                OR CAST(medication_active_1.negation AS BIT) = 0)
           --AND (medication_active_1.end_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
				AND (DATEDIFF(day, medication_active_1.end_dt, CAST('2015-01-01 00:00:00' AS DATETIME))<=0
                --AND CAST('2015-12-31 00:00:00' AS DATETIME) >= medication_active_1.start_dt
				AND DATEDIFF(day, CAST('2015-12-31 00:00:00' AS DATETIME), medication_active_1.start_dt)<=0
                --OR medication_active_1.start_dt <= CAST('2015-12-31 00:00:00' AS DATETIME)
				OR DATEDIFF(day, medication_active_1.start_dt,CAST('2015-12-31 00:00:00' AS DATETIME))>=0
                AND medication_active_1.end_dt IS NULL
                --OR CAST('2015-01-01 00:00:00' AS DATETIME) <= medication_active_1.end_dt
				OR DATEDIFF(day, CAST('2015-01-01 00:00:00' AS DATETIME), medication_active_1.end_dt)>=0
                --AND CAST('2015-12-31 00:00:00' AS DATETIME) IS NULL
                OR medication_active_1.start_dt IS NULL
                AND medication_active_1.end_dt IS NULL)) AS dc_49) 
				THEN cast( 1 as bit) 
			   ELSE cast(0 as bit)
			   END AS anon_5) AS numerator
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) AS patient_base;

--truncate table results.measure_164_0_patient_summary;
CREATE TABLE results.measure_164_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_164_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, [initialPopulation] AS effective_denom, 
CAST(NULL AS BIT) AS effective_denex, [initialPopulation] & numerator AS effective_numer, 
CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_164_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

