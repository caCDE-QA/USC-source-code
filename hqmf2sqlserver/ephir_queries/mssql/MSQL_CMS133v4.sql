--set search_path = results;
create view results.measure_133_0_all as WITH so_4_procedure_performed 
AS
  (SELECT procedure_performed_1.patient_id AS so_4_procedure_performed_patient_id,
          procedure_performed_1.audit_key_value AS so_4_procedure_performed_audit_key_value,
          procedure_performed_1.start_dt AS so_4_procedure_performed_start_dt,
          procedure_performed_1.end_dt AS so_4_procedure_performed_end_dt
   FROM hqmf_test.procedure_performed AS procedure_performed_1
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = procedure_performed_1.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1411'
   WHERE CAST(procedure_performed_1.negation AS BIT) IS NULL
     OR CAST(procedure_performed_1.negation AS BIT) = 0)
SELECT patient_base.base_patient_id,
       patient_base.so_4_procedure_performed_audit_key_value,
       patient_base.so_4_procedure_performed_start_dt,
       patient_base.so_4_procedure_performed_end_dt,

  (SELECT CASE WHEN EXISTS
     (SELECT anon_2.patient_id,
             anon_2.start_dt,
             anon_2.end_dt,
             anon_2.audit_key_value
      FROM
        (SELECT anon_3.patient_id AS patient_id,
                anon_3.start_dt AS start_dt,
                anon_3.end_dt AS end_dt,
                anon_3.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_577.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_577.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_577.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_577.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_578,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_2 ON code_lists_2.code = diagnosis_active_1.code
               AND code_lists_2.code_list_id = '2.16.840.1.113883.3.526.3.1241'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_578.so_4_procedure_performed_start_dt) AS dc_577,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_579
            WHERE dc_577.hqmf_cypress_ep_diagnosis_active_start_dt < so_579.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_580.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_580.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_580.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_580.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_581,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_3 ON code_lists_3.code = diagnosis_active_1.code
                 AND code_lists_3.code_list_id = '2.16.840.1.113883.3.526.3.1241'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_581.so_4_procedure_performed_start_dt
                        AND so_581.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_581.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_581.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_581.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_580,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_582 WHERE dc_580.hqmf_cypress_ep_diagnosis_active_end_dt >= so_582.so_4_procedure_performed_start_dt
              AND so_582.so_4_procedure_performed_end_dt >= dc_580.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_580.hqmf_cypress_ep_diagnosis_active_start_dt <= so_582.so_4_procedure_performed_end_dt
              AND dc_580.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_582.so_4_procedure_performed_start_dt <= dc_580.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_582.so_4_procedure_performed_end_dt IS NULL
              OR dc_580.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_580.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_3
         UNION SELECT anon_4.patient_id AS patient_id,
                      anon_4.start_dt AS start_dt,
                      anon_4.end_dt AS end_dt,
                      anon_4.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_584.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_584.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_584.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_584.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_585,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_4 ON code_lists_4.code = diagnosis_active_1.code
               AND code_lists_4.code_list_id = '2.16.840.1.113883.3.526.3.1432'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_585.so_4_procedure_performed_start_dt) AS dc_584,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_586
            WHERE dc_584.hqmf_cypress_ep_diagnosis_active_start_dt < so_586.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_587.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_587.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_587.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_587.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_588,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_5 ON code_lists_5.code = diagnosis_active_1.code
                 AND code_lists_5.code_list_id = '2.16.840.1.113883.3.526.3.1432'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_588.so_4_procedure_performed_start_dt
                        AND so_588.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_588.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_588.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_588.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_587,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_589 WHERE dc_587.hqmf_cypress_ep_diagnosis_active_end_dt >= so_589.so_4_procedure_performed_start_dt
              AND so_589.so_4_procedure_performed_end_dt >= dc_587.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_587.hqmf_cypress_ep_diagnosis_active_start_dt <= so_589.so_4_procedure_performed_end_dt
              AND dc_587.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_589.so_4_procedure_performed_start_dt <= dc_587.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_589.so_4_procedure_performed_end_dt IS NULL
              OR dc_587.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_587.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_4
         UNION SELECT anon_5.patient_id AS patient_id,
                      anon_5.start_dt AS start_dt,
                      anon_5.end_dt AS end_dt,
                      anon_5.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_591.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_591.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_591.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_591.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_592,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_6 ON code_lists_6.code = diagnosis_active_1.code
               AND code_lists_6.code_list_id = '2.16.840.1.113883.3.526.3.1478'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_592.so_4_procedure_performed_start_dt) AS dc_591,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_593
            WHERE dc_591.hqmf_cypress_ep_diagnosis_active_start_dt < so_593.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_594.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_594.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_594.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_594.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_595,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_7 ON code_lists_7.code = diagnosis_active_1.code
                 AND code_lists_7.code_list_id = '2.16.840.1.113883.3.526.3.1478'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_595.so_4_procedure_performed_start_dt
                        AND so_595.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_595.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_595.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_595.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_594,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_596 WHERE dc_594.hqmf_cypress_ep_diagnosis_active_end_dt >= so_596.so_4_procedure_performed_start_dt
              AND so_596.so_4_procedure_performed_end_dt >= dc_594.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_594.hqmf_cypress_ep_diagnosis_active_start_dt <= so_596.so_4_procedure_performed_end_dt
              AND dc_594.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_596.so_4_procedure_performed_start_dt <= dc_594.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_596.so_4_procedure_performed_end_dt IS NULL
              OR dc_594.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_594.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_5
         UNION SELECT anon_6.patient_id AS patient_id,
                      anon_6.start_dt AS start_dt,
                      anon_6.end_dt AS end_dt,
                      anon_6.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_598.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_598.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_598.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_598.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_599,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_8 ON code_lists_8.code = diagnosis_active_1.code
               AND code_lists_8.code_list_id = '2.16.840.1.113883.3.526.3.1479'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_599.so_4_procedure_performed_start_dt) AS dc_598,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_600
            WHERE dc_598.hqmf_cypress_ep_diagnosis_active_start_dt < so_600.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_601.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_601.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_601.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_601.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_602,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_9 ON code_lists_9.code = diagnosis_active_1.code
                 AND code_lists_9.code_list_id = '2.16.840.1.113883.3.526.3.1479'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_602.so_4_procedure_performed_start_dt
                        AND so_602.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_602.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_602.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_602.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_601,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_603 WHERE dc_601.hqmf_cypress_ep_diagnosis_active_end_dt >= so_603.so_4_procedure_performed_start_dt
              AND so_603.so_4_procedure_performed_end_dt >= dc_601.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_601.hqmf_cypress_ep_diagnosis_active_start_dt <= so_603.so_4_procedure_performed_end_dt
              AND dc_601.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_603.so_4_procedure_performed_start_dt <= dc_601.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_603.so_4_procedure_performed_end_dt IS NULL
              OR dc_601.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_601.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_6
         UNION SELECT anon_7.patient_id AS patient_id,
                      anon_7.start_dt AS start_dt,
                      anon_7.end_dt AS end_dt,
                      anon_7.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_605.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_605.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_605.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_605.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_606,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_10 ON code_lists_10.code = diagnosis_active_1.code
               AND code_lists_10.code_list_id = '2.16.840.1.113883.3.526.3.1477'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_606.so_4_procedure_performed_start_dt) AS dc_605,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_607
            WHERE dc_605.hqmf_cypress_ep_diagnosis_active_start_dt < so_607.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_608.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_608.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_608.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_608.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_609,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_11 ON code_lists_11.code = diagnosis_active_1.code
                 AND code_lists_11.code_list_id = '2.16.840.1.113883.3.526.3.1477'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_609.so_4_procedure_performed_start_dt
                        AND so_609.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_609.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_609.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_609.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_608,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_610 WHERE dc_608.hqmf_cypress_ep_diagnosis_active_end_dt >= so_610.so_4_procedure_performed_start_dt
              AND so_610.so_4_procedure_performed_end_dt >= dc_608.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_608.hqmf_cypress_ep_diagnosis_active_start_dt <= so_610.so_4_procedure_performed_end_dt
              AND dc_608.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_610.so_4_procedure_performed_start_dt <= dc_608.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_610.so_4_procedure_performed_end_dt IS NULL
              OR dc_608.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_608.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_7
         UNION SELECT anon_8.patient_id AS patient_id,
                      anon_8.start_dt AS start_dt,
                      anon_8.end_dt AS end_dt,
                      anon_8.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_612.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_612.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_612.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_612.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_613,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_12 ON code_lists_12.code = diagnosis_active_1.code
               AND code_lists_12.code_list_id = '2.16.840.1.113883.3.526.3.1415'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_613.so_4_procedure_performed_start_dt) AS dc_612,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_614
            WHERE dc_612.hqmf_cypress_ep_diagnosis_active_start_dt < so_614.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_615.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_615.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_615.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_615.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_616,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_13 ON code_lists_13.code = diagnosis_active_1.code
                 AND code_lists_13.code_list_id = '2.16.840.1.113883.3.526.3.1415'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_616.so_4_procedure_performed_start_dt
                        AND so_616.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_616.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_616.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_616.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_615,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_617 WHERE dc_615.hqmf_cypress_ep_diagnosis_active_end_dt >= so_617.so_4_procedure_performed_start_dt
              AND so_617.so_4_procedure_performed_end_dt >= dc_615.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_615.hqmf_cypress_ep_diagnosis_active_start_dt <= so_617.so_4_procedure_performed_end_dt
              AND dc_615.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_617.so_4_procedure_performed_start_dt <= dc_615.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_617.so_4_procedure_performed_end_dt IS NULL
              OR dc_615.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_615.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_8
         UNION SELECT anon_9.patient_id AS patient_id,
                      anon_9.start_dt AS start_dt,
                      anon_9.end_dt AS end_dt,
                      anon_9.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_619.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_619.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_619.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_619.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_620,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_14 ON code_lists_14.code = diagnosis_active_1.code
               AND code_lists_14.code_list_id = '2.16.840.1.113883.3.526.3.1461'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_620.so_4_procedure_performed_start_dt) AS dc_619,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_621
            WHERE dc_619.hqmf_cypress_ep_diagnosis_active_start_dt < so_621.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_622.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_622.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_622.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_622.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_623,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_15 ON code_lists_15.code = diagnosis_active_1.code
                 AND code_lists_15.code_list_id = '2.16.840.1.113883.3.526.3.1461'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_623.so_4_procedure_performed_start_dt
                        AND so_623.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_623.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_623.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_623.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_622,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_624 WHERE dc_622.hqmf_cypress_ep_diagnosis_active_end_dt >= so_624.so_4_procedure_performed_start_dt
              AND so_624.so_4_procedure_performed_end_dt >= dc_622.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_622.hqmf_cypress_ep_diagnosis_active_start_dt <= so_624.so_4_procedure_performed_end_dt
              AND dc_622.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_624.so_4_procedure_performed_start_dt <= dc_622.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_624.so_4_procedure_performed_end_dt IS NULL
              OR dc_622.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_622.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_9
         UNION SELECT anon_10.patient_id AS patient_id,
                      anon_10.start_dt AS start_dt,
                      anon_10.end_dt AS end_dt,
                      anon_10.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_626.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_626.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_626.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_626.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_627,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_16 ON code_lists_16.code = diagnosis_active_1.code
               AND code_lists_16.code_list_id = '2.16.840.1.113883.3.526.3.1416'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_627.so_4_procedure_performed_start_dt) AS dc_626,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_628
            WHERE dc_626.hqmf_cypress_ep_diagnosis_active_start_dt < so_628.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_629.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_629.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_629.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_629.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_630,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_17 ON code_lists_17.code = diagnosis_active_1.code
                 AND code_lists_17.code_list_id = '2.16.840.1.113883.3.526.3.1416'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_630.so_4_procedure_performed_start_dt
                        AND so_630.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_630.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_630.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_630.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_629,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_631 WHERE dc_629.hqmf_cypress_ep_diagnosis_active_end_dt >= so_631.so_4_procedure_performed_start_dt
              AND so_631.so_4_procedure_performed_end_dt >= dc_629.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_629.hqmf_cypress_ep_diagnosis_active_start_dt <= so_631.so_4_procedure_performed_end_dt
              AND dc_629.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_631.so_4_procedure_performed_start_dt <= dc_629.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_631.so_4_procedure_performed_end_dt IS NULL
              OR dc_629.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_629.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_10
         UNION SELECT anon_11.patient_id AS patient_id,
                      anon_11.start_dt AS start_dt,
                      anon_11.end_dt AS end_dt,
                      anon_11.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_633.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_633.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_633.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_633.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_634,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_18 ON code_lists_18.code = diagnosis_active_1.code
               AND code_lists_18.code_list_id = '2.16.840.1.113883.3.526.3.1450'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_634.so_4_procedure_performed_start_dt) AS dc_633,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_635
            WHERE dc_633.hqmf_cypress_ep_diagnosis_active_start_dt < so_635.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_636.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_636.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_636.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_636.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_637,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_19 ON code_lists_19.code = diagnosis_active_1.code
                 AND code_lists_19.code_list_id = '2.16.840.1.113883.3.526.3.1450'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_637.so_4_procedure_performed_start_dt
                        AND so_637.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_637.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_637.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_637.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_636,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_638 WHERE dc_636.hqmf_cypress_ep_diagnosis_active_end_dt >= so_638.so_4_procedure_performed_start_dt
              AND so_638.so_4_procedure_performed_end_dt >= dc_636.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_636.hqmf_cypress_ep_diagnosis_active_start_dt <= so_638.so_4_procedure_performed_end_dt
              AND dc_636.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_638.so_4_procedure_performed_start_dt <= dc_636.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_638.so_4_procedure_performed_end_dt IS NULL
              OR dc_636.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_636.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_11
         UNION SELECT anon_12.patient_id AS patient_id,
                      anon_12.start_dt AS start_dt,
                      anon_12.end_dt AS end_dt,
                      anon_12.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_640.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_640.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_640.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_640.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_641,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_20 ON code_lists_20.code = diagnosis_active_1.code
               AND code_lists_20.code_list_id = '2.16.840.1.113883.3.526.3.1467'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_641.so_4_procedure_performed_start_dt) AS dc_640,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_642
            WHERE dc_640.hqmf_cypress_ep_diagnosis_active_start_dt < so_642.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_643.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_643.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_643.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_643.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_644,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_21 ON code_lists_21.code = diagnosis_active_1.code
                 AND code_lists_21.code_list_id = '2.16.840.1.113883.3.526.3.1467'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_644.so_4_procedure_performed_start_dt
                        AND so_644.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_644.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_644.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_644.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_643,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_645 WHERE dc_643.hqmf_cypress_ep_diagnosis_active_end_dt >= so_645.so_4_procedure_performed_start_dt
              AND so_645.so_4_procedure_performed_end_dt >= dc_643.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_643.hqmf_cypress_ep_diagnosis_active_start_dt <= so_645.so_4_procedure_performed_end_dt
              AND dc_643.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_645.so_4_procedure_performed_start_dt <= dc_643.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_645.so_4_procedure_performed_end_dt IS NULL
              OR dc_643.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_643.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_12
         UNION SELECT anon_13.patient_id AS patient_id,
                      anon_13.start_dt AS start_dt,
                      anon_13.end_dt AS end_dt,
                      anon_13.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_647.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_647.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_647.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_647.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_648,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_22 ON code_lists_22.code = diagnosis_active_1.code
               AND code_lists_22.code_list_id = '2.16.840.1.113883.3.526.3.1469'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_648.so_4_procedure_performed_start_dt) AS dc_647,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_649
            WHERE dc_647.hqmf_cypress_ep_diagnosis_active_start_dt < so_649.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_650.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_650.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_650.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_650.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_651,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_23 ON code_lists_23.code = diagnosis_active_1.code
                 AND code_lists_23.code_list_id = '2.16.840.1.113883.3.526.3.1469'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_651.so_4_procedure_performed_start_dt
                        AND so_651.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_651.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_651.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_651.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_650,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_652 WHERE dc_650.hqmf_cypress_ep_diagnosis_active_end_dt >= so_652.so_4_procedure_performed_start_dt
              AND so_652.so_4_procedure_performed_end_dt >= dc_650.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_650.hqmf_cypress_ep_diagnosis_active_start_dt <= so_652.so_4_procedure_performed_end_dt
              AND dc_650.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_652.so_4_procedure_performed_start_dt <= dc_650.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_652.so_4_procedure_performed_end_dt IS NULL
              OR dc_650.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_650.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_13
         UNION SELECT anon_14.patient_id AS patient_id,
                      anon_14.start_dt AS start_dt,
                      anon_14.end_dt AS end_dt,
                      anon_14.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_654.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_654.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_654.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_654.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_655,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_24 ON code_lists_24.code = diagnosis_active_1.code
               AND code_lists_24.code_list_id = '2.16.840.1.113883.3.526.3.1470'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_655.so_4_procedure_performed_start_dt) AS dc_654,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_656
            WHERE dc_654.hqmf_cypress_ep_diagnosis_active_start_dt < so_656.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_657.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_657.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_657.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_657.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_658,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_25 ON code_lists_25.code = diagnosis_active_1.code
                 AND code_lists_25.code_list_id = '2.16.840.1.113883.3.526.3.1470'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_658.so_4_procedure_performed_start_dt
                        AND so_658.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_658.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_658.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_658.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_657,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_659 WHERE dc_657.hqmf_cypress_ep_diagnosis_active_end_dt >= so_659.so_4_procedure_performed_start_dt
              AND so_659.so_4_procedure_performed_end_dt >= dc_657.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_657.hqmf_cypress_ep_diagnosis_active_start_dt <= so_659.so_4_procedure_performed_end_dt
              AND dc_657.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_659.so_4_procedure_performed_start_dt <= dc_657.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_659.so_4_procedure_performed_end_dt IS NULL
              OR dc_657.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_657.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_14
         UNION SELECT anon_15.patient_id AS patient_id,
                      anon_15.start_dt AS start_dt,
                      anon_15.end_dt AS end_dt,
                      anon_15.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_661.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_661.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_661.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_661.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_662,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_26 ON code_lists_26.code = diagnosis_active_1.code
               AND code_lists_26.code_list_id = '2.16.840.1.113883.3.526.3.1417'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_662.so_4_procedure_performed_start_dt) AS dc_661,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_663
            WHERE dc_661.hqmf_cypress_ep_diagnosis_active_start_dt < so_663.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_664.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_664.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_664.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_664.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_665,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_27 ON code_lists_27.code = diagnosis_active_1.code
                 AND code_lists_27.code_list_id = '2.16.840.1.113883.3.526.3.1417'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_665.so_4_procedure_performed_start_dt
                        AND so_665.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_665.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_665.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_665.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_664,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_666 WHERE dc_664.hqmf_cypress_ep_diagnosis_active_end_dt >= so_666.so_4_procedure_performed_start_dt
              AND so_666.so_4_procedure_performed_end_dt >= dc_664.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_664.hqmf_cypress_ep_diagnosis_active_start_dt <= so_666.so_4_procedure_performed_end_dt
              AND dc_664.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_666.so_4_procedure_performed_start_dt <= dc_664.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_666.so_4_procedure_performed_end_dt IS NULL
              OR dc_664.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_664.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_15
         UNION SELECT anon_16.patient_id AS patient_id,
                      anon_16.start_dt AS start_dt,
                      anon_16.end_dt AS end_dt,
                      anon_16.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_668.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_668.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_668.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_668.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_669,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_28 ON code_lists_28.code = diagnosis_active_1.code
               AND code_lists_28.code_list_id = '2.16.840.1.113883.3.526.3.1474'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_669.so_4_procedure_performed_start_dt) AS dc_668,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_670
            WHERE dc_668.hqmf_cypress_ep_diagnosis_active_start_dt < so_670.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_671.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_671.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_671.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_671.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_672,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_29 ON code_lists_29.code = diagnosis_active_1.code
                 AND code_lists_29.code_list_id = '2.16.840.1.113883.3.526.3.1474'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_672.so_4_procedure_performed_start_dt
                        AND so_672.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_672.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_672.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_672.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_671,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_673 WHERE dc_671.hqmf_cypress_ep_diagnosis_active_end_dt >= so_673.so_4_procedure_performed_start_dt
              AND so_673.so_4_procedure_performed_end_dt >= dc_671.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_671.hqmf_cypress_ep_diagnosis_active_start_dt <= so_673.so_4_procedure_performed_end_dt
              AND dc_671.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_673.so_4_procedure_performed_start_dt <= dc_671.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_673.so_4_procedure_performed_end_dt IS NULL
              OR dc_671.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_671.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_16
         UNION SELECT anon_17.patient_id AS patient_id,
                      anon_17.start_dt AS start_dt,
                      anon_17.end_dt AS end_dt,
                      anon_17.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_675.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_675.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_675.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_675.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_676,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_30 ON code_lists_30.code = diagnosis_active_1.code
               AND code_lists_30.code_list_id = '2.16.840.1.113883.3.526.3.1475'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_676.so_4_procedure_performed_start_dt) AS dc_675,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_677
            WHERE dc_675.hqmf_cypress_ep_diagnosis_active_start_dt < so_677.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_678.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_678.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_678.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_678.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_679,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_31 ON code_lists_31.code = diagnosis_active_1.code
                 AND code_lists_31.code_list_id = '2.16.840.1.113883.3.526.3.1475'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_679.so_4_procedure_performed_start_dt
                        AND so_679.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_679.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_679.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_679.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_678,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_680 WHERE dc_678.hqmf_cypress_ep_diagnosis_active_end_dt >= so_680.so_4_procedure_performed_start_dt
              AND so_680.so_4_procedure_performed_end_dt >= dc_678.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_678.hqmf_cypress_ep_diagnosis_active_start_dt <= so_680.so_4_procedure_performed_end_dt
              AND dc_678.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_680.so_4_procedure_performed_start_dt <= dc_678.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_680.so_4_procedure_performed_end_dt IS NULL
              OR dc_678.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_678.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_17
         UNION SELECT anon_18.patient_id AS patient_id,
                      anon_18.start_dt AS start_dt,
                      anon_18.end_dt AS end_dt,
                      anon_18.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_682.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_682.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_682.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_682.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_683,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_32 ON code_lists_32.code = diagnosis_active_1.code
               AND code_lists_32.code_list_id = '2.16.840.1.113883.3.526.3.1468'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_683.so_4_procedure_performed_start_dt) AS dc_682,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_684
            WHERE dc_682.hqmf_cypress_ep_diagnosis_active_start_dt < so_684.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_685.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_685.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_685.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_685.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_686,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_33 ON code_lists_33.code = diagnosis_active_1.code
                 AND code_lists_33.code_list_id = '2.16.840.1.113883.3.526.3.1468'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_686.so_4_procedure_performed_start_dt
                        AND so_686.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_686.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_686.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_686.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_685,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_687 WHERE dc_685.hqmf_cypress_ep_diagnosis_active_end_dt >= so_687.so_4_procedure_performed_start_dt
              AND so_687.so_4_procedure_performed_end_dt >= dc_685.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_685.hqmf_cypress_ep_diagnosis_active_start_dt <= so_687.so_4_procedure_performed_end_dt
              AND dc_685.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_687.so_4_procedure_performed_start_dt <= dc_685.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_687.so_4_procedure_performed_end_dt IS NULL
              OR dc_685.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_685.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_18
         UNION SELECT anon_19.patient_id AS patient_id,
                      anon_19.start_dt AS start_dt,
                      anon_19.end_dt AS end_dt,
                      anon_19.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_689.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_689.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_689.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_689.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_690,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_34 ON code_lists_34.code = diagnosis_active_1.code
               AND code_lists_34.code_list_id = '2.16.840.1.113883.3.526.3.1448'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_690.so_4_procedure_performed_start_dt) AS dc_689,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_691
            WHERE dc_689.hqmf_cypress_ep_diagnosis_active_start_dt < so_691.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_692.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_692.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_692.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_692.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_693,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_35 ON code_lists_35.code = diagnosis_active_1.code
                 AND code_lists_35.code_list_id = '2.16.840.1.113883.3.526.3.1448'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_693.so_4_procedure_performed_start_dt
                        AND so_693.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_693.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_693.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_693.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_692,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_694 WHERE dc_692.hqmf_cypress_ep_diagnosis_active_end_dt >= so_694.so_4_procedure_performed_start_dt
              AND so_694.so_4_procedure_performed_end_dt >= dc_692.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_692.hqmf_cypress_ep_diagnosis_active_start_dt <= so_694.so_4_procedure_performed_end_dt
              AND dc_692.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_694.so_4_procedure_performed_start_dt <= dc_692.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_694.so_4_procedure_performed_end_dt IS NULL
              OR dc_692.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_692.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_19
         UNION SELECT anon_20.patient_id AS patient_id,
                      anon_20.start_dt AS start_dt,
                      anon_20.end_dt AS end_dt,
                      anon_20.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_696.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_696.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_696.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_696.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_697,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_36 ON code_lists_36.code = diagnosis_active_1.code
               AND code_lists_36.code_list_id = '2.16.840.1.113883.3.526.3.1418'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_697.so_4_procedure_performed_start_dt) AS dc_696,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_698
            WHERE dc_696.hqmf_cypress_ep_diagnosis_active_start_dt < so_698.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_699.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_699.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_699.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_699.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_700,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_37 ON code_lists_37.code = diagnosis_active_1.code
                 AND code_lists_37.code_list_id = '2.16.840.1.113883.3.526.3.1418'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_700.so_4_procedure_performed_start_dt
                        AND so_700.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_700.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_700.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_700.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_699,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_701 WHERE dc_699.hqmf_cypress_ep_diagnosis_active_end_dt >= so_701.so_4_procedure_performed_start_dt
              AND so_701.so_4_procedure_performed_end_dt >= dc_699.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_699.hqmf_cypress_ep_diagnosis_active_start_dt <= so_701.so_4_procedure_performed_end_dt
              AND dc_699.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_701.so_4_procedure_performed_start_dt <= dc_699.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_701.so_4_procedure_performed_end_dt IS NULL
              OR dc_699.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_699.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_20
         UNION SELECT anon_21.patient_id AS patient_id,
                      anon_21.start_dt AS start_dt,
                      anon_21.end_dt AS end_dt,
                      anon_21.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_703.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_703.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_703.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_703.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_704,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_38 ON code_lists_38.code = diagnosis_active_1.code
               AND code_lists_38.code_list_id = '2.16.840.1.113883.3.526.3.1465'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_704.so_4_procedure_performed_start_dt) AS dc_703,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_705
            WHERE dc_703.hqmf_cypress_ep_diagnosis_active_start_dt < so_705.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_706.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_706.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_706.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_706.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_707,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_39 ON code_lists_39.code = diagnosis_active_1.code
                 AND code_lists_39.code_list_id = '2.16.840.1.113883.3.526.3.1465'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_707.so_4_procedure_performed_start_dt
                        AND so_707.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_707.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_707.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_707.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_706,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_708 WHERE dc_706.hqmf_cypress_ep_diagnosis_active_end_dt >= so_708.so_4_procedure_performed_start_dt
              AND so_708.so_4_procedure_performed_end_dt >= dc_706.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_706.hqmf_cypress_ep_diagnosis_active_start_dt <= so_708.so_4_procedure_performed_end_dt
              AND dc_706.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_708.so_4_procedure_performed_start_dt <= dc_706.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_708.so_4_procedure_performed_end_dt IS NULL
              OR dc_706.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_706.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_21
         UNION SELECT anon_22.patient_id AS patient_id,
                      anon_22.start_dt AS start_dt,
                      anon_22.end_dt AS end_dt,
                      anon_22.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_710.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_710.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_710.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_710.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_711,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_40 ON code_lists_40.code = diagnosis_active_1.code
               AND code_lists_40.code_list_id = '2.16.840.1.113883.3.526.3.1464'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_711.so_4_procedure_performed_start_dt) AS dc_710,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_712
            WHERE dc_710.hqmf_cypress_ep_diagnosis_active_start_dt < so_712.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_713.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_713.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_713.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_713.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_714,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_41 ON code_lists_41.code = diagnosis_active_1.code
                 AND code_lists_41.code_list_id = '2.16.840.1.113883.3.526.3.1464'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_714.so_4_procedure_performed_start_dt
                        AND so_714.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_714.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_714.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_714.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_713,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_715 WHERE dc_713.hqmf_cypress_ep_diagnosis_active_end_dt >= so_715.so_4_procedure_performed_start_dt
              AND so_715.so_4_procedure_performed_end_dt >= dc_713.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_713.hqmf_cypress_ep_diagnosis_active_start_dt <= so_715.so_4_procedure_performed_end_dt
              AND dc_713.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_715.so_4_procedure_performed_start_dt <= dc_713.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_715.so_4_procedure_performed_end_dt IS NULL
              OR dc_713.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_713.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_22
         UNION SELECT anon_23.patient_id AS patient_id,
                      anon_23.start_dt AS start_dt,
                      anon_23.end_dt AS end_dt,
                      anon_23.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_717.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_717.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_717.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_717.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_718,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_42 ON code_lists_42.code = diagnosis_active_1.code
               AND code_lists_42.code_list_id = '2.16.840.1.113883.3.526.3.1462'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_718.so_4_procedure_performed_start_dt) AS dc_717,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_719
            WHERE dc_717.hqmf_cypress_ep_diagnosis_active_start_dt < so_719.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_720.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_720.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_720.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_720.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_721,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_43 ON code_lists_43.code = diagnosis_active_1.code
                 AND code_lists_43.code_list_id = '2.16.840.1.113883.3.526.3.1462'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_721.so_4_procedure_performed_start_dt
                        AND so_721.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_721.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_721.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_721.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_720,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_722 WHERE dc_720.hqmf_cypress_ep_diagnosis_active_end_dt >= so_722.so_4_procedure_performed_start_dt
              AND so_722.so_4_procedure_performed_end_dt >= dc_720.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_720.hqmf_cypress_ep_diagnosis_active_start_dt <= so_722.so_4_procedure_performed_end_dt
              AND dc_720.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_722.so_4_procedure_performed_start_dt <= dc_720.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_722.so_4_procedure_performed_end_dt IS NULL
              OR dc_720.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_720.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_23
         UNION SELECT anon_24.patient_id AS patient_id,
                      anon_24.start_dt AS start_dt,
                      anon_24.end_dt AS end_dt,
                      anon_24.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_724.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_724.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_724.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_724.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_725,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_44 ON code_lists_44.code = diagnosis_active_1.code
               AND code_lists_44.code_list_id = '2.16.840.1.113883.3.526.3.1463'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_725.so_4_procedure_performed_start_dt) AS dc_724,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_726
            WHERE dc_724.hqmf_cypress_ep_diagnosis_active_start_dt < so_726.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_727.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_727.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_727.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_727.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_728,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_45 ON code_lists_45.code = diagnosis_active_1.code
                 AND code_lists_45.code_list_id = '2.16.840.1.113883.3.526.3.1463'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_728.so_4_procedure_performed_start_dt
                        AND so_728.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_728.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_728.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_728.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_727,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_729 WHERE dc_727.hqmf_cypress_ep_diagnosis_active_end_dt >= so_729.so_4_procedure_performed_start_dt
              AND so_729.so_4_procedure_performed_end_dt >= dc_727.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_727.hqmf_cypress_ep_diagnosis_active_start_dt <= so_729.so_4_procedure_performed_end_dt
              AND dc_727.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_729.so_4_procedure_performed_start_dt <= dc_727.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_729.so_4_procedure_performed_end_dt IS NULL
              OR dc_727.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_727.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_24
         UNION SELECT anon_25.patient_id AS patient_id,
                      anon_25.start_dt AS start_dt,
                      anon_25.end_dt AS end_dt,
                      anon_25.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_731.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_731.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_731.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_731.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_732,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_46 ON code_lists_46.code = diagnosis_active_1.code
               AND code_lists_46.code_list_id = '2.16.840.1.113883.3.526.3.1409'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_732.so_4_procedure_performed_start_dt) AS dc_731,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_733
            WHERE dc_731.hqmf_cypress_ep_diagnosis_active_start_dt < so_733.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_734.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_734.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_734.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_734.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_735,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_47 ON code_lists_47.code = diagnosis_active_1.code
                 AND code_lists_47.code_list_id = '2.16.840.1.113883.3.526.3.1409'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_735.so_4_procedure_performed_start_dt
                        AND so_735.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_735.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_735.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_735.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_734,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_736 WHERE dc_734.hqmf_cypress_ep_diagnosis_active_end_dt >= so_736.so_4_procedure_performed_start_dt
              AND so_736.so_4_procedure_performed_end_dt >= dc_734.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_734.hqmf_cypress_ep_diagnosis_active_start_dt <= so_736.so_4_procedure_performed_end_dt
              AND dc_734.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_736.so_4_procedure_performed_start_dt <= dc_734.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_736.so_4_procedure_performed_end_dt IS NULL
              OR dc_734.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_734.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_25
         UNION SELECT anon_26.patient_id AS patient_id,
                      anon_26.start_dt AS start_dt,
                      anon_26.end_dt AS end_dt,
                      anon_26.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_738.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_738.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_738.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_738.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_739,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_48 ON code_lists_48.code = diagnosis_active_1.code
               AND code_lists_48.code_list_id = '2.16.840.1.113883.3.526.3.1481'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_739.so_4_procedure_performed_start_dt) AS dc_738,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_740
            WHERE dc_738.hqmf_cypress_ep_diagnosis_active_start_dt < so_740.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_741.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_741.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_741.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_741.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_742,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_49 ON code_lists_49.code = diagnosis_active_1.code
                 AND code_lists_49.code_list_id = '2.16.840.1.113883.3.526.3.1481'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_742.so_4_procedure_performed_start_dt
                        AND so_742.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_742.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_742.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_742.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_741,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_743 WHERE dc_741.hqmf_cypress_ep_diagnosis_active_end_dt >= so_743.so_4_procedure_performed_start_dt
              AND so_743.so_4_procedure_performed_end_dt >= dc_741.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_741.hqmf_cypress_ep_diagnosis_active_start_dt <= so_743.so_4_procedure_performed_end_dt
              AND dc_741.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_743.so_4_procedure_performed_start_dt <= dc_741.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_743.so_4_procedure_performed_end_dt IS NULL
              OR dc_741.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_741.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_26
         UNION SELECT anon_27.patient_id AS patient_id,
                      anon_27.start_dt AS start_dt,
                      anon_27.end_dt AS end_dt,
                      anon_27.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_745.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_745.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_745.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_745.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_746,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_50 ON code_lists_50.code = diagnosis_active_1.code
               AND code_lists_50.code_list_id = '2.16.840.1.113883.3.526.3.1472'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_746.so_4_procedure_performed_start_dt) AS dc_745,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_747
            WHERE dc_745.hqmf_cypress_ep_diagnosis_active_start_dt < so_747.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_748.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_748.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_748.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_748.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_749,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_51 ON code_lists_51.code = diagnosis_active_1.code
                 AND code_lists_51.code_list_id = '2.16.840.1.113883.3.526.3.1472'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_749.so_4_procedure_performed_start_dt
                        AND so_749.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_749.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_749.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_749.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_748,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_750 WHERE dc_748.hqmf_cypress_ep_diagnosis_active_end_dt >= so_750.so_4_procedure_performed_start_dt
              AND so_750.so_4_procedure_performed_end_dt >= dc_748.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_748.hqmf_cypress_ep_diagnosis_active_start_dt <= so_750.so_4_procedure_performed_end_dt
              AND dc_748.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_750.so_4_procedure_performed_start_dt <= dc_748.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_750.so_4_procedure_performed_end_dt IS NULL
              OR dc_748.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_748.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_27
         UNION SELECT anon_28.patient_id AS patient_id,
                      anon_28.start_dt AS start_dt,
                      anon_28.end_dt AS end_dt,
                      anon_28.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_752.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_752.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_752.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_752.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_753,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_52 ON code_lists_52.code = diagnosis_active_1.code
               AND code_lists_52.code_list_id = '2.16.840.1.113883.3.526.3.1460'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_753.so_4_procedure_performed_start_dt) AS dc_752,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_754
            WHERE dc_752.hqmf_cypress_ep_diagnosis_active_start_dt < so_754.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_755.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_755.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_755.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_755.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_756,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_53 ON code_lists_53.code = diagnosis_active_1.code
                 AND code_lists_53.code_list_id = '2.16.840.1.113883.3.526.3.1460'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_756.so_4_procedure_performed_start_dt
                        AND so_756.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_756.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_756.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_756.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_755,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_757 WHERE dc_755.hqmf_cypress_ep_diagnosis_active_end_dt >= so_757.so_4_procedure_performed_start_dt
              AND so_757.so_4_procedure_performed_end_dt >= dc_755.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_755.hqmf_cypress_ep_diagnosis_active_start_dt <= so_757.so_4_procedure_performed_end_dt
              AND dc_755.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_757.so_4_procedure_performed_start_dt <= dc_755.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_757.so_4_procedure_performed_end_dt IS NULL
              OR dc_755.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_755.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_28
         UNION SELECT anon_29.patient_id AS patient_id,
                      anon_29.start_dt AS start_dt,
                      anon_29.end_dt AS end_dt,
                      anon_29.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_759.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_759.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_759.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_759.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_760,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_54 ON code_lists_54.code = diagnosis_active_1.code
               AND code_lists_54.code_list_id = '2.16.840.1.113883.3.526.3.1454'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_760.so_4_procedure_performed_start_dt) AS dc_759,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_761
            WHERE dc_759.hqmf_cypress_ep_diagnosis_active_start_dt < so_761.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_762.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_762.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_762.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_762.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_763,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_55 ON code_lists_55.code = diagnosis_active_1.code
                 AND code_lists_55.code_list_id = '2.16.840.1.113883.3.526.3.1454'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_763.so_4_procedure_performed_start_dt
                        AND so_763.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_763.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_763.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_763.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_762,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_764 WHERE dc_762.hqmf_cypress_ep_diagnosis_active_end_dt >= so_764.so_4_procedure_performed_start_dt
              AND so_764.so_4_procedure_performed_end_dt >= dc_762.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_762.hqmf_cypress_ep_diagnosis_active_start_dt <= so_764.so_4_procedure_performed_end_dt
              AND dc_762.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_764.so_4_procedure_performed_start_dt <= dc_762.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_764.so_4_procedure_performed_end_dt IS NULL
              OR dc_762.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_762.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_29
         UNION SELECT anon_30.patient_id AS patient_id,
                      anon_30.start_dt AS start_dt,
                      anon_30.end_dt AS end_dt,
                      anon_30.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_766.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_766.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_766.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_766.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_767,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_56 ON code_lists_56.code = diagnosis_active_1.code
               AND code_lists_56.code_list_id = '2.16.840.1.113883.3.526.3.1453'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_767.so_4_procedure_performed_start_dt) AS dc_766,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_768
            WHERE dc_766.hqmf_cypress_ep_diagnosis_active_start_dt < so_768.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_769.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_769.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_769.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_769.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_770,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_57 ON code_lists_57.code = diagnosis_active_1.code
                 AND code_lists_57.code_list_id = '2.16.840.1.113883.3.526.3.1453'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_770.so_4_procedure_performed_start_dt
                        AND so_770.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_770.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_770.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_770.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_769,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_771 WHERE dc_769.hqmf_cypress_ep_diagnosis_active_end_dt >= so_771.so_4_procedure_performed_start_dt
              AND so_771.so_4_procedure_performed_end_dt >= dc_769.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_769.hqmf_cypress_ep_diagnosis_active_start_dt <= so_771.so_4_procedure_performed_end_dt
              AND dc_769.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_771.so_4_procedure_performed_start_dt <= dc_769.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_771.so_4_procedure_performed_end_dt IS NULL
              OR dc_769.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_769.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_30
         UNION SELECT anon_31.patient_id AS patient_id,
                      anon_31.start_dt AS start_dt,
                      anon_31.end_dt AS end_dt,
                      anon_31.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_773.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_773.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_773.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_773.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_774,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_58 ON code_lists_58.code = diagnosis_active_1.code
               AND code_lists_58.code_list_id = '2.16.840.1.113883.3.526.3.1459'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_774.so_4_procedure_performed_start_dt) AS dc_773,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_775
            WHERE dc_773.hqmf_cypress_ep_diagnosis_active_start_dt < so_775.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_776.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_776.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_776.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_776.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_777,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_59 ON code_lists_59.code = diagnosis_active_1.code
                 AND code_lists_59.code_list_id = '2.16.840.1.113883.3.526.3.1459'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_777.so_4_procedure_performed_start_dt
                        AND so_777.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_777.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_777.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_777.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_776,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_778 WHERE dc_776.hqmf_cypress_ep_diagnosis_active_end_dt >= so_778.so_4_procedure_performed_start_dt
              AND so_778.so_4_procedure_performed_end_dt >= dc_776.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_776.hqmf_cypress_ep_diagnosis_active_start_dt <= so_778.so_4_procedure_performed_end_dt
              AND dc_776.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_778.so_4_procedure_performed_start_dt <= dc_776.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_778.so_4_procedure_performed_end_dt IS NULL
              OR dc_776.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_776.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_31
         UNION SELECT anon_32.patient_id AS patient_id,
                      anon_32.start_dt AS start_dt,
                      anon_32.end_dt AS end_dt,
                      anon_32.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_780.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_780.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_780.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_780.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_781,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_60 ON code_lists_60.code = diagnosis_active_1.code
               AND code_lists_60.code_list_id = '2.16.840.1.113883.3.526.3.1455'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_781.so_4_procedure_performed_start_dt) AS dc_780,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_782
            WHERE dc_780.hqmf_cypress_ep_diagnosis_active_start_dt < so_782.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_783.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_783.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_783.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_783.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_784,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_61 ON code_lists_61.code = diagnosis_active_1.code
                 AND code_lists_61.code_list_id = '2.16.840.1.113883.3.526.3.1455'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_784.so_4_procedure_performed_start_dt
                        AND so_784.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_784.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_784.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_784.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_783,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_785 WHERE dc_783.hqmf_cypress_ep_diagnosis_active_end_dt >= so_785.so_4_procedure_performed_start_dt
              AND so_785.so_4_procedure_performed_end_dt >= dc_783.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_783.hqmf_cypress_ep_diagnosis_active_start_dt <= so_785.so_4_procedure_performed_end_dt
              AND dc_783.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_785.so_4_procedure_performed_start_dt <= dc_783.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_785.so_4_procedure_performed_end_dt IS NULL
              OR dc_783.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_783.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_32
         UNION SELECT anon_33.patient_id AS patient_id,
                      anon_33.start_dt AS start_dt,
                      anon_33.end_dt AS end_dt,
                      anon_33.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_787.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_787.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_787.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_787.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_788,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_62 ON code_lists_62.code = diagnosis_active_1.code
               AND code_lists_62.code_list_id = '2.16.840.1.113883.3.526.3.1444'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_788.so_4_procedure_performed_start_dt) AS dc_787,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_789
            WHERE dc_787.hqmf_cypress_ep_diagnosis_active_start_dt < so_789.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_790.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_790.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_790.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_790.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_791,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_63 ON code_lists_63.code = diagnosis_active_1.code
                 AND code_lists_63.code_list_id = '2.16.840.1.113883.3.526.3.1444'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_791.so_4_procedure_performed_start_dt
                        AND so_791.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_791.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_791.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_791.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_790,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_792 WHERE dc_790.hqmf_cypress_ep_diagnosis_active_end_dt >= so_792.so_4_procedure_performed_start_dt
              AND so_792.so_4_procedure_performed_end_dt >= dc_790.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_790.hqmf_cypress_ep_diagnosis_active_start_dt <= so_792.so_4_procedure_performed_end_dt
              AND dc_790.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_792.so_4_procedure_performed_start_dt <= dc_790.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_792.so_4_procedure_performed_end_dt IS NULL
              OR dc_790.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_790.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_33
         UNION SELECT anon_34.patient_id AS patient_id,
                      anon_34.start_dt AS start_dt,
                      anon_34.end_dt AS end_dt,
                      anon_34.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_794.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_794.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_794.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_794.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_795,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_64 ON code_lists_64.code = diagnosis_active_1.code
               AND code_lists_64.code_list_id = '2.16.840.1.113883.3.526.3.1476'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_795.so_4_procedure_performed_start_dt) AS dc_794,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_796
            WHERE dc_794.hqmf_cypress_ep_diagnosis_active_start_dt < so_796.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_797.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_797.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_797.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_797.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_798,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_65 ON code_lists_65.code = diagnosis_active_1.code
                 AND code_lists_65.code_list_id = '2.16.840.1.113883.3.526.3.1476'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_798.so_4_procedure_performed_start_dt
                        AND so_798.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_798.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_798.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_798.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_797,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_799 WHERE dc_797.hqmf_cypress_ep_diagnosis_active_end_dt >= so_799.so_4_procedure_performed_start_dt
              AND so_799.so_4_procedure_performed_end_dt >= dc_797.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_797.hqmf_cypress_ep_diagnosis_active_start_dt <= so_799.so_4_procedure_performed_end_dt
              AND dc_797.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_799.so_4_procedure_performed_start_dt <= dc_797.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_799.so_4_procedure_performed_end_dt IS NULL
              OR dc_797.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_797.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_34
         UNION SELECT anon_35.patient_id AS patient_id,
                      anon_35.start_dt AS start_dt,
                      anon_35.end_dt AS end_dt,
                      anon_35.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_801.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_801.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_801.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_801.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_802,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_66 ON code_lists_66.code = diagnosis_active_1.code
               AND code_lists_66.code_list_id = '2.16.840.1.113883.3.526.3.1480'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_802.so_4_procedure_performed_start_dt) AS dc_801,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_803
            WHERE dc_801.hqmf_cypress_ep_diagnosis_active_start_dt < so_803.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_804.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_804.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_804.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_804.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_805,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_67 ON code_lists_67.code = diagnosis_active_1.code
                 AND code_lists_67.code_list_id = '2.16.840.1.113883.3.526.3.1480'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_805.so_4_procedure_performed_start_dt
                        AND so_805.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_805.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_805.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_805.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_804,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_806 WHERE dc_804.hqmf_cypress_ep_diagnosis_active_end_dt >= so_806.so_4_procedure_performed_start_dt
              AND so_806.so_4_procedure_performed_end_dt >= dc_804.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_804.hqmf_cypress_ep_diagnosis_active_start_dt <= so_806.so_4_procedure_performed_end_dt
              AND dc_804.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_806.so_4_procedure_performed_start_dt <= dc_804.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_806.so_4_procedure_performed_end_dt IS NULL
              OR dc_804.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_804.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_35
         UNION SELECT anon_36.patient_id AS patient_id,
                      anon_36.start_dt AS start_dt,
                      anon_36.end_dt AS end_dt,
                      anon_36.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_808.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_808.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_808.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_808.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_809,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_68 ON code_lists_68.code = diagnosis_active_1.code
               AND code_lists_68.code_list_id = '2.16.840.1.113883.3.526.3.1410'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_809.so_4_procedure_performed_start_dt) AS dc_808,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_810
            WHERE dc_808.hqmf_cypress_ep_diagnosis_active_start_dt < so_810.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_811.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_811.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_811.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_811.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_812,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_69 ON code_lists_69.code = diagnosis_active_1.code
                 AND code_lists_69.code_list_id = '2.16.840.1.113883.3.526.3.1410'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_812.so_4_procedure_performed_start_dt
                        AND so_812.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_812.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_812.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_812.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_811,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_813 WHERE dc_811.hqmf_cypress_ep_diagnosis_active_end_dt >= so_813.so_4_procedure_performed_start_dt
              AND so_813.so_4_procedure_performed_end_dt >= dc_811.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_811.hqmf_cypress_ep_diagnosis_active_start_dt <= so_813.so_4_procedure_performed_end_dt
              AND dc_811.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_813.so_4_procedure_performed_start_dt <= dc_811.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_813.so_4_procedure_performed_end_dt IS NULL
              OR dc_811.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_811.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_36
         UNION SELECT anon_37.patient_id AS patient_id,
                      anon_37.start_dt AS start_dt,
                      anon_37.end_dt AS end_dt,
                      anon_37.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_815.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_815.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_815.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_815.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_816,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_70 ON code_lists_70.code = diagnosis_active_1.code
               AND code_lists_70.code_list_id = '2.16.840.1.113883.3.526.3.1458'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_816.so_4_procedure_performed_start_dt) AS dc_815,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_817
            WHERE dc_815.hqmf_cypress_ep_diagnosis_active_start_dt < so_817.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_818.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_818.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_818.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_818.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_819,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_71 ON code_lists_71.code = diagnosis_active_1.code
                 AND code_lists_71.code_list_id = '2.16.840.1.113883.3.526.3.1458'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_819.so_4_procedure_performed_start_dt
                        AND so_819.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_819.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_819.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_819.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_818,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_820 WHERE dc_818.hqmf_cypress_ep_diagnosis_active_end_dt >= so_820.so_4_procedure_performed_start_dt
              AND so_820.so_4_procedure_performed_end_dt >= dc_818.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_818.hqmf_cypress_ep_diagnosis_active_start_dt <= so_820.so_4_procedure_performed_end_dt
              AND dc_818.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_820.so_4_procedure_performed_start_dt <= dc_818.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_820.so_4_procedure_performed_end_dt IS NULL
              OR dc_818.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_818.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_37
         UNION SELECT anon_38.patient_id AS patient_id,
                      anon_38.start_dt AS start_dt,
                      anon_38.end_dt AS end_dt,
                      anon_38.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_822.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_822.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_822.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_822.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_823,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_72 ON code_lists_72.code = diagnosis_active_1.code
               AND code_lists_72.code_list_id = '2.16.840.1.113883.3.526.3.1451'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_823.so_4_procedure_performed_start_dt) AS dc_822,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_824
            WHERE dc_822.hqmf_cypress_ep_diagnosis_active_start_dt < so_824.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_825.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_825.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_825.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_825.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_826,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_73 ON code_lists_73.code = diagnosis_active_1.code
                 AND code_lists_73.code_list_id = '2.16.840.1.113883.3.526.3.1451'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_826.so_4_procedure_performed_start_dt
                        AND so_826.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_826.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_826.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_826.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_825,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_827 WHERE dc_825.hqmf_cypress_ep_diagnosis_active_end_dt >= so_827.so_4_procedure_performed_start_dt
              AND so_827.so_4_procedure_performed_end_dt >= dc_825.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_825.hqmf_cypress_ep_diagnosis_active_start_dt <= so_827.so_4_procedure_performed_end_dt
              AND dc_825.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_827.so_4_procedure_performed_start_dt <= dc_825.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_827.so_4_procedure_performed_end_dt IS NULL
              OR dc_825.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_825.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_38
         UNION SELECT anon_39.patient_id AS patient_id,
                      anon_39.start_dt AS start_dt,
                      anon_39.end_dt AS end_dt,
                      anon_39.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_829.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_829.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_829.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_829.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_830,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_74 ON code_lists_74.code = diagnosis_active_1.code
               AND code_lists_74.code_list_id = '2.16.840.1.113883.3.526.3.1457'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_830.so_4_procedure_performed_start_dt) AS dc_829,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_831
            WHERE dc_829.hqmf_cypress_ep_diagnosis_active_start_dt < so_831.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_832.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_832.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_832.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_832.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_833,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_75 ON code_lists_75.code = diagnosis_active_1.code
                 AND code_lists_75.code_list_id = '2.16.840.1.113883.3.526.3.1457'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_833.so_4_procedure_performed_start_dt
                        AND so_833.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_833.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_833.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_833.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_832,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_834 WHERE dc_832.hqmf_cypress_ep_diagnosis_active_end_dt >= so_834.so_4_procedure_performed_start_dt
              AND so_834.so_4_procedure_performed_end_dt >= dc_832.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_832.hqmf_cypress_ep_diagnosis_active_start_dt <= so_834.so_4_procedure_performed_end_dt
              AND dc_832.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_834.so_4_procedure_performed_start_dt <= dc_832.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_834.so_4_procedure_performed_end_dt IS NULL
              OR dc_832.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_832.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_39
         UNION SELECT anon_40.patient_id AS patient_id,
                      anon_40.start_dt AS start_dt,
                      anon_40.end_dt AS end_dt,
                      anon_40.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_836.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_836.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_836.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_836.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_837,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_76 ON code_lists_76.code = diagnosis_active_1.code
               AND code_lists_76.code_list_id = '2.16.840.1.113883.3.526.3.1427'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_837.so_4_procedure_performed_start_dt) AS dc_836,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_838
            WHERE dc_836.hqmf_cypress_ep_diagnosis_active_start_dt < so_838.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_839.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_839.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_839.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_839.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_840,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_77 ON code_lists_77.code = diagnosis_active_1.code
                 AND code_lists_77.code_list_id = '2.16.840.1.113883.3.526.3.1427'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_840.so_4_procedure_performed_start_dt
                        AND so_840.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_840.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_840.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_840.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_839,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_841 WHERE dc_839.hqmf_cypress_ep_diagnosis_active_end_dt >= so_841.so_4_procedure_performed_start_dt
              AND so_841.so_4_procedure_performed_end_dt >= dc_839.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_839.hqmf_cypress_ep_diagnosis_active_start_dt <= so_841.so_4_procedure_performed_end_dt
              AND dc_839.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_841.so_4_procedure_performed_start_dt <= dc_839.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_841.so_4_procedure_performed_end_dt IS NULL
              OR dc_839.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_839.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_40
         UNION SELECT anon_41.patient_id AS patient_id,
                      anon_41.start_dt AS start_dt,
                      anon_41.end_dt AS end_dt,
                      anon_41.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_843.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_843.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_843.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_843.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_844,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_78 ON code_lists_78.code = diagnosis_active_1.code
               AND code_lists_78.code_list_id = '2.16.840.1.113883.3.526.3.1452'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_844.so_4_procedure_performed_start_dt) AS dc_843,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_845
            WHERE dc_843.hqmf_cypress_ep_diagnosis_active_start_dt < so_845.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_846.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_846.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_846.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_846.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_847,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_79 ON code_lists_79.code = diagnosis_active_1.code
                 AND code_lists_79.code_list_id = '2.16.840.1.113883.3.526.3.1452'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_847.so_4_procedure_performed_start_dt
                        AND so_847.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_847.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_847.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_847.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_846,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_848 WHERE dc_846.hqmf_cypress_ep_diagnosis_active_end_dt >= so_848.so_4_procedure_performed_start_dt
              AND so_848.so_4_procedure_performed_end_dt >= dc_846.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_846.hqmf_cypress_ep_diagnosis_active_start_dt <= so_848.so_4_procedure_performed_end_dt
              AND dc_846.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_848.so_4_procedure_performed_start_dt <= dc_846.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_848.so_4_procedure_performed_end_dt IS NULL
              OR dc_846.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_846.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_41
         UNION SELECT anon_42.patient_id AS patient_id,
                      anon_42.start_dt AS start_dt,
                      anon_42.end_dt AS end_dt,
                      anon_42.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_850.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_850.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_850.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_850.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_851,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_80 ON code_lists_80.code = diagnosis_active_1.code
               AND code_lists_80.code_list_id = '2.16.840.1.113883.3.526.3.1471'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_851.so_4_procedure_performed_start_dt) AS dc_850,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_852
            WHERE dc_850.hqmf_cypress_ep_diagnosis_active_start_dt < so_852.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_853.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_853.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_853.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_853.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_854,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_81 ON code_lists_81.code = diagnosis_active_1.code
                 AND code_lists_81.code_list_id = '2.16.840.1.113883.3.526.3.1471'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_854.so_4_procedure_performed_start_dt
                        AND so_854.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_854.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_854.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_854.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_853,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_855 WHERE dc_853.hqmf_cypress_ep_diagnosis_active_end_dt >= so_855.so_4_procedure_performed_start_dt
              AND so_855.so_4_procedure_performed_end_dt >= dc_853.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_853.hqmf_cypress_ep_diagnosis_active_start_dt <= so_855.so_4_procedure_performed_end_dt
              AND dc_853.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_855.so_4_procedure_performed_start_dt <= dc_853.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_855.so_4_procedure_performed_end_dt IS NULL
              OR dc_853.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_853.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_42
         UNION SELECT anon_43.patient_id AS patient_id,
                      anon_43.start_dt AS start_dt,
                      anon_43.end_dt AS end_dt,
                      anon_43.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_857.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_857.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_857.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_857.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_858,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_82 ON code_lists_82.code = diagnosis_active_1.code
               AND code_lists_82.code_list_id = '2.16.840.1.113883.3.526.3.1423'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_858.so_4_procedure_performed_start_dt) AS dc_857,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_859
            WHERE dc_857.hqmf_cypress_ep_diagnosis_active_start_dt < so_859.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_860.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_860.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_860.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_860.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_861,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_83 ON code_lists_83.code = diagnosis_active_1.code
                 AND code_lists_83.code_list_id = '2.16.840.1.113883.3.526.3.1423'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_861.so_4_procedure_performed_start_dt
                        AND so_861.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_861.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_861.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_861.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_860,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_862 WHERE dc_860.hqmf_cypress_ep_diagnosis_active_end_dt >= so_862.so_4_procedure_performed_start_dt
              AND so_862.so_4_procedure_performed_end_dt >= dc_860.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_860.hqmf_cypress_ep_diagnosis_active_start_dt <= so_862.so_4_procedure_performed_end_dt
              AND dc_860.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_862.so_4_procedure_performed_start_dt <= dc_860.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_862.so_4_procedure_performed_end_dt IS NULL
              OR dc_860.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_860.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_43
         UNION SELECT anon_44.patient_id AS patient_id,
                      anon_44.start_dt AS start_dt,
                      anon_44.end_dt AS end_dt,
                      anon_44.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_864.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_864.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_864.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_864.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_865,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_84 ON code_lists_84.code = diagnosis_active_1.code
               AND code_lists_84.code_list_id = '2.16.840.1.113883.3.526.3.1449'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_865.so_4_procedure_performed_start_dt) AS dc_864,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_866
            WHERE dc_864.hqmf_cypress_ep_diagnosis_active_start_dt < so_866.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_867.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_867.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_867.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_867.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_868,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_85 ON code_lists_85.code = diagnosis_active_1.code
                 AND code_lists_85.code_list_id = '2.16.840.1.113883.3.526.3.1449'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_868.so_4_procedure_performed_start_dt
                        AND so_868.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_868.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_868.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_868.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_867,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_869 WHERE dc_867.hqmf_cypress_ep_diagnosis_active_end_dt >= so_869.so_4_procedure_performed_start_dt
              AND so_869.so_4_procedure_performed_end_dt >= dc_867.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_867.hqmf_cypress_ep_diagnosis_active_start_dt <= so_869.so_4_procedure_performed_end_dt
              AND dc_867.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_869.so_4_procedure_performed_start_dt <= dc_867.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_869.so_4_procedure_performed_end_dt IS NULL
              OR dc_867.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_867.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_44
         UNION SELECT anon_45.patient_id AS patient_id,
                      anon_45.start_dt AS start_dt,
                      anon_45.end_dt AS end_dt,
                      anon_45.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_871.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_871.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_871.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_871.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_872,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_86 ON code_lists_86.code = diagnosis_active_1.code
               AND code_lists_86.code_list_id = '2.16.840.1.113883.3.526.3.1424'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_872.so_4_procedure_performed_start_dt) AS dc_871,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_873
            WHERE dc_871.hqmf_cypress_ep_diagnosis_active_start_dt < so_873.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_874.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_874.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_874.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_874.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_875,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_87 ON code_lists_87.code = diagnosis_active_1.code
                 AND code_lists_87.code_list_id = '2.16.840.1.113883.3.526.3.1424'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_875.so_4_procedure_performed_start_dt
                        AND so_875.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_875.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_875.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_875.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_874,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_876 WHERE dc_874.hqmf_cypress_ep_diagnosis_active_end_dt >= so_876.so_4_procedure_performed_start_dt
              AND so_876.so_4_procedure_performed_end_dt >= dc_874.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_874.hqmf_cypress_ep_diagnosis_active_start_dt <= so_876.so_4_procedure_performed_end_dt
              AND dc_874.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_876.so_4_procedure_performed_start_dt <= dc_874.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_876.so_4_procedure_performed_end_dt IS NULL
              OR dc_874.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_874.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_45
         UNION SELECT anon_46.patient_id AS patient_id,
                      anon_46.start_dt AS start_dt,
                      anon_46.end_dt AS end_dt,
                      anon_46.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_878.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_878.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_878.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_878.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_879,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_88 ON code_lists_88.code = diagnosis_active_1.code
               AND code_lists_88.code_list_id = '2.16.840.1.113883.3.526.3.1428'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_879.so_4_procedure_performed_start_dt) AS dc_878,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_880
            WHERE dc_878.hqmf_cypress_ep_diagnosis_active_start_dt < so_880.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_881.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_881.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_881.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_881.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_882,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_89 ON code_lists_89.code = diagnosis_active_1.code
                 AND code_lists_89.code_list_id = '2.16.840.1.113883.3.526.3.1428'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_882.so_4_procedure_performed_start_dt
                        AND so_882.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_882.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_882.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_882.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_881,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_883 WHERE dc_881.hqmf_cypress_ep_diagnosis_active_end_dt >= so_883.so_4_procedure_performed_start_dt
              AND so_883.so_4_procedure_performed_end_dt >= dc_881.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_881.hqmf_cypress_ep_diagnosis_active_start_dt <= so_883.so_4_procedure_performed_end_dt
              AND dc_881.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_883.so_4_procedure_performed_start_dt <= dc_881.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_883.so_4_procedure_performed_end_dt IS NULL
              OR dc_881.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_881.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_46
         UNION SELECT anon_47.patient_id AS patient_id,
                      anon_47.start_dt AS start_dt,
                      anon_47.end_dt AS end_dt,
                      anon_47.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_885.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_885.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_885.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_885.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_886,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_90 ON code_lists_90.code = diagnosis_active_1.code
               AND code_lists_90.code_list_id = '2.16.840.1.113883.3.526.3.1419'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_886.so_4_procedure_performed_start_dt) AS dc_885,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_887
            WHERE dc_885.hqmf_cypress_ep_diagnosis_active_start_dt < so_887.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_888.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_888.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_888.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_888.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_889,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_91 ON code_lists_91.code = diagnosis_active_1.code
                 AND code_lists_91.code_list_id = '2.16.840.1.113883.3.526.3.1419'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_889.so_4_procedure_performed_start_dt
                        AND so_889.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_889.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_889.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_889.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_888,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_890 WHERE dc_888.hqmf_cypress_ep_diagnosis_active_end_dt >= so_890.so_4_procedure_performed_start_dt
              AND so_890.so_4_procedure_performed_end_dt >= dc_888.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_888.hqmf_cypress_ep_diagnosis_active_start_dt <= so_890.so_4_procedure_performed_end_dt
              AND dc_888.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_890.so_4_procedure_performed_start_dt <= dc_888.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_890.so_4_procedure_performed_end_dt IS NULL
              OR dc_888.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_888.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_47
         UNION SELECT anon_48.patient_id AS patient_id,
                      anon_48.start_dt AS start_dt,
                      anon_48.end_dt AS end_dt,
                      anon_48.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_892.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_892.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_892.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_892.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_893,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_92 ON code_lists_92.code = diagnosis_active_1.code
               AND code_lists_92.code_list_id = '2.16.840.1.113883.3.526.3.1466'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_893.so_4_procedure_performed_start_dt) AS dc_892,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_894
            WHERE dc_892.hqmf_cypress_ep_diagnosis_active_start_dt < so_894.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_895.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_895.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_895.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_895.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_896,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_93 ON code_lists_93.code = diagnosis_active_1.code
                 AND code_lists_93.code_list_id = '2.16.840.1.113883.3.526.3.1466'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_896.so_4_procedure_performed_start_dt
                        AND so_896.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_896.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_896.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_896.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_895,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_897 WHERE dc_895.hqmf_cypress_ep_diagnosis_active_end_dt >= so_897.so_4_procedure_performed_start_dt
              AND so_897.so_4_procedure_performed_end_dt >= dc_895.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_895.hqmf_cypress_ep_diagnosis_active_start_dt <= so_897.so_4_procedure_performed_end_dt
              AND dc_895.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_897.so_4_procedure_performed_start_dt <= dc_895.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_897.so_4_procedure_performed_end_dt IS NULL
              OR dc_895.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_895.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_48
         UNION SELECT anon_49.patient_id AS patient_id,
                      anon_49.start_dt AS start_dt,
                      anon_49.end_dt AS end_dt,
                      anon_49.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_899.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_899.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_899.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_899.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_900,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_94 ON code_lists_94.code = diagnosis_active_1.code
               AND code_lists_94.code_list_id = '2.16.840.1.113883.3.526.3.1430'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_900.so_4_procedure_performed_start_dt) AS dc_899,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_901
            WHERE dc_899.hqmf_cypress_ep_diagnosis_active_start_dt < so_901.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_902.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_902.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_902.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_902.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_903,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_95 ON code_lists_95.code = diagnosis_active_1.code
                 AND code_lists_95.code_list_id = '2.16.840.1.113883.3.526.3.1430'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_903.so_4_procedure_performed_start_dt
                        AND so_903.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_903.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_903.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_903.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_902,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_904 WHERE dc_902.hqmf_cypress_ep_diagnosis_active_end_dt >= so_904.so_4_procedure_performed_start_dt
              AND so_904.so_4_procedure_performed_end_dt >= dc_902.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_902.hqmf_cypress_ep_diagnosis_active_start_dt <= so_904.so_4_procedure_performed_end_dt
              AND dc_902.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_904.so_4_procedure_performed_start_dt <= dc_902.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_904.so_4_procedure_performed_end_dt IS NULL
              OR dc_902.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_902.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_49
         UNION SELECT anon_50.patient_id AS patient_id,
                      anon_50.start_dt AS start_dt,
                      anon_50.end_dt AS end_dt,
                      anon_50.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_906.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_906.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_906.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_906.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_907,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_96 ON code_lists_96.code = diagnosis_active_1.code
               AND code_lists_96.code_list_id = '2.16.840.1.113883.3.526.3.1473'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_907.so_4_procedure_performed_start_dt) AS dc_906,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_908
            WHERE dc_906.hqmf_cypress_ep_diagnosis_active_start_dt < so_908.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_909.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_909.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_909.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_909.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_910,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_97 ON code_lists_97.code = diagnosis_active_1.code
                 AND code_lists_97.code_list_id = '2.16.840.1.113883.3.526.3.1473'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_910.so_4_procedure_performed_start_dt
                        AND so_910.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_910.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_910.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_910.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_909,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_911 WHERE dc_909.hqmf_cypress_ep_diagnosis_active_end_dt >= so_911.so_4_procedure_performed_start_dt
              AND so_911.so_4_procedure_performed_end_dt >= dc_909.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_909.hqmf_cypress_ep_diagnosis_active_start_dt <= so_911.so_4_procedure_performed_end_dt
              AND dc_909.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_911.so_4_procedure_performed_start_dt <= dc_909.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_911.so_4_procedure_performed_end_dt IS NULL
              OR dc_909.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_909.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_50
         UNION SELECT anon_51.patient_id AS patient_id,
                      anon_51.start_dt AS start_dt,
                      anon_51.end_dt AS end_dt,
                      anon_51.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_913.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_913.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_913.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_913.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_914,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_98 ON code_lists_98.code = diagnosis_active_1.code
               AND code_lists_98.code_list_id = '2.16.840.1.113883.3.526.3.1482'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_914.so_4_procedure_performed_start_dt) AS dc_913,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_915
            WHERE dc_913.hqmf_cypress_ep_diagnosis_active_start_dt < so_915.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_916.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_916.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_916.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_916.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_917,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_99 ON code_lists_99.code = diagnosis_active_1.code
                 AND code_lists_99.code_list_id = '2.16.840.1.113883.3.526.3.1482'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_917.so_4_procedure_performed_start_dt
                        AND so_917.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_917.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_917.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_917.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_916,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_918 WHERE dc_916.hqmf_cypress_ep_diagnosis_active_end_dt >= so_918.so_4_procedure_performed_start_dt
              AND so_918.so_4_procedure_performed_end_dt >= dc_916.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_916.hqmf_cypress_ep_diagnosis_active_start_dt <= so_918.so_4_procedure_performed_end_dt
              AND dc_916.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_918.so_4_procedure_performed_start_dt <= dc_916.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_918.so_4_procedure_performed_end_dt IS NULL
              OR dc_916.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_916.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_51
         UNION SELECT anon_52.patient_id AS patient_id,
                      anon_52.start_dt AS start_dt,
                      anon_52.end_dt AS end_dt,
                      anon_52.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_920.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_920.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_920.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_920.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_921,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_100 ON code_lists_100.code = diagnosis_active_1.code
               AND code_lists_100.code_list_id = '2.16.840.1.113883.3.526.3.327'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_921.so_4_procedure_performed_start_dt) AS dc_920,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_922
            WHERE dc_920.hqmf_cypress_ep_diagnosis_active_start_dt < so_922.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_923.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_923.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_923.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_923.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_924,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_101 ON code_lists_101.code = diagnosis_active_1.code
                 AND code_lists_101.code_list_id = '2.16.840.1.113883.3.526.3.327'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_924.so_4_procedure_performed_start_dt
                        AND so_924.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_924.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_924.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_924.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_923,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_925 WHERE dc_923.hqmf_cypress_ep_diagnosis_active_end_dt >= so_925.so_4_procedure_performed_start_dt
              AND so_925.so_4_procedure_performed_end_dt >= dc_923.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_923.hqmf_cypress_ep_diagnosis_active_start_dt <= so_925.so_4_procedure_performed_end_dt
              AND dc_923.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_925.so_4_procedure_performed_start_dt <= dc_923.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_925.so_4_procedure_performed_end_dt IS NULL
              OR dc_923.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_923.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_52
         UNION SELECT anon_53.patient_id AS patient_id,
                      anon_53.start_dt AS start_dt,
                      anon_53.end_dt AS end_dt,
                      anon_53.audit_key_value AS audit_key_value
         FROM
           (SELECT dc_927.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                   dc_927.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                   dc_927.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                   dc_927.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
            FROM
              (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                      diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                      diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                      diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
               FROM
                 (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                         so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                         so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                         so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                  FROM so_4_procedure_performed
                  WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_928,
                    hqmf_test.diagnosis_active AS diagnosis_active_1
               JOIN
               valuesets.code_lists AS code_lists_102 ON code_lists_102.code = diagnosis_active_1.code
               AND code_lists_102.code_list_id = '2.16.840.1.113883.3.526.3.1446'
               WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                 AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                      OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                 AND diagnosis_active_1.start_dt < so_928.so_4_procedure_performed_start_dt) AS dc_927,

              (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                      so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                      so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                      so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
               FROM so_4_procedure_performed
               WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_929
            WHERE dc_927.hqmf_cypress_ep_diagnosis_active_start_dt < so_929.so_4_procedure_performed_start_dt INTERSECT
              SELECT dc_930.hqmf_cypress_ep_diagnosis_active_patient_id AS patient_id,
                     dc_930.hqmf_cypress_ep_diagnosis_active_start_dt AS start_dt,
                     dc_930.hqmf_cypress_ep_diagnosis_active_end_dt AS end_dt,
                     dc_930.hqmf_cypress_ep_diagnosis_active_audit_key_value AS audit_key_value
              FROM
                (SELECT diagnosis_active_1.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                        diagnosis_active_1.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                        diagnosis_active_1.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                        diagnosis_active_1.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
                 FROM
                   (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                           so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                           so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                           so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                    FROM so_4_procedure_performed
                    WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_931,
                      hqmf_test.diagnosis_active AS diagnosis_active_1
                 JOIN
                 valuesets.code_lists AS code_lists_103 ON code_lists_103.code = diagnosis_active_1.code
                 AND code_lists_103.code_list_id = '2.16.840.1.113883.3.526.3.1446'
                 WHERE diagnosis_active_1.patient_id = patient_base.base_patient_id
                   AND (CAST(diagnosis_active_1.negation AS BIT) IS NULL
                        OR CAST(diagnosis_active_1.negation AS BIT) = 0)
                   AND (diagnosis_active_1.end_dt >= so_931.so_4_procedure_performed_start_dt
                        AND so_931.so_4_procedure_performed_end_dt >= diagnosis_active_1.start_dt
                        OR diagnosis_active_1.start_dt <= so_931.so_4_procedure_performed_end_dt
                        AND diagnosis_active_1.end_dt IS NULL
                        OR so_931.so_4_procedure_performed_start_dt <= diagnosis_active_1.end_dt
                        AND so_931.so_4_procedure_performed_end_dt IS NULL
                        OR diagnosis_active_1.start_dt IS NULL
                        AND diagnosis_active_1.end_dt IS NULL)) AS dc_930,

                (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                        so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                        so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                        so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
                 FROM so_4_procedure_performed
                 WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_932 WHERE dc_930.hqmf_cypress_ep_diagnosis_active_end_dt >= so_932.so_4_procedure_performed_start_dt
              AND so_932.so_4_procedure_performed_end_dt >= dc_930.hqmf_cypress_ep_diagnosis_active_start_dt
              OR dc_930.hqmf_cypress_ep_diagnosis_active_start_dt <= so_932.so_4_procedure_performed_end_dt
              AND dc_930.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL
              OR so_932.so_4_procedure_performed_start_dt <= dc_930.hqmf_cypress_ep_diagnosis_active_end_dt
              AND so_932.so_4_procedure_performed_end_dt IS NULL
              OR dc_930.hqmf_cypress_ep_diagnosis_active_start_dt IS NULL
              AND dc_930.hqmf_cypress_ep_diagnosis_active_end_dt IS NULL) AS anon_53) AS anon_2) 
			   THEN cast( 1 as bit)  
				ELSE cast(0 as bit)
				END AS anon_1) AS [denominatorExclusions],

  (SELECT CASE WHEN (EXISTS
             (SELECT dc_933.hqmf_cypress_ep_patient_characteristic_birthdate_patient_id,
                     dc_933.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_933.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_933.hqmf_cypress_ep_patient_characteristic_birthdate_audit_key_value
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
                   AND results.year_delta(patient_characteristic_birthdate_1.start_dt, CAST('2015-01-01 00:00:00' AS DATETIME)) >= 18) AS dc_933))
   AND (EXISTS
          (SELECT so_934.so_4_procedure_performed_patient_id,
                  so_934.so_4_procedure_performed_start_dt,
                  so_934.so_4_procedure_performed_end_dt,
                  so_934.so_4_procedure_performed_audit_key_value
           FROM
             (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                     so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                     so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                     so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
              FROM so_4_procedure_performed
              WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value
                AND so_4_procedure_performed.so_4_procedure_performed_start_dt >= CAST('2015-01-01 00:00:00' AS DATETIME)
                AND so_4_procedure_performed.so_4_procedure_performed_end_dt <= CAST('2015-12-31T00:00:00' AS DATETIME)) AS so_934))
   AND (EXISTS
          (SELECT so_935.so_4_procedure_performed_patient_id,
                  so_935.so_4_procedure_performed_start_dt,
                  so_935.so_4_procedure_performed_end_dt,
                  so_935.so_4_procedure_performed_audit_key_value
           FROM
             (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                     so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                     so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                     so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
              FROM so_4_procedure_performed
              WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value
                AND so_4_procedure_performed.so_4_procedure_performed_start_dt < CAST('2015-12-31T00:00:00' AS DATETIME)
                AND results.day_delta(so_4_procedure_performed.so_4_procedure_performed_start_dt, CAST('2015-12-31T00:00:00' AS DATETIME)) > 92) AS so_935)) 
				 THEN cast( 1 as bit)  
				   ELSE cast(0 as bit)
				   END AS anon_54) AS [initialPopulation],

  (SELECT CASE WHEN EXISTS
     (SELECT dc_936.hqmf_cypress_ep_physical_exam_performed_patient_id,
             dc_936.hqmf_cypress_ep_physical_exam_performed_start_dt,
             dc_936.hqmf_cypress_ep_physical_exam_performed_end_dt,
             dc_936.hqmf_cypress_ep_physical_exam_performed_audit_key_value
      FROM
        (SELECT physical_exam_performed_1.patient_id AS hqmf_cypress_ep_physical_exam_performed_patient_id,
                physical_exam_performed_1.start_dt AS hqmf_cypress_ep_physical_exam_performed_start_dt,
                physical_exam_performed_1.end_dt AS hqmf_cypress_ep_physical_exam_performed_end_dt,
                physical_exam_performed_1.audit_key_value AS hqmf_cypress_ep_physical_exam_performed_audit_key_value
         FROM
           (SELECT so_4_procedure_performed.so_4_procedure_performed_patient_id AS so_4_procedure_performed_patient_id,
                   so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
                   so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt,
                   so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value
            FROM so_4_procedure_performed
            WHERE so_4_procedure_performed.so_4_procedure_performed_audit_key_value = patient_base.so_4_procedure_performed_audit_key_value) AS so_938,
              hqmf_test.physical_exam_performed AS physical_exam_performed_1
         JOIN
         valuesets.code_lists AS code_lists_104 ON code_lists_104.code = physical_exam_performed_1.code
         AND code_lists_104.code_list_id = '2.16.840.1.113883.3.526.3.1488'
         WHERE physical_exam_performed_1.patient_id = patient_base.base_patient_id
           AND (CAST(physical_exam_performed_1.negation AS BIT) IS NULL
                OR CAST(physical_exam_performed_1.negation AS BIT) = 0)
           AND physical_exam_performed_1.start_dt > so_938.so_4_procedure_performed_end_dt
           AND results.day_delta(physical_exam_performed_1.start_dt, so_938.so_4_procedure_performed_end_dt) >= 0
           AND results.day_delta(physical_exam_performed_1.start_dt, so_938.so_4_procedure_performed_end_dt) <= 90) AS dc_936) 
		    THEN cast( 1 as bit) 
		   ELSE cast(0 as bit)
		   END AS anon_55) AS numerator
