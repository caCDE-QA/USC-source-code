--set search_path = results;
create view results.measure_132_0_all as WITH so_41_procedure_performed 
AS
  (SELECT procedure_performed_1.patient_id AS so_41_procedure_performed_patient_id,
          procedure_performed_1.audit_key_value AS so_41_procedure_performed_audit_key_value,
          procedure_performed_1.start_dt AS so_41_procedure_performed_start_dt,
          procedure_performed_1.end_dt AS so_41_procedure_performed_end_dt
   FROM hqmf_test.procedure_performed AS procedure_performed_1
   JOIN
   valuesets.code_lists AS code_lists_9 ON code_lists_9.code = procedure_performed_1.code
   AND code_lists_9.code_list_id = '2.16.840.1.113883.3.526.3.1411'
   WHERE CAST(procedure_performed_1.negation AS BIT) IS NULL
     OR CAST(procedure_performed_1.negation AS BIT) = 0)
SELECT patient_base.base_patient_id,
       patient_base.so_41_procedure_performed_audit_key_value,
       patient_base.so_41_procedure_performed_start_dt,
       patient_base.so_41_procedure_performed_end_dt,

  (SELECT CASE WHEN EXISTS
     (SELECT anon_2.patient_id,
             anon_2.start_dt,
             anon_2.end_dt,
             anon_2.audit_key_value
      FROM
        (SELECT dc_159.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                dc_159.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                dc_159.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                dc_159.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_1 ON code_lists_1.code = procedure_performed_1.code
            AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1436'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_159
         UNION SELECT dc_160.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_160.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_160.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_160.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_2 ON code_lists_2.code = procedure_performed_1.code
            AND code_lists_2.code_list_id = '2.16.840.1.113883.3.526.3.1422'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_160
         UNION SELECT dc_161.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_161.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_161.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_161.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_3 ON code_lists_3.code = procedure_performed_1.code
            AND code_lists_3.code_list_id = '2.16.840.1.113883.3.526.3.1408'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_161
         UNION SELECT dc_162.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_162.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_162.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_162.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_4 ON code_lists_4.code = procedure_performed_1.code
            AND code_lists_4.code_list_id = '2.16.840.1.113883.3.526.3.1429'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_162
         UNION SELECT dc_163.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_163.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_163.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_163.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_5 ON code_lists_5.code = procedure_performed_1.code
            AND code_lists_5.code_list_id = '2.16.840.1.113883.3.526.3.1447'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_163
         UNION SELECT dc_164.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_164.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_164.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_164.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_6 ON code_lists_6.code = procedure_performed_1.code
            AND code_lists_6.code_list_id = '2.16.840.1.113883.3.526.3.1437'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_164
         UNION SELECT dc_165.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_165.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_165.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_165.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_7 ON code_lists_7.code = procedure_performed_1.code
            AND code_lists_7.code_list_id = '2.16.840.1.113883.3.526.3.1440'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_165
         UNION SELECT dc_166.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                      dc_166.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                      dc_166.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                      dc_166.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_8 ON code_lists_8.code = procedure_performed_1.code
            AND code_lists_8.code_list_id = '2.16.840.1.113883.3.526.3.1439'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)) AS dc_166) AS anon_2) 
				   THEN cast( 1 as bit) 
				   ELSE cast(0 as bit)
				   END AS anon_1) AS numerator,

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_167.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_167.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_167.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_167.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 18) AS dc_167))
   AND (EXISTS
          (SELECT so_168.so_41_procedure_performed_patient_id,
                  so_168.so_41_procedure_performed_start_dt,
                  so_168.so_41_procedure_performed_end_dt,
                  so_168.so_41_procedure_performed_audit_key_value
           FROM
             (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                     so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                     so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                     so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
              FROM so_41_procedure_performed
              WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value
                AND so_41_procedure_performed.so_41_procedure_performed_start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                AND so_41_procedure_performed.so_41_procedure_performed_end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS so_168)) 
				THEN cast( 1 as bit)  
				   ELSE cast(0 as bit)
				   END AS anon_3) AS [initialPopulation],

  (SELECT CASE WHEN EXISTS
     (SELECT anon_5.patient_id,
             anon_5.start_dt,
             anon_5.end_dt,
             anon_5.audit_key_value
      FROM
        (SELECT dc_397.hqmf_cypress_ep_procedure_performed_patient_id AS patient_id,
                dc_397.hqmf_cypress_ep_procedure_performed_start_dt AS start_dt,
                dc_397.hqmf_cypress_ep_procedure_performed_end_dt AS end_dt,
                dc_397.hqmf_cypress_ep_procedure_performed_audit_key_value AS audit_key_value
         FROM
           (SELECT procedure_performed_1.patient_id AS hqmf_cypress_ep_procedure_performed_patient_id,
                   procedure_performed_1.start_dt AS hqmf_cypress_ep_procedure_performed_start_dt,
                   procedure_performed_1.end_dt AS hqmf_cypress_ep_procedure_performed_end_dt,
                   procedure_performed_1.audit_key_value AS hqmf_cypress_ep_procedure_performed_audit_key_value
            FROM
              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_398,
                 hqmf_test.procedure_performed AS procedure_performed_1
            JOIN
            valuesets.code_lists AS code_lists_10 ON code_lists_10.code = procedure_performed_1.code
            AND code_lists_10.code_list_id = '2.16.840.1.113883.3.526.3.1434'
            WHERE procedure_performed_1.patient_id = patient_base.base_patient_id
              AND (CAST(procedure_performed_1.negation AS BIT) IS NULL
                   OR CAST(procedure_performed_1.negation AS BIT) = 0)
              AND procedure_performed_1.end_dt < so_398.so_41_procedure_performed_start_dt) AS dc_397,

           (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                   so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                   so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                   so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
            FROM so_41_procedure_performed
            WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_399
         WHERE dc_397.hqmf_cypress_ep_procedure_performed_end_dt < so_399.so_41_procedure_performed_start_dt
         UNION SELECT anon_6.patient_id AS patient_id,
                      anon_6.start_dt AS start_dt,
                      anon_6.end_dt AS end_dt,
                      anon_6.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_401.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_401.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_401.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_401.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_402,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_11 ON code_lists_11.code = diagnosis_active_1.code
               AND code_lists_11.code_list_id = '2.16.840.1.113883.3.526.3.1241'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_402.so_41_procedure_performed_start_dt) AS dc_401,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_403
            WHERE dc_401.hqmf_cypress_ep_diagnosis_active_start_dt < so_403.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_404.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_404.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_404.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_404.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_405,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_12 ON code_lists_12.code = diagnosis_active_1.code
                 AND code_lists_12.code_list_id = '2.16.840.1.113883.3.526.3.1241'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_405.so_41_procedure_performed_start_dt
                        AND so_405.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_405.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_405.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_405.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_404,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_406 WHERE dc_404.hqmf_cypress_ep_diagnosis_active_end_dt >= so_406.so_41_procedure_performed_start_dt
              AND so_406.so_41_procedure_performed_end_dt >= dc_404.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_404.hqmf_cypress_ep_diagnosis_active_start_dt <= so_406.so_41_procedure_performed_end_dt
              AND dc_404.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_406.so_41_procedure_performed_start_dt <= dc_404.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_406.so_41_procedure_performed_end_dt IS NULL
              OR dc_404.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_404.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_6
         UNION SELECT anon_7.patient_id AS patient_id,
                      anon_7.start_dt AS start_dt,
                      anon_7.end_dt AS end_dt,
                      anon_7.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_408.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_408.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_408.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_408.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_409,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_13 ON code_lists_13.code = diagnosis_active_1.code
               AND code_lists_13.code_list_id = '2.16.840.1.113883.3.526.3.1405'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_409.so_41_procedure_performed_start_dt) AS dc_408,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_410
            WHERE dc_408.hqmf_cypress_ep_diagnosis_active_start_dt < so_410.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_411.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_411.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_411.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_411.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_412,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_14 ON code_lists_14.code = diagnosis_active_1.code
                 AND code_lists_14.code_list_id = '2.16.840.1.113883.3.526.3.1405'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_412.so_41_procedure_performed_start_dt
                        AND so_412.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_412.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_412.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_412.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_411,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_413 WHERE dc_411.hqmf_cypress_ep_diagnosis_active_end_dt >= so_413.so_41_procedure_performed_start_dt
              AND so_413.so_41_procedure_performed_end_dt >= dc_411.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_411.hqmf_cypress_ep_diagnosis_active_start_dt <= so_413.so_41_procedure_performed_end_dt
              AND dc_411.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_413.so_41_procedure_performed_start_dt <= dc_411.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_413.so_41_procedure_performed_end_dt IS NULL
              OR dc_411.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_411.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_7
         UNION SELECT anon_8.patient_id AS patient_id,
                      anon_8.start_dt AS start_dt,
                      anon_8.end_dt AS end_dt,
                      anon_8.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_415.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_415.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_415.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_415.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_416,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_15 ON code_lists_15.code = diagnosis_active_1.code
               AND code_lists_15.code_list_id = '2.16.840.1.113883.3.526.3.1428'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_416.so_41_procedure_performed_start_dt) AS dc_415,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_417
            WHERE dc_415.hqmf_cypress_ep_diagnosis_active_start_dt < so_417.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_418.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_418.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_418.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_418.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_419,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_16 ON code_lists_16.code = diagnosis_active_1.code
                 AND code_lists_16.code_list_id = '2.16.840.1.113883.3.526.3.1428'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_419.so_41_procedure_performed_start_dt
                        AND so_419.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_419.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_419.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_419.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_418,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_420 WHERE dc_418.hqmf_cypress_ep_diagnosis_active_end_dt >= so_420.so_41_procedure_performed_start_dt
              AND so_420.so_41_procedure_performed_end_dt >= dc_418.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_418.hqmf_cypress_ep_diagnosis_active_start_dt <= so_420.so_41_procedure_performed_end_dt
              AND dc_418.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_420.so_41_procedure_performed_start_dt <= dc_418.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_420.so_41_procedure_performed_end_dt IS NULL
              OR dc_418.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_418.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_8
         UNION SELECT anon_9.patient_id AS patient_id,
                      anon_9.start_dt AS start_dt,
                      anon_9.end_dt AS end_dt,
                      anon_9.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_422.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_422.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_422.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_422.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_423,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_17 ON code_lists_17.code = diagnosis_active_1.code
               AND code_lists_17.code_list_id = '2.16.840.1.113883.3.526.3.1409'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_423.so_41_procedure_performed_start_dt) AS dc_422,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_424
            WHERE dc_422.hqmf_cypress_ep_diagnosis_active_start_dt < so_424.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_425.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_425.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_425.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_425.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_426,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_18 ON code_lists_18.code = diagnosis_active_1.code
                 AND code_lists_18.code_list_id = '2.16.840.1.113883.3.526.3.1409'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_426.so_41_procedure_performed_start_dt
                        AND so_426.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_426.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_426.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_426.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_425,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_427 WHERE dc_425.hqmf_cypress_ep_diagnosis_active_end_dt >= so_427.so_41_procedure_performed_start_dt
              AND so_427.so_41_procedure_performed_end_dt >= dc_425.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_425.hqmf_cypress_ep_diagnosis_active_start_dt <= so_427.so_41_procedure_performed_end_dt
              AND dc_425.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_427.so_41_procedure_performed_start_dt <= dc_425.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_427.so_41_procedure_performed_end_dt IS NULL
              OR dc_425.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_425.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_9
         UNION SELECT anon_10.patient_id AS patient_id,
                      anon_10.start_dt AS start_dt,
                      anon_10.end_dt AS end_dt,
                      anon_10.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_429.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_429.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_429.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_429.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_430,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_19 ON code_lists_19.code = diagnosis_active_1.code
               AND code_lists_19.code_list_id = '2.16.840.1.113883.3.526.3.1435'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_430.so_41_procedure_performed_start_dt) AS dc_429,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_431
            WHERE dc_429.hqmf_cypress_ep_diagnosis_active_start_dt < so_431.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_432.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_432.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_432.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_432.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_433,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_20 ON code_lists_20.code = diagnosis_active_1.code
                 AND code_lists_20.code_list_id = '2.16.840.1.113883.3.526.3.1435'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_433.so_41_procedure_performed_start_dt
                        AND so_433.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_433.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_433.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_433.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_432,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_434 WHERE dc_432.hqmf_cypress_ep_diagnosis_active_end_dt >= so_434.so_41_procedure_performed_start_dt
              AND so_434.so_41_procedure_performed_end_dt >= dc_432.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_432.hqmf_cypress_ep_diagnosis_active_start_dt <= so_434.so_41_procedure_performed_end_dt
              AND dc_432.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_434.so_41_procedure_performed_start_dt <= dc_432.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_434.so_41_procedure_performed_end_dt IS NULL
              OR dc_432.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_432.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_10
         UNION SELECT anon_11.patient_id AS patient_id,
                      anon_11.start_dt AS start_dt,
                      anon_11.end_dt AS end_dt,
                      anon_11.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_436.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_436.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_436.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_436.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_437,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_21 ON code_lists_21.code = diagnosis_active_1.code
               AND code_lists_21.code_list_id = '2.16.840.1.113883.3.526.3.1441'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_437.so_41_procedure_performed_start_dt) AS dc_436,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_438
            WHERE dc_436.hqmf_cypress_ep_diagnosis_active_start_dt < so_438.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_439.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_439.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_439.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_439.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_440,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_22 ON code_lists_22.code = diagnosis_active_1.code
                 AND code_lists_22.code_list_id = '2.16.840.1.113883.3.526.3.1441'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_440.so_41_procedure_performed_start_dt
                        AND so_440.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_440.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_440.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_440.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_439,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_441 WHERE dc_439.hqmf_cypress_ep_diagnosis_active_end_dt >= so_441.so_41_procedure_performed_start_dt
              AND so_441.so_41_procedure_performed_end_dt >= dc_439.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_439.hqmf_cypress_ep_diagnosis_active_start_dt <= so_441.so_41_procedure_performed_end_dt
              AND dc_439.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_441.so_41_procedure_performed_start_dt <= dc_439.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_441.so_41_procedure_performed_end_dt IS NULL
              OR dc_439.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_439.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_11
         UNION SELECT anon_12.patient_id AS patient_id,
                      anon_12.start_dt AS start_dt,
                      anon_12.end_dt AS end_dt,
                      anon_12.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_443.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_443.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_443.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_443.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_444,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_23 ON code_lists_23.code = diagnosis_active_1.code
               AND code_lists_23.code_list_id = '2.16.840.1.113883.3.526.3.1426'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_444.so_41_procedure_performed_start_dt) AS dc_443,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_445
            WHERE dc_443.hqmf_cypress_ep_diagnosis_active_start_dt < so_445.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_446.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_446.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_446.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_446.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_447,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_24 ON code_lists_24.code = diagnosis_active_1.code
                 AND code_lists_24.code_list_id = '2.16.840.1.113883.3.526.3.1426'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_447.so_41_procedure_performed_start_dt
                        AND so_447.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_447.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_447.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_447.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_446,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_448 WHERE dc_446.hqmf_cypress_ep_diagnosis_active_end_dt >= so_448.so_41_procedure_performed_start_dt
              AND so_448.so_41_procedure_performed_end_dt >= dc_446.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_446.hqmf_cypress_ep_diagnosis_active_start_dt <= so_448.so_41_procedure_performed_end_dt
              AND dc_446.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_448.so_41_procedure_performed_start_dt <= dc_446.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_448.so_41_procedure_performed_end_dt IS NULL
              OR dc_446.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_446.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_12
         UNION SELECT anon_13.patient_id AS patient_id,
                      anon_13.start_dt AS start_dt,
                      anon_13.end_dt AS end_dt,
                      anon_13.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_450.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_450.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_450.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_450.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_451,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_25 ON code_lists_25.code = diagnosis_active_1.code
               AND code_lists_25.code_list_id = '2.16.840.1.113883.3.526.3.1410'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_451.so_41_procedure_performed_start_dt) AS dc_450,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_452
            WHERE dc_450.hqmf_cypress_ep_diagnosis_active_start_dt < so_452.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_453.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_453.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_453.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_453.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_454,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_26 ON code_lists_26.code = diagnosis_active_1.code
                 AND code_lists_26.code_list_id = '2.16.840.1.113883.3.526.3.1410'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_454.so_41_procedure_performed_start_dt
                        AND so_454.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_454.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_454.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_454.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_453,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_455 WHERE dc_453.hqmf_cypress_ep_diagnosis_active_end_dt >= so_455.so_41_procedure_performed_start_dt
              AND so_455.so_41_procedure_performed_end_dt >= dc_453.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_453.hqmf_cypress_ep_diagnosis_active_start_dt <= so_455.so_41_procedure_performed_end_dt
              AND dc_453.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_455.so_41_procedure_performed_start_dt <= dc_453.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_455.so_41_procedure_performed_end_dt IS NULL
              OR dc_453.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_453.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_13
         UNION SELECT anon_14.patient_id AS patient_id,
                      anon_14.start_dt AS start_dt,
                      anon_14.end_dt AS end_dt,
                      anon_14.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_457.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_457.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_457.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_457.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_458,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_27 ON code_lists_27.code = diagnosis_active_1.code
               AND code_lists_27.code_list_id = '2.16.840.1.113883.3.526.3.1425'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_458.so_41_procedure_performed_start_dt) AS dc_457,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_459
            WHERE dc_457.hqmf_cypress_ep_diagnosis_active_start_dt < so_459.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_460.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_460.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_460.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_460.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_461,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_28 ON code_lists_28.code = diagnosis_active_1.code
                 AND code_lists_28.code_list_id = '2.16.840.1.113883.3.526.3.1425'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_461.so_41_procedure_performed_start_dt
                        AND so_461.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_461.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_461.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_461.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_460,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_462 WHERE dc_460.hqmf_cypress_ep_diagnosis_active_end_dt >= so_462.so_41_procedure_performed_start_dt
              AND so_462.so_41_procedure_performed_end_dt >= dc_460.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_460.hqmf_cypress_ep_diagnosis_active_start_dt <= so_462.so_41_procedure_performed_end_dt
              AND dc_460.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_462.so_41_procedure_performed_start_dt <= dc_460.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_462.so_41_procedure_performed_end_dt IS NULL
              OR dc_460.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_460.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_14
         UNION SELECT anon_15.patient_id AS patient_id,
                      anon_15.start_dt AS start_dt,
                      anon_15.end_dt AS end_dt,
                      anon_15.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_464.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_464.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_464.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_464.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_465,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_29 ON code_lists_29.code = diagnosis_active_1.code
               AND code_lists_29.code_list_id = '2.16.840.1.113883.3.526.3.1427'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_465.so_41_procedure_performed_start_dt) AS dc_464,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_466
            WHERE dc_464.hqmf_cypress_ep_diagnosis_active_start_dt < so_466.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_467.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_467.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_467.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_467.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_468,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_30 ON code_lists_30.code = diagnosis_active_1.code
                 AND code_lists_30.code_list_id = '2.16.840.1.113883.3.526.3.1427'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_468.so_41_procedure_performed_start_dt
                        AND so_468.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_468.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_468.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_468.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_467,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_469 WHERE dc_467.hqmf_cypress_ep_diagnosis_active_end_dt >= so_469.so_41_procedure_performed_start_dt
              AND so_469.so_41_procedure_performed_end_dt >= dc_467.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_467.hqmf_cypress_ep_diagnosis_active_start_dt <= so_469.so_41_procedure_performed_end_dt
              AND dc_467.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_469.so_41_procedure_performed_start_dt <= dc_467.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_469.so_41_procedure_performed_end_dt IS NULL
              OR dc_467.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_467.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_15
         UNION SELECT anon_16.patient_id AS patient_id,
                      anon_16.start_dt AS start_dt,
                      anon_16.end_dt AS end_dt,
                      anon_16.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_471.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_471.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_471.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_471.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_472,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_31 ON code_lists_31.code = diagnosis_active_1.code
               AND code_lists_31.code_list_id = '2.16.840.1.113883.3.526.3.1412'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_472.so_41_procedure_performed_start_dt) AS dc_471,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_473
            WHERE dc_471.hqmf_cypress_ep_diagnosis_active_start_dt < so_473.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_474.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_474.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_474.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_474.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_475,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_32 ON code_lists_32.code = diagnosis_active_1.code
                 AND code_lists_32.code_list_id = '2.16.840.1.113883.3.526.3.1412'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_475.so_41_procedure_performed_start_dt
                        AND so_475.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_475.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_475.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_475.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_474,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_476 WHERE dc_474.hqmf_cypress_ep_diagnosis_active_end_dt >= so_476.so_41_procedure_performed_start_dt
              AND so_476.so_41_procedure_performed_end_dt >= dc_474.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_474.hqmf_cypress_ep_diagnosis_active_start_dt <= so_476.so_41_procedure_performed_end_dt
              AND dc_474.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_476.so_41_procedure_performed_start_dt <= dc_474.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_476.so_41_procedure_performed_end_dt IS NULL
              OR dc_474.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_474.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_16
         UNION SELECT anon_17.patient_id AS patient_id,
                      anon_17.start_dt AS start_dt,
                      anon_17.end_dt AS end_dt,
                      anon_17.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_478.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_478.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_478.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_478.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_479,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_33 ON code_lists_33.code = diagnosis_active_1.code
               AND code_lists_33.code_list_id = '2.16.840.1.113883.3.526.3.1420'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_479.so_41_procedure_performed_start_dt) AS dc_478,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_480
            WHERE dc_478.hqmf_cypress_ep_diagnosis_active_start_dt < so_480.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_481.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_481.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_481.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_481.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_482,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_34 ON code_lists_34.code = diagnosis_active_1.code
                 AND code_lists_34.code_list_id = '2.16.840.1.113883.3.526.3.1420'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_482.so_41_procedure_performed_start_dt
                        AND so_482.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_482.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_482.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_482.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_481,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_483 WHERE dc_481.hqmf_cypress_ep_diagnosis_active_end_dt >= so_483.so_41_procedure_performed_start_dt
              AND so_483.so_41_procedure_performed_end_dt >= dc_481.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_481.hqmf_cypress_ep_diagnosis_active_start_dt <= so_483.so_41_procedure_performed_end_dt
              AND dc_481.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_483.so_41_procedure_performed_start_dt <= dc_481.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_483.so_41_procedure_performed_end_dt IS NULL
              OR dc_481.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_481.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_17
         UNION SELECT anon_18.patient_id AS patient_id,
                      anon_18.start_dt AS start_dt,
                      anon_18.end_dt AS end_dt,
                      anon_18.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_485.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_485.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_485.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_485.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_486,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_35 ON code_lists_35.code = diagnosis_active_1.code
               AND code_lists_35.code_list_id = '2.16.840.1.113883.3.526.3.1423'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_486.so_41_procedure_performed_start_dt) AS dc_485,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_487
            WHERE dc_485.hqmf_cypress_ep_diagnosis_active_start_dt < so_487.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_488.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_488.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_488.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_488.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_489,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_36 ON code_lists_36.code = diagnosis_active_1.code
                 AND code_lists_36.code_list_id = '2.16.840.1.113883.3.526.3.1423'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_489.so_41_procedure_performed_start_dt
                        AND so_489.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_489.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_489.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_489.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_488,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_490 WHERE dc_488.hqmf_cypress_ep_diagnosis_active_end_dt >= so_490.so_41_procedure_performed_start_dt
              AND so_490.so_41_procedure_performed_end_dt >= dc_488.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_488.hqmf_cypress_ep_diagnosis_active_start_dt <= so_490.so_41_procedure_performed_end_dt
              AND dc_488.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_490.so_41_procedure_performed_start_dt <= dc_488.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_490.so_41_procedure_performed_end_dt IS NULL
              OR dc_488.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_488.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_18
         UNION SELECT anon_19.patient_id AS patient_id,
                      anon_19.start_dt AS start_dt,
                      anon_19.end_dt AS end_dt,
                      anon_19.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_492.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_492.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_492.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_492.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_493,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_37 ON code_lists_37.code = diagnosis_active_1.code
               AND code_lists_37.code_list_id = '2.16.840.1.113883.3.526.3.1413'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_493.so_41_procedure_performed_start_dt) AS dc_492,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_494
            WHERE dc_492.hqmf_cypress_ep_diagnosis_active_start_dt < so_494.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_495.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_495.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_495.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_495.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_496,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_38 ON code_lists_38.code = diagnosis_active_1.code
                 AND code_lists_38.code_list_id = '2.16.840.1.113883.3.526.3.1413'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_496.so_41_procedure_performed_start_dt
                        AND so_496.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_496.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_496.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_496.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_495,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_497 WHERE dc_495.hqmf_cypress_ep_diagnosis_active_end_dt >= so_497.so_41_procedure_performed_start_dt
              AND so_497.so_41_procedure_performed_end_dt >= dc_495.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_495.hqmf_cypress_ep_diagnosis_active_start_dt <= so_497.so_41_procedure_performed_end_dt
              AND dc_495.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_497.so_41_procedure_performed_start_dt <= dc_495.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_497.so_41_procedure_performed_end_dt IS NULL
              OR dc_495.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_495.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_19
         UNION SELECT anon_20.patient_id AS patient_id,
                      anon_20.start_dt AS start_dt,
                      anon_20.end_dt AS end_dt,
                      anon_20.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_499.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_499.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_499.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_499.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_500,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_39 ON code_lists_39.code = diagnosis_active_1.code
               AND code_lists_39.code_list_id = '2.16.840.1.113883.3.526.3.1443'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_500.so_41_procedure_performed_start_dt) AS dc_499,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_501
            WHERE dc_499.hqmf_cypress_ep_diagnosis_active_start_dt < so_501.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_502.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_502.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_502.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_502.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_503,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_40 ON code_lists_40.code = diagnosis_active_1.code
                 AND code_lists_40.code_list_id = '2.16.840.1.113883.3.526.3.1443'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_503.so_41_procedure_performed_start_dt
                        AND so_503.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_503.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_503.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_503.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_502,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_504 WHERE dc_502.hqmf_cypress_ep_diagnosis_active_end_dt >= so_504.so_41_procedure_performed_start_dt
              AND so_504.so_41_procedure_performed_end_dt >= dc_502.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_502.hqmf_cypress_ep_diagnosis_active_start_dt <= so_504.so_41_procedure_performed_end_dt
              AND dc_502.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_504.so_41_procedure_performed_start_dt <= dc_502.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_504.so_41_procedure_performed_end_dt IS NULL
              OR dc_502.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_502.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_20
         UNION SELECT anon_21.patient_id AS patient_id,
                      anon_21.start_dt AS start_dt,
                      anon_21.end_dt AS end_dt,
                      anon_21.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_506.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_506.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_506.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_506.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_507,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_41 ON code_lists_41.code = diagnosis_active_1.code
               AND code_lists_41.code_list_id = '2.16.840.1.113883.3.526.3.1414'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_507.so_41_procedure_performed_start_dt) AS dc_506,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_508
            WHERE dc_506.hqmf_cypress_ep_diagnosis_active_start_dt < so_508.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_509.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_509.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_509.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_509.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_510,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_42 ON code_lists_42.code = diagnosis_active_1.code
                 AND code_lists_42.code_list_id = '2.16.840.1.113883.3.526.3.1414'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_510.so_41_procedure_performed_start_dt
                        AND so_510.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_510.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_510.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_510.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_509,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_511 WHERE dc_509.hqmf_cypress_ep_diagnosis_active_end_dt >= so_511.so_41_procedure_performed_start_dt
              AND so_511.so_41_procedure_performed_end_dt >= dc_509.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_509.hqmf_cypress_ep_diagnosis_active_start_dt <= so_511.so_41_procedure_performed_end_dt
              AND dc_509.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_511.so_41_procedure_performed_start_dt <= dc_509.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_511.so_41_procedure_performed_end_dt IS NULL
              OR dc_509.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_509.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_21
         UNION SELECT anon_22.patient_id AS patient_id,
                      anon_22.start_dt AS start_dt,
                      anon_22.end_dt AS end_dt,
                      anon_22.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_513.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_513.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_513.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_513.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_514,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_43 ON code_lists_43.code = diagnosis_active_1.code
               AND code_lists_43.code_list_id = '2.16.840.1.113883.3.526.3.1432'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_514.so_41_procedure_performed_start_dt) AS dc_513,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_515
            WHERE dc_513.hqmf_cypress_ep_diagnosis_active_start_dt < so_515.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_516.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_516.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_516.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_516.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_517,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_44 ON code_lists_44.code = diagnosis_active_1.code
                 AND code_lists_44.code_list_id = '2.16.840.1.113883.3.526.3.1432'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_517.so_41_procedure_performed_start_dt
                        AND so_517.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_517.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_517.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_517.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_516,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_518 WHERE dc_516.hqmf_cypress_ep_diagnosis_active_end_dt >= so_518.so_41_procedure_performed_start_dt
              AND so_518.so_41_procedure_performed_end_dt >= dc_516.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_516.hqmf_cypress_ep_diagnosis_active_start_dt <= so_518.so_41_procedure_performed_end_dt
              AND dc_516.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_518.so_41_procedure_performed_start_dt <= dc_516.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_518.so_41_procedure_performed_end_dt IS NULL
              OR dc_516.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_516.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_22
         UNION SELECT anon_23.patient_id AS patient_id,
                      anon_23.start_dt AS start_dt,
                      anon_23.end_dt AS end_dt,
                      anon_23.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_520.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_520.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_520.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_520.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_521,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_45 ON code_lists_45.code = diagnosis_active_1.code
               AND code_lists_45.code_list_id = '2.16.840.1.113883.3.526.3.1430'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_521.so_41_procedure_performed_start_dt) AS dc_520,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_522
            WHERE dc_520.hqmf_cypress_ep_diagnosis_active_start_dt < so_522.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_523.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_523.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_523.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_523.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_524,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_46 ON code_lists_46.code = diagnosis_active_1.code
                 AND code_lists_46.code_list_id = '2.16.840.1.113883.3.526.3.1430'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_524.so_41_procedure_performed_start_dt
                        AND so_524.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_524.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_524.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_524.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_523,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_525 WHERE dc_523.hqmf_cypress_ep_diagnosis_active_end_dt >= so_525.so_41_procedure_performed_start_dt
              AND so_525.so_41_procedure_performed_end_dt >= dc_523.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_523.hqmf_cypress_ep_diagnosis_active_start_dt <= so_525.so_41_procedure_performed_end_dt
              AND dc_523.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_525.so_41_procedure_performed_start_dt <= dc_523.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_525.so_41_procedure_performed_end_dt IS NULL
              OR dc_523.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_523.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_23
         UNION SELECT anon_24.patient_id AS patient_id,
                      anon_24.start_dt AS start_dt,
                      anon_24.end_dt AS end_dt,
                      anon_24.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_527.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_527.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_527.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_527.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_528,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_47 ON code_lists_47.code = diagnosis_active_1.code
               AND code_lists_47.code_list_id = '2.16.840.1.113883.3.526.3.1415'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_528.so_41_procedure_performed_start_dt) AS dc_527,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_529
            WHERE dc_527.hqmf_cypress_ep_diagnosis_active_start_dt < so_529.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_530.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_530.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_530.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_530.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_531,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_48 ON code_lists_48.code = diagnosis_active_1.code
                 AND code_lists_48.code_list_id = '2.16.840.1.113883.3.526.3.1415'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_531.so_41_procedure_performed_start_dt
                        AND so_531.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_531.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_531.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_531.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_530,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_532 WHERE dc_530.hqmf_cypress_ep_diagnosis_active_end_dt >= so_532.so_41_procedure_performed_start_dt
              AND so_532.so_41_procedure_performed_end_dt >= dc_530.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_530.hqmf_cypress_ep_diagnosis_active_start_dt <= so_532.so_41_procedure_performed_end_dt
              AND dc_530.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_532.so_41_procedure_performed_start_dt <= dc_530.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_532.so_41_procedure_performed_end_dt IS NULL
              OR dc_530.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_530.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_24
         UNION SELECT anon_25.patient_id AS patient_id,
                      anon_25.start_dt AS start_dt,
                      anon_25.end_dt AS end_dt,
                      anon_25.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_534.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_534.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_534.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_534.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_535,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_49 ON code_lists_49.code = diagnosis_active_1.code
               AND code_lists_49.code_list_id = '2.16.840.1.113883.3.526.3.1445'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_535.so_41_procedure_performed_start_dt) AS dc_534,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_536
            WHERE dc_534.hqmf_cypress_ep_diagnosis_active_start_dt < so_536.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_537.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_537.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_537.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_537.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_538,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_50 ON code_lists_50.code = diagnosis_active_1.code
                 AND code_lists_50.code_list_id = '2.16.840.1.113883.3.526.3.1445'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_538.so_41_procedure_performed_start_dt
                        AND so_538.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_538.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_538.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_538.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_537,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_539 WHERE dc_537.hqmf_cypress_ep_diagnosis_active_end_dt >= so_539.so_41_procedure_performed_start_dt
              AND so_539.so_41_procedure_performed_end_dt >= dc_537.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_537.hqmf_cypress_ep_diagnosis_active_start_dt <= so_539.so_41_procedure_performed_end_dt
              AND dc_537.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_539.so_41_procedure_performed_start_dt <= dc_537.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_539.so_41_procedure_performed_end_dt IS NULL
              OR dc_537.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_537.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_25
         UNION SELECT anon_26.patient_id AS patient_id,
                      anon_26.start_dt AS start_dt,
                      anon_26.end_dt AS end_dt,
                      anon_26.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_541.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_541.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_541.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_541.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_542,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_51 ON code_lists_51.code = diagnosis_active_1.code
               AND code_lists_51.code_list_id = '2.16.840.1.113883.3.526.3.1424'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_542.so_41_procedure_performed_start_dt) AS dc_541,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_543
            WHERE dc_541.hqmf_cypress_ep_diagnosis_active_start_dt < so_543.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_544.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_544.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_544.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_544.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_545,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_52 ON code_lists_52.code = diagnosis_active_1.code
                 AND code_lists_52.code_list_id = '2.16.840.1.113883.3.526.3.1424'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_545.so_41_procedure_performed_start_dt
                        AND so_545.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_545.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_545.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_545.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_544,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_546 WHERE dc_544.hqmf_cypress_ep_diagnosis_active_end_dt >= so_546.so_41_procedure_performed_start_dt
              AND so_546.so_41_procedure_performed_end_dt >= dc_544.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_544.hqmf_cypress_ep_diagnosis_active_start_dt <= so_546.so_41_procedure_performed_end_dt
              AND dc_544.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_546.so_41_procedure_performed_start_dt <= dc_544.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_546.so_41_procedure_performed_end_dt IS NULL
              OR dc_544.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_544.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_26
         UNION SELECT anon_27.patient_id AS patient_id,
                      anon_27.start_dt AS start_dt,
                      anon_27.end_dt AS end_dt,
                      anon_27.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_548.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_548.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_548.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_548.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_549,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_53 ON code_lists_53.code = diagnosis_active_1.code
               AND code_lists_53.code_list_id = '2.16.840.1.113883.3.526.3.1421'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_549.so_41_procedure_performed_start_dt) AS dc_548,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_550
            WHERE dc_548.hqmf_cypress_ep_diagnosis_active_start_dt < so_550.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_551.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_551.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_551.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_551.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_552,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_54 ON code_lists_54.code = diagnosis_active_1.code
                 AND code_lists_54.code_list_id = '2.16.840.1.113883.3.526.3.1421'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_552.so_41_procedure_performed_start_dt
                        AND so_552.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_552.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_552.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_552.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_551,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_553 WHERE dc_551.hqmf_cypress_ep_diagnosis_active_end_dt >= so_553.so_41_procedure_performed_start_dt
              AND so_553.so_41_procedure_performed_end_dt >= dc_551.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_551.hqmf_cypress_ep_diagnosis_active_start_dt <= so_553.so_41_procedure_performed_end_dt
              AND dc_551.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_553.so_41_procedure_performed_start_dt <= dc_551.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_553.so_41_procedure_performed_end_dt IS NULL
              OR dc_551.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_551.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_27
         UNION SELECT anon_28.patient_id AS patient_id,
                      anon_28.start_dt AS start_dt,
                      anon_28.end_dt AS end_dt,
                      anon_28.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_555.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_555.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_555.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_555.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_556,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_55 ON code_lists_55.code = diagnosis_active_1.code
               AND code_lists_55.code_list_id = '2.16.840.1.113883.3.526.3.1444'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_556.so_41_procedure_performed_start_dt) AS dc_555,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_557
            WHERE dc_555.hqmf_cypress_ep_diagnosis_active_start_dt < so_557.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_558.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_558.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_558.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_558.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_559,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_56 ON code_lists_56.code = diagnosis_active_1.code
                 AND code_lists_56.code_list_id = '2.16.840.1.113883.3.526.3.1444'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_559.so_41_procedure_performed_start_dt
                        AND so_559.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_559.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_559.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_559.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_558,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_560 WHERE dc_558.hqmf_cypress_ep_diagnosis_active_end_dt >= so_560.so_41_procedure_performed_start_dt
              AND so_560.so_41_procedure_performed_end_dt >= dc_558.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_558.hqmf_cypress_ep_diagnosis_active_start_dt <= so_560.so_41_procedure_performed_end_dt
              AND dc_558.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_560.so_41_procedure_performed_start_dt <= dc_558.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_560.so_41_procedure_performed_end_dt IS NULL
              OR dc_558.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_558.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_28
         UNION SELECT anon_29.patient_id AS patient_id,
                      anon_29.start_dt AS start_dt,
                      anon_29.end_dt AS end_dt,
                      anon_29.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_562.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_562.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_562.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_562.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_563,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_57 ON code_lists_57.code = diagnosis_active_1.code
               AND code_lists_57.code_list_id = '2.16.840.1.113883.3.526.3.1416'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_563.so_41_procedure_performed_start_dt) AS dc_562,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_564
            WHERE dc_562.hqmf_cypress_ep_diagnosis_active_start_dt < so_564.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_565.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_565.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_565.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_565.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_566,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_58 ON code_lists_58.code = diagnosis_active_1.code
                 AND code_lists_58.code_list_id = '2.16.840.1.113883.3.526.3.1416'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_566.so_41_procedure_performed_start_dt
                        AND so_566.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_566.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_566.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_566.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_565,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_567 WHERE dc_565.hqmf_cypress_ep_diagnosis_active_end_dt >= so_567.so_41_procedure_performed_start_dt
              AND so_567.so_41_procedure_performed_end_dt >= dc_565.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_565.hqmf_cypress_ep_diagnosis_active_start_dt <= so_567.so_41_procedure_performed_end_dt
              AND dc_565.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_567.so_41_procedure_performed_start_dt <= dc_565.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_567.so_41_procedure_performed_end_dt IS NULL
              OR dc_565.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_565.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_29
         UNION SELECT anon_30.patient_id AS patient_id,
                      anon_30.start_dt AS start_dt,
                      anon_30.end_dt AS end_dt,
                      anon_30.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_569.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_569.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_569.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_569.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_570,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_59 ON code_lists_59.code = diagnosis_active_1.code
               AND code_lists_59.code_list_id = '2.16.840.1.113883.3.526.3.1419'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_570.so_41_procedure_performed_start_dt) AS dc_569,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_571
            WHERE dc_569.hqmf_cypress_ep_diagnosis_active_start_dt < so_571.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_572.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_572.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_572.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_572.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_573,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_60 ON code_lists_60.code = diagnosis_active_1.code
                 AND code_lists_60.code_list_id = '2.16.840.1.113883.3.526.3.1419'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_573.so_41_procedure_performed_start_dt
                        AND so_573.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_573.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_573.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_573.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_572,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_574 WHERE dc_572.hqmf_cypress_ep_diagnosis_active_end_dt >= so_574.so_41_procedure_performed_start_dt
              AND so_574.so_41_procedure_performed_end_dt >= dc_572.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_572.hqmf_cypress_ep_diagnosis_active_start_dt <= so_574.so_41_procedure_performed_end_dt
              AND dc_572.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_574.so_41_procedure_performed_start_dt <= dc_572.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_574.so_41_procedure_performed_end_dt IS NULL
              OR dc_572.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_572.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_30
         UNION SELECT anon_31.patient_id AS patient_id,
                      anon_31.start_dt AS start_dt,
                      anon_31.end_dt AS end_dt,
                      anon_31.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_576.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_576.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_576.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_576.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_577,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_61 ON code_lists_61.code = diagnosis_active_1.code
               AND code_lists_61.code_list_id = '2.16.840.1.113883.3.526.3.1417'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_577.so_41_procedure_performed_start_dt) AS dc_576,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_578
            WHERE dc_576.hqmf_cypress_ep_diagnosis_active_start_dt < so_578.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_579.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_579.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_579.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_579.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_580,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_62 ON code_lists_62.code = diagnosis_active_1.code
                 AND code_lists_62.code_list_id = '2.16.840.1.113883.3.526.3.1417'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_580.so_41_procedure_performed_start_dt
                        AND so_580.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_580.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_580.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_580.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_579,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_581 WHERE dc_579.hqmf_cypress_ep_diagnosis_active_end_dt >= so_581.so_41_procedure_performed_start_dt
              AND so_581.so_41_procedure_performed_end_dt >= dc_579.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_579.hqmf_cypress_ep_diagnosis_active_start_dt <= so_581.so_41_procedure_performed_end_dt
              AND dc_579.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_581.so_41_procedure_performed_start_dt <= dc_579.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_581.so_41_procedure_performed_end_dt IS NULL
              OR dc_579.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_579.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_31
         UNION SELECT anon_32.patient_id AS patient_id,
                      anon_32.start_dt AS start_dt,
                      anon_32.end_dt AS end_dt,
                      anon_32.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_583.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_583.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_583.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_583.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_584,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_63 ON code_lists_63.code = diagnosis_active_1.code
               AND code_lists_63.code_list_id = '2.16.840.1.113883.3.526.3.1433'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_584.so_41_procedure_performed_start_dt) AS dc_583,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_585
            WHERE dc_583.hqmf_cypress_ep_diagnosis_active_start_dt < so_585.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_586.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_586.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_586.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_586.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_587,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_64 ON code_lists_64.code = diagnosis_active_1.code
                 AND code_lists_64.code_list_id = '2.16.840.1.113883.3.526.3.1433'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_587.so_41_procedure_performed_start_dt
                        AND so_587.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_587.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_587.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_587.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_586,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_588 WHERE dc_586.hqmf_cypress_ep_diagnosis_active_end_dt >= so_588.so_41_procedure_performed_start_dt
              AND so_588.so_41_procedure_performed_end_dt >= dc_586.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_586.hqmf_cypress_ep_diagnosis_active_start_dt <= so_588.so_41_procedure_performed_end_dt
              AND dc_586.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_588.so_41_procedure_performed_start_dt <= dc_586.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_588.so_41_procedure_performed_end_dt IS NULL
              OR dc_586.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_586.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_32
         UNION SELECT anon_33.patient_id AS patient_id,
                      anon_33.start_dt AS start_dt,
                      anon_33.end_dt AS end_dt,
                      anon_33.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_590.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_590.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_590.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_590.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_591,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_65 ON code_lists_65.code = diagnosis_active_1.code
               AND code_lists_65.code_list_id = '2.16.840.1.113883.3.526.3.1407'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_591.so_41_procedure_performed_start_dt) AS dc_590,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_592
            WHERE dc_590.hqmf_cypress_ep_diagnosis_active_start_dt < so_592.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_593.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_593.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_593.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_593.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_594,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_66 ON code_lists_66.code = diagnosis_active_1.code
                 AND code_lists_66.code_list_id = '2.16.840.1.113883.3.526.3.1407'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_594.so_41_procedure_performed_start_dt
                        AND so_594.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_594.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_594.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_594.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_593,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_595 WHERE dc_593.hqmf_cypress_ep_diagnosis_active_end_dt >= so_595.so_41_procedure_performed_start_dt
              AND so_595.so_41_procedure_performed_end_dt >= dc_593.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_593.hqmf_cypress_ep_diagnosis_active_start_dt <= so_595.so_41_procedure_performed_end_dt
              AND dc_593.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_595.so_41_procedure_performed_start_dt <= dc_593.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_595.so_41_procedure_performed_end_dt IS NULL
              OR dc_593.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_593.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_33
         UNION SELECT anon_34.patient_id AS patient_id,
                      anon_34.start_dt AS start_dt,
                      anon_34.end_dt AS end_dt,
                      anon_34.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_597.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_597.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_597.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_597.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_598,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_67 ON code_lists_67.code = diagnosis_active_1.code
               AND code_lists_67.code_list_id = '2.16.840.1.113883.3.526.3.1418'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_598.so_41_procedure_performed_start_dt) AS dc_597,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_599
            WHERE dc_597.hqmf_cypress_ep_diagnosis_active_start_dt < so_599.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_600.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_600.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_600.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_600.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_601,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_68 ON code_lists_68.code = diagnosis_active_1.code
                 AND code_lists_68.code_list_id = '2.16.840.1.113883.3.526.3.1418'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_601.so_41_procedure_performed_start_dt
                        AND so_601.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_601.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_601.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_601.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_600,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_602 WHERE dc_600.hqmf_cypress_ep_diagnosis_active_end_dt >= so_602.so_41_procedure_performed_start_dt
              AND so_602.so_41_procedure_performed_end_dt >= dc_600.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_600.hqmf_cypress_ep_diagnosis_active_start_dt <= so_602.so_41_procedure_performed_end_dt
              AND dc_600.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_602.so_41_procedure_performed_start_dt <= dc_600.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_602.so_41_procedure_performed_end_dt IS NULL
              OR dc_600.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_600.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_34
         UNION SELECT anon_35.patient_id AS patient_id,
                      anon_35.start_dt AS start_dt,
                      anon_35.end_dt AS end_dt,
                      anon_35.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_604.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_604.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_604.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_604.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_605,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_69 ON code_lists_69.code = diagnosis_active_1.code
               AND code_lists_69.code_list_id = '2.16.840.1.113883.3.526.3.1438'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_605.so_41_procedure_performed_start_dt) AS dc_604,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_606
            WHERE dc_604.hqmf_cypress_ep_diagnosis_active_start_dt < so_606.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_607.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_607.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_607.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_607.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_608,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_70 ON code_lists_70.code = diagnosis_active_1.code
                 AND code_lists_70.code_list_id = '2.16.840.1.113883.3.526.3.1438'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_608.so_41_procedure_performed_start_dt
                        AND so_608.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_608.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_608.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_608.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_607,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_609 WHERE dc_607.hqmf_cypress_ep_diagnosis_active_end_dt >= so_609.so_41_procedure_performed_start_dt
              AND so_609.so_41_procedure_performed_end_dt >= dc_607.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_607.hqmf_cypress_ep_diagnosis_active_start_dt <= so_609.so_41_procedure_performed_end_dt
              AND dc_607.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_609.so_41_procedure_performed_start_dt <= dc_607.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_609.so_41_procedure_performed_end_dt IS NULL
              OR dc_607.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_607.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_35
         UNION SELECT anon_36.patient_id AS patient_id,
                      anon_36.start_dt AS start_dt,
                      anon_36.end_dt AS end_dt,
                      anon_36.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_611.hqmf_cypress_ep_medication_active_patient_id AS patient_id,
                   dc_611.hqmf_cypress_ep_medication_active_start_dt AS start_dt,
                   dc_611.hqmf_cypress_ep_medication_active_end_dt AS end_dt,
                   dc_611.hqmf_cypress_ep_medication_active_audit_key_value AS audit_key_value
            FROM
              (SELECT medication_active_1.patient_id AS hqmf_cypress_ep_medication_active_patient_id,
                      medication_active_1.start_dt AS hqmf_cypress_ep_medication_active_start_dt,
                      medication_active_1.end_dt AS hqmf_cypress_ep_medication_active_end_dt,
                      medication_active_1.audit_key_value AS hqmf_cypress_ep_medication_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_612,
                    hqmf_test.medication_active AS medication_active_1
               JOIN
               valuesets.code_lists AS code_lists_71 ON code_lists_71.code = medication_active_1.code
               AND code_lists_71.code_list_id = '2.16.840.1.113883.3.526.3.1442'
               WHERE medication_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(medication_active_1.negation AS BIT) IS NULL
                      OR CAST(medication_active_1.negation AS BIT) = 0)
                 AND medication_active_1.start_dt < so_612.so_41_procedure_performed_start_dt) AS dc_611,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_613
            WHERE dc_611.hqmf_cypress_ep_medication_active_start_dt < so_613.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_614.hqmf_cypress_ep_medication_active_patient_id AS patient_id,
                     dc_614.hqmf_cypress_ep_medication_active_start_dt AS start_dt,
                     dc_614.hqmf_cypress_ep_medication_active_end_dt AS end_dt,
                     dc_614.hqmf_cypress_ep_medication_active_audit_key_value AS audit_key_value
              FROM
                (SELECT medication_active_1.patient_id AS hqmf_cypress_ep_medication_active_patient_id,
                        medication_active_1.start_dt AS hqmf_cypress_ep_medication_active_start_dt,
                        medication_active_1.end_dt AS hqmf_cypress_ep_medication_active_end_dt,
                        medication_active_1.audit_key_value AS hqmf_cypress_ep_medication_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_615,
                      hqmf_test.medication_active AS medication_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_72 ON code_lists_72.code = medication_active_1.code
                 AND code_lists_72.code_list_id = '2.16.840.1.113883.3.526.3.1442'
                 WHERE medication_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(medication_active_1.negation AS BIT) IS NULL
                        OR CAST(medication_active_1.negation AS BIT) = 0)
                   AND (medication_active_1.end_dt >= so_615.so_41_procedure_performed_start_dt
                        AND so_615.so_41_procedure_performed_end_dt >= medication_active_1.start_dt
                        OR medication_active_1.start_dt <= so_615.so_41_procedure_performed_end_dt
                        AND medication_active_1.end_dt IS NULL
                        OR so_615.so_41_procedure_performed_start_dt <= medication_active_1.end_dt
                        AND so_615.so_41_procedure_performed_end_dt IS NULL
                        OR medication_active_1.start_dt IS NULL
                        AND medication_active_1.end_dt IS NULL)) AS dc_614,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_616 WHERE dc_614.hqmf_cypress_ep_medication_active_end_dt >= so_616.so_41_procedure_performed_start_dt
              AND so_616.so_41_procedure_performed_end_dt >= dc_614.hqmf_cypress_ep_medication_active_start_dt
              OR dc_614.hqmf_cypress_ep_medication_active_start_dt <= so_616.so_41_procedure_performed_end_dt
              AND dc_614.hqmf_cypress_ep_medication_active_end_dt IS NULL
              OR so_616.so_41_procedure_performed_start_dt <= dc_614.hqmf_cypress_ep_medication_active_end_dt
              AND so_616.so_41_procedure_performed_end_dt IS NULL
              OR dc_614.hqmf_cypress_ep_medication_active_start_dt IS NULL
              AND dc_614.hqmf_cypress_ep_medication_active_end_dt IS NULL) AS anon_36
         UNION SELECT anon_37.patient_id AS patient_id,
                      anon_37.start_dt AS start_dt,
                      anon_37.end_dt AS end_dt,
                      anon_37.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_618.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_618.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_618.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_618.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                         so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                         so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                         so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                  FROM so_41_procedure_performed
                  WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_619,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_73 ON code_lists_73.code = diagnosis_active_1.code
               AND code_lists_73.code_list_id = '2.16.840.1.113883.3.526.3.1406'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_619.so_41_procedure_performed_start_dt) AS dc_618,

              (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                      so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                      so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                      so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
               FROM so_41_procedure_performed
               WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_620
            WHERE dc_618.hqmf_cypress_ep_diagnosis_active_start_dt < so_620.so_41_procedure_performed_start_dt INTERSECT
              SELECT dc_621.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_621.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_621.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_621.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                           so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                           so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                           so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                    FROM so_41_procedure_performed
                    WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_622,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_74 ON code_lists_74.code = diagnosis_active_1.code
                 AND code_lists_74.code_list_id = '2.16.840.1.113883.3.526.3.1406'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_622.so_41_procedure_performed_start_dt
                        AND so_622.so_41_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_622.so_41_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_622.so_41_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_622.so_41_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_621,

                (SELECT so_41_procedure_performed.so_41_procedure_performed_patient_id AS so_41_procedure_performed_patient_id,
                        so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
                        so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt,
                        so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value
                 FROM so_41_procedure_performed
                 WHERE so_41_procedure_performed.so_41_procedure_performed_audit_key_value = patient_base.so_41_procedure_performed_audit_key_value) AS so_623 WHERE dc_621.hqmf_cypress_ep_diagnosis_active_end_dt >= so_623.so_41_procedure_performed_start_dt
              AND so_623.so_41_procedure_performed_end_dt >= dc_621.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_621.hqmf_cypress_ep_diagnosis_active_start_dt <= so_623.so_41_procedure_performed_end_dt
              AND dc_621.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_623.so_41_procedure_performed_start_dt <= dc_621.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_623.so_41_procedure_performed_end_dt IS NULL
              OR dc_621.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_621.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_37) AS anon_5) 
			  THEN cast( 1 as bit) 
				ELSE cast(0 as bit)
				END AS anon_4) AS [denominatorExclusions]
FROM
  (SELECT base_patients.patient_id AS base_patient_id,
          so_41_procedure_performed.so_41_procedure_performed_audit_key_value AS so_41_procedure_performed_audit_key_value,
          so_41_procedure_performed.so_41_procedure_performed_start_dt AS so_41_procedure_performed_start_dt,
          so_41_procedure_performed.so_41_procedure_performed_end_dt AS so_41_procedure_performed_end_dt
   FROM hqmf_test.patients AS base_patients
   LEFT OUTER JOIN so_41_procedure_performed ON so_41_procedure_performed.so_41_procedure_performed_patient_id = base_patients.patient_id) AS patient_base;

CREATE TABLE results.measure_132_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)


;

INSERT INTO results.measure_132_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, [initialPopulation] AS effective_denom, [initialPopulation] & [denominatorExclusions] AS effective_denex, [initialPopulation] &~ ([initialPopulation] & [denominatorExclusions]) & numerator AS effective_numer, CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & [denominatorExclusions]) DESC, ([initialPopulation] &~ ([initialPopulation] & [denominatorExclusions]) & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_132_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

