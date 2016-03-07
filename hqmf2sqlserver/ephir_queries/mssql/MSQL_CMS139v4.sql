--set search_path = results;
create view results.measure_139_0_all 
as 
SELECT patient_base.base_patient_id,

  (SELECT CASE WHEN EXISTS
     (SELECT anon_2.patient_id,
             anon_2.start_dt,
             anon_2.end_dt,
             anon_2.audit_key_value
      FROM
        (SELECT dc_29.hqmf_cypress_ep_risk_category_assessment_patient_id AS patient_id,
                dc_29.hqmf_cypress_ep_risk_category_assessment_start_dt AS start_dt,
                dc_29.hqmf_cypress_ep_risk_category_assessment_end_dt AS end_dt,
                dc_29.hqmf_cypress_ep_risk_category_assessment_audit_key_value AS audit_key_value
         FROM
           (SELECT risk_category_assessment_1.patient_id AS hqmf_cypress_ep_risk_category_assessment_patient_id,
                   risk_category_assessment_1.start_dt AS hqmf_cypress_ep_risk_category_assessment_start_dt,
                   risk_category_assessment_1.end_dt AS hqmf_cypress_ep_risk_category_assessment_end_dt,
                   risk_category_assessment_1.audit_key_value AS hqmf_cypress_ep_risk_category_assessment_audit_key_value
            FROM hqmf_test.risk_category_assessment AS risk_category_assessment_1
            JOIN
            valuesets.code_lists AS code_lists_1 ON code_lists_1.code = risk_category_assessment_1.code
            AND code_lists_1.code_list_id = '2.16.840.1.113883.3.464.1003.118.12.1028'
            WHERE risk_category_assessment_1.patient_id = patient_base.base_patient_id
              AND CAST(risk_category_assessment_1.negation AS BIT) = 1
              AND risk_category_assessment_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
              AND risk_category_assessment_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_29
         WHERE dc_29.hqmf_cypress_ep_risk_category_assessment_start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND dc_29.hqmf_cypress_ep_risk_category_assessment_end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
         UNION SELECT dc_30.hqmf_cypress_ep_risk_category_assessment_patient_id AS patient_id,
                      dc_30.hqmf_cypress_ep_risk_category_assessment_start_dt AS start_dt,
                      dc_30.hqmf_cypress_ep_risk_category_assessment_end_dt AS end_dt,
                      dc_30.hqmf_cypress_ep_risk_category_assessment_audit_key_value AS audit_key_value
         FROM
           (SELECT risk_category_assessment_1.patient_id AS hqmf_cypress_ep_risk_category_assessment_patient_id,
                   risk_category_assessment_1.start_dt AS hqmf_cypress_ep_risk_category_assessment_start_dt,
                   risk_category_assessment_1.end_dt AS hqmf_cypress_ep_risk_category_assessment_end_dt,
                   risk_category_assessment_1.audit_key_value AS hqmf_cypress_ep_risk_category_assessment_audit_key_value
            FROM hqmf_test.risk_category_assessment AS risk_category_assessment_1
            JOIN
            valuesets.code_lists AS code_lists_2 ON code_lists_2.code = risk_category_assessment_1.code
            AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.118.12.1009'
            WHERE risk_category_assessment_1.patient_id = patient_base.base_patient_id
              AND (CAST(risk_category_assessment_1.negation AS BIT) IS NULL
                   OR CAST(risk_category_assessment_1.negation AS BIT) = 0)
              AND (risk_category_assessment_1.end_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                   AND CAST('2015-12-31T00:00:00' AS DATETIME) >= risk_category_assessment_1.start_dt
                   OR risk_category_assessment_1.start_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
                   AND risk_category_assessment_1.end_dt IS NULL
                   OR CAST('2015-01-01 00:00:00' AS DATETIME) <= risk_category_assessment_1.end_dt
                   AND CAST('2015-12-31T00:00:00' AS DATETIME) IS NULL
                   OR risk_category_assessment_1.start_dt IS NULL
                   AND risk_category_assessment_1.end_dt IS NULL)) AS dc_30
         WHERE dc_30.hqmf_cypress_ep_risk_category_assessment_end_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND CAST('2015-12-31T00:00:00' AS DATETIME) >= dc_30.hqmf_cypress_ep_risk_category_assessment_start_dt
           OR dc_30.hqmf_cypress_ep_risk_category_assessment_start_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)
           AND dc_30.hqmf_cypress_ep_risk_category_assessment_end_dt IS NULL
           OR CAST('2015-01-01 00:00:00' AS DATETIME) <= dc_30.hqmf_cypress_ep_risk_category_assessment_end_dt
           AND CAST('2015-12-31T00:00:00' AS DATETIME) IS NULL
           OR dc_30.hqmf_cypress_ep_risk_category_assessment_start_dt IS NULL
           AND dc_30.hqmf_cypress_ep_risk_category_assessment_end_dt IS NULL) AS anon_2) 
		   THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_1) AS [denominatorExceptions],

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_31.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_31.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_31.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_31.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 65) AS dc_31))
   AND (EXISTS
          (SELECT anon_4.patient_id,
                  anon_4.start_dt,
                  anon_4.end_dt,
                  anon_4.audit_key_value
           FROM
             (SELECT dc_44.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
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
                 valuesets.code_lists AS code_lists_3 ON code_lists_3.code = encounter_performed_1.code
                 AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
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
                 valuesets.code_lists AS code_lists_4 ON code_lists_4.code = encounter_performed_1.code
                 AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
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
                 valuesets.code_lists AS code_lists_5 ON code_lists_5.code = encounter_performed_1.code
                 AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1026'
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
                 valuesets.code_lists AS code_lists_6 ON code_lists_6.code = encounter_performed_1.code
                 AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1012'
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
                 valuesets.code_lists AS code_lists_7 ON code_lists_7.code = encounter_performed_1.code
                 AND code_lists_7.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1014'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_48
              UNION SELECT dc_49.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_49.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_49.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_49.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
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
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_49
              UNION SELECT dc_50.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_50.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_50.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_50.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
              FROM
                (SELECT encounter_performed_1.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
                        encounter_performed_1.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
                        encounter_performed_1.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
                        encounter_performed_1.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
                 FROM hqmf_test.encounter_performed AS encounter_performed_1
                 JOIN
                 valuesets.code_lists AS code_lists_9 ON code_lists_9.code = encounter_performed_1.code
                 AND code_lists_9.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1023'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_50
              UNION SELECT dc_51.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
                           dc_51.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
                           dc_51.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
                           dc_51.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
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
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_51
              UNION SELECT dc_52.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
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
                 valuesets.code_lists AS code_lists_11 ON code_lists_11.code = encounter_performed_1.code
                 AND code_lists_11.code_list_id = '2.16.840.1.113883.3.526.3.1240'
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
                 valuesets.code_lists AS code_lists_12 ON code_lists_12.code = encounter_performed_1.code
                 AND code_lists_12.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1066'
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
                 valuesets.code_lists AS code_lists_13 ON code_lists_13.code = encounter_performed_1.code
                 AND code_lists_13.code_list_id = '2.16.840.1.113883.3.526.3.1285'
                 WHERE encounter_performed_1.patient_id = patient_base.base_patient_id
                   AND (CAST(encounter_performed_1.negation AS BIT) IS NULL
                        OR CAST(encounter_performed_1.negation AS BIT) = 0)) AS dc_54) AS anon_4)) 
						THEN cast( 1 as bit) 
					   ELSE cast(0 as bit)
					   END AS anon_3) AS [initialPopulation],

  (SELECT CASE WHEN EXISTS
     (SELECT dc_55.hqmf_cypress_ep_risk_category_assessment_patient_id,
             dc_55.hqmf_cypress_ep_risk_category_assessment_start_dt,
             dc_55.hqmf_cypress_ep_risk_category_assessment_end_dt,
             dc_55.hqmf_cypress_ep_risk_category_assessment_audit_key_value
      FROM
        (SELECT risk_category_assessment_1.patient_id AS hqmf_cypress_ep_risk_category_assessment_patient_id,
                risk_category_assessment_1.start_dt AS hqmf_cypress_ep_risk_category_assessment_start_dt,
                risk_category_assessment_1.end_dt AS hqmf_cypress_ep_risk_category_assessment_end_dt,
                risk_category_assessment_1.audit_key_value AS hqmf_cypress_ep_risk_category_assessment_audit_key_value
         FROM hqmf_test.risk_category_assessment AS risk_category_assessment_1
         JOIN
         valuesets.code_lists AS code_lists_14 ON code_lists_14.code = risk_category_assessment_1.code
         AND code_lists_14.code_list_id = '2.16.840.1.113883.3.464.1003.118.12.1028'
         WHERE risk_category_assessment_1.patient_id = patient_base.base_patient_id
           AND (CAST(risk_category_assessment_1.negation AS BIT) IS NULL
                OR CAST(risk_category_assessment_1.negation AS BIT) = 0)
           AND risk_category_assessment_1.start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
           AND risk_category_assessment_1.end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS dc_55) 
		   THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_5) AS numerator
FROM
  (SELECT base_patients.patient_id AS base_patient_id
   FROM hqmf_test.patients AS base_patients) AS patient_base;

CREATE TABLE results.measure_139_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_139_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, [initialPopulation] AS effective_denom, CAST(NULL AS BIT) AS effective_denex, [initialPopulation] & numerator AS effective_numer, CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_139_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