FROM
  (SELECT base_patients.patient_id AS base_patient_id,
          so_4_procedure_performed.so_4_procedure_performed_audit_key_value AS so_4_procedure_performed_audit_key_value,
          so_4_procedure_performed.so_4_procedure_performed_start_dt AS so_4_procedure_performed_start_dt,
          so_4_procedure_performed.so_4_procedure_performed_end_dt AS so_4_procedure_performed_end_dt
   FROM hqmf_test.patients AS base_patients
   LEFT OUTER JOIN so_4_procedure_performed ON so_4_procedure_performed.so_4_procedure_performed_patient_id = base_patients.patient_id) AS patient_base;

CREATE TABLE results.measure_133_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BIT, 
	effective_denom BIT, 
	effective_denex BIT, 
	effective_numer BIT, 
	effective_denexcep BIT
)
;

INSERT INTO results.measure_133_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, [initialPopulation] AS effective_ipp, [initialPopulation] AS effective_denom, [initialPopulation] & [denominatorExclusions] AS effective_denex, [initialPopulation] &~ ([initialPopulation] & [denominatorExclusions]) & numerator AS effective_numer, CAST(NULL AS BIT) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ([initialPopulation] & [denominatorExclusions]) DESC, ([initialPopulation] &~ ([initialPopulation]& [denominatorExclusions]) & numerator) DESC, [initialPopulation] DESC) AS rank 
FROM results.measure_133_0_all 
WHERE [initialPopulation]=1) AS anon_1 
WHERE anon_1.rank = 1
;

