set search_path = results;

CREATE TABLE results.measure_167_conj_32 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_32 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_26.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
       dc_26.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
       dc_26.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
       dc_26.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.encounter_performed.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          hqmf_cypress_ep.encounter_performed.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          hqmf_cypress_ep.encounter_performed.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          hqmf_cypress_ep.encounter_performed.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
   FROM hqmf_cypress_ep.encounter_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.encounter_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1285'
   WHERE CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) IS NULL
     OR CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) = false) AS dc_26
UNION
SELECT dc_27.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
       dc_27.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
       dc_27.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
       dc_27.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.encounter_performed.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          hqmf_cypress_ep.encounter_performed.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          hqmf_cypress_ep.encounter_performed.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          hqmf_cypress_ep.encounter_performed.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
   FROM hqmf_cypress_ep.encounter_performed
   JOIN
   valuesets.code_lists AS code_lists_2 ON code_lists_2.code = hqmf_cypress_ep.encounter_performed.code
   AND code_lists_2.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1014'
   WHERE CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) IS NULL
     OR CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) = false) AS dc_27
UNION
SELECT dc_28.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
       dc_28.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
       dc_28.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
       dc_28.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.encounter_performed.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          hqmf_cypress_ep.encounter_performed.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          hqmf_cypress_ep.encounter_performed.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          hqmf_cypress_ep.encounter_performed.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
   FROM hqmf_cypress_ep.encounter_performed
   JOIN
   valuesets.code_lists AS code_lists_3 ON code_lists_3.code = hqmf_cypress_ep.encounter_performed.code
   AND code_lists_3.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1012'
   WHERE CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) IS NULL
     OR CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) = false) AS dc_28
UNION
SELECT dc_29.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
       dc_29.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
       dc_29.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
       dc_29.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.encounter_performed.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          hqmf_cypress_ep.encounter_performed.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          hqmf_cypress_ep.encounter_performed.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          hqmf_cypress_ep.encounter_performed.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
   FROM hqmf_cypress_ep.encounter_performed
   JOIN
   valuesets.code_lists AS code_lists_4 ON code_lists_4.code = hqmf_cypress_ep.encounter_performed.code
   AND code_lists_4.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1001'
   WHERE CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) IS NULL
     OR CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) = false) AS dc_29
UNION
SELECT dc_30.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
       dc_30.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
       dc_30.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
       dc_30.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.encounter_performed.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          hqmf_cypress_ep.encounter_performed.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          hqmf_cypress_ep.encounter_performed.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          hqmf_cypress_ep.encounter_performed.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
   FROM hqmf_cypress_ep.encounter_performed
   JOIN
   valuesets.code_lists AS code_lists_5 ON code_lists_5.code = hqmf_cypress_ep.encounter_performed.code
   AND code_lists_5.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1008'
   WHERE CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) IS NULL
     OR CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) = false) AS dc_30
UNION
SELECT dc_31.hqmf_cypress_ep_encounter_performed_patient_id AS patient_id,
       dc_31.hqmf_cypress_ep_encounter_performed_start_dt AS start_dt,
       dc_31.hqmf_cypress_ep_encounter_performed_end_dt AS end_dt,
       dc_31.hqmf_cypress_ep_encounter_performed_audit_key_value AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.encounter_performed.patient_id AS hqmf_cypress_ep_encounter_performed_patient_id,
          hqmf_cypress_ep.encounter_performed.start_dt AS hqmf_cypress_ep_encounter_performed_start_dt,
          hqmf_cypress_ep.encounter_performed.end_dt AS hqmf_cypress_ep_encounter_performed_end_dt,
          hqmf_cypress_ep.encounter_performed.audit_key_value AS hqmf_cypress_ep_encounter_performed_audit_key_value
   FROM hqmf_cypress_ep.encounter_performed
   JOIN
   valuesets.code_lists AS code_lists_6 ON code_lists_6.code = hqmf_cypress_ep.encounter_performed.code
   AND code_lists_6.code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1048'
   WHERE CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) IS NULL
     OR CAST(hqmf_cypress_ep.encounter_performed.negation AS BOOLEAN) = false) AS dc_31
;

CREATE INDEX ix_measure_167_conj_32_patient_id ON results.measure_167_conj_32 (patient_id)
;


CREATE TABLE results.measure_167_so_target_25 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_so_target_25 (patient_id, start_dt, end_dt, audit_key_value)
SELECT results.measure_167_conj_32.patient_id,
       results.measure_167_conj_32.start_dt,
       results.measure_167_conj_32.end_dt,
       results.measure_167_conj_32.audit_key_value
FROM results.measure_167_conj_32
WHERE results.measure_167_conj_32.start_dt >= CAST('2014-01-01T00:00:00' AS TIMESTAMP WITHOUT TIME ZONE)
  AND results.measure_167_conj_32.end_dt <= CAST('2014-12-31T00:00:00' AS TIMESTAMP WITHOUT TIME ZONE)
;

CREATE INDEX ix_measure_167_so_target_25_patient_id ON results.measure_167_so_target_25 (patient_id)
;


CREATE TABLE results.measure_167_patient_base (
	base_patient_id INTEGER, 
	so_26_audit_key_value BIGINT, 
	so_26_start_dt TIMESTAMP WITHOUT TIME ZONE, 
	so_26_end_dt TIMESTAMP WITHOUT TIME ZONE
)


;

INSERT INTO results.measure_167_patient_base (base_patient_id, so_26_audit_key_value, so_26_start_dt, so_26_end_dt)
SELECT base_patients.patient_id AS base_patient_id,
       so_26.audit_key_value AS so_26_audit_key_value,
       so_26.start_dt AS so_26_start_dt,
       so_26.end_dt AS so_26_end_dt
FROM hqmf_cypress_ep.patients AS base_patients
LEFT OUTER JOIN
  (SELECT results.measure_167_so_target_25.patient_id AS patient_id,
          results.measure_167_so_target_25.audit_key_value AS audit_key_value,
          results.measure_167_so_target_25.start_dt AS start_dt,
          results.measure_167_so_target_25.end_dt AS end_dt
   FROM results.measure_167_so_target_25) AS so_26 ON so_26.patient_id = base_patients.patient_id
;

CREATE INDEX ix_measure_167_patient_base_base_patient_id ON results.measure_167_patient_base (base_patient_id)
;


CREATE TABLE results.measure_167_conj_38 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_38 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_36.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_36.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_36.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_36.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND (CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) IS NULL
          OR CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = false)
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.value AS VARCHAR(256)) IN
       (SELECT CAST(
                    valuesets.code_lists.code AS VARCHAR(256)) AS anon_1
        FROM
        valuesets.code_lists
        WHERE
          valuesets.code_lists.code_list_id = '2.16.840.1.113883.3.526.3.1284')) AS dc_36
UNION
SELECT dc_37.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_37.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_37.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_37.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_2 ON code_lists_2.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_2.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND (CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) IS NULL
          OR CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = false)
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.value AS VARCHAR(256)) IN
       (SELECT CAST(
                    valuesets.code_lists.code AS VARCHAR(256)) AS anon_2
        FROM
        valuesets.code_lists
        WHERE
          valuesets.code_lists.code_list_id = '2.16.840.1.113883.3.526.3.1320')) AS dc_37
;

CREATE INDEX ix_measure_167_conj_38_patient_id ON results.measure_167_conj_38 (patient_id)
;


CREATE TABLE results.measure_167_conj_39 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_39 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_34.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_34.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_34.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_34.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,

     (SELECT results.measure_167_so_target_25.patient_id AS patient_id,
             results.measure_167_so_target_25.audit_key_value AS audit_key_value,
             results.measure_167_so_target_25.start_dt AS start_dt,
             results.measure_167_so_target_25.end_dt AS end_dt
      FROM results.measure_167_so_target_25) AS so_26,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND (CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) IS NULL
          OR CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = false)
     AND hqmf_cypress_ep.diagnostic_study_performed.start_dt >= so_26.start_dt
     AND hqmf_cypress_ep.diagnostic_study_performed.end_dt <= so_26.end_dt
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.value AS VARCHAR(256)) IN
       (SELECT CAST(
                    valuesets.code_lists.code AS VARCHAR(256)) AS anon_1
        FROM
        valuesets.code_lists
        WHERE
          valuesets.code_lists.code_list_id = '2.16.840.1.113883.3.526.3.1283')) AS dc_34 INTERSECT
SELECT anon_2.patient_id AS patient_id,
       anon_2.start_dt AS start_dt,
       anon_2.end_dt AS end_dt,
       anon_2.audit_key_value AS audit_key_value
FROM
  (SELECT results.measure_167_conj_38.patient_id AS patient_id,
          results.measure_167_conj_38.start_dt AS start_dt,
          results.measure_167_conj_38.end_dt AS end_dt,
          results.measure_167_conj_38.audit_key_value AS audit_key_value
   FROM results.measure_167_conj_38,
        results.measure_167_patient_base
   WHERE results.measure_167_conj_38.patient_id = results.measure_167_patient_base.base_patient_id) AS anon_2
;

CREATE INDEX ix_measure_167_conj_39_patient_id ON results.measure_167_conj_39 (patient_id)
;


CREATE TABLE results.measure_167_conj_44 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_44 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_42.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_42.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_42.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_42.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND (CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) IS NULL
          OR CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = false)
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.value AS VARCHAR(256)) IN
       (SELECT CAST(
                    valuesets.code_lists.code AS VARCHAR(256)) AS anon_1
        FROM
        valuesets.code_lists
        WHERE
          valuesets.code_lists.code_list_id = '2.16.840.1.113883.3.526.3.1284')) AS dc_42
UNION
SELECT dc_43.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_43.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_43.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_43.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_2 ON code_lists_2.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_2.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND (CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) IS NULL
          OR CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = false)
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.value AS VARCHAR(256)) IN
       (SELECT CAST(
                    valuesets.code_lists.code AS VARCHAR(256)) AS anon_2
        FROM
        valuesets.code_lists
        WHERE
          valuesets.code_lists.code_list_id = '2.16.840.1.113883.3.526.3.1320')) AS dc_43
;

CREATE INDEX ix_measure_167_conj_44_patient_id ON results.measure_167_conj_44 (patient_id)
;


CREATE TABLE results.measure_167_conj_45 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_45 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_40.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_40.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_40.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_40.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,

     (SELECT results.measure_167_so_target_25.patient_id AS patient_id,
             results.measure_167_so_target_25.audit_key_value AS audit_key_value,
             results.measure_167_so_target_25.start_dt AS start_dt,
             results.measure_167_so_target_25.end_dt AS end_dt
      FROM results.measure_167_so_target_25) AS so_26,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND (CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) IS NULL
          OR CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = false)
     AND hqmf_cypress_ep.diagnostic_study_performed.start_dt >= so_26.start_dt
     AND hqmf_cypress_ep.diagnostic_study_performed.end_dt <= so_26.end_dt
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.value AS VARCHAR(256)) IN
       (SELECT CAST(
                    valuesets.code_lists.code AS VARCHAR(256)) AS anon_1
        FROM
        valuesets.code_lists
        WHERE
          valuesets.code_lists.code_list_id = '2.16.840.1.113883.3.526.3.1283')) AS dc_40 INTERSECT
SELECT anon_2.patient_id AS patient_id,
       anon_2.start_dt AS start_dt,
       anon_2.end_dt AS end_dt,
       anon_2.audit_key_value AS audit_key_value
FROM
  (SELECT results.measure_167_conj_44.patient_id AS patient_id,
          results.measure_167_conj_44.start_dt AS start_dt,
          results.measure_167_conj_44.end_dt AS end_dt,
          results.measure_167_conj_44.audit_key_value AS audit_key_value
   FROM results.measure_167_conj_44,
        results.measure_167_patient_base
   WHERE results.measure_167_conj_44.patient_id = results.measure_167_patient_base.base_patient_id) AS anon_2
;

CREATE INDEX ix_measure_167_conj_45_patient_id ON results.measure_167_conj_45 (patient_id)
;


CREATE TABLE results.measure_167_conj_49 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_49 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_47.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_47.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_47.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_47.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = true) AS dc_47
UNION
SELECT dc_48.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_48.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_48.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_48.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_2 ON code_lists_2.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_2.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = true) AS dc_48
;

CREATE INDEX ix_measure_167_conj_49_patient_id ON results.measure_167_conj_49 (patient_id)
;


CREATE TABLE results.measure_167_conj_52 (
	patient_id INTEGER, 
	start_dt TIMESTAMP WITHOUT TIME ZONE, 
	end_dt TIMESTAMP WITHOUT TIME ZONE, 
	audit_key_value BIGINT
)


;

INSERT INTO results.measure_167_conj_52 (patient_id, start_dt, end_dt, audit_key_value)
SELECT dc_50.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_50.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_50.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_50.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = true) AS dc_50
UNION
SELECT dc_51.hqmf_cypress_ep_diagnostic_study_performed_patient_id AS patient_id,
       dc_51.hqmf_cypress_ep_diagnostic_study_performed_start_dt AS start_dt,
       dc_51.hqmf_cypress_ep_diagnostic_study_performed_end_dt AS end_dt,
       dc_51.hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1 AS audit_key_value
FROM
  (SELECT hqmf_cypress_ep.diagnostic_study_performed.patient_id AS hqmf_cypress_ep_diagnostic_study_performed_patient_id,
          hqmf_cypress_ep.diagnostic_study_performed.start_dt AS hqmf_cypress_ep_diagnostic_study_performed_start_dt,
          hqmf_cypress_ep.diagnostic_study_performed.end_dt AS hqmf_cypress_ep_diagnostic_study_performed_end_dt,
          hqmf_cypress_ep.diagnostic_study_performed.audit_key_value AS hqmf_cypress_ep_diagnostic_study_performed_audit_key_valu_1
   FROM results.measure_167_patient_base,
        hqmf_cypress_ep.diagnostic_study_performed
   JOIN
   valuesets.code_lists AS code_lists_2 ON code_lists_2.code = hqmf_cypress_ep.diagnostic_study_performed.code
   AND code_lists_2.code_list_id = '2.16.840.1.113883.3.526.3.1251'
   WHERE hqmf_cypress_ep.diagnostic_study_performed.patient_id = results.measure_167_patient_base.base_patient_id
     AND CAST(hqmf_cypress_ep.diagnostic_study_performed.negation AS BOOLEAN) = true) AS dc_51
;

CREATE INDEX ix_measure_167_conj_52_patient_id ON results.measure_167_conj_52 (patient_id)
;

create or replace view results.measure_167_0_all as SELECT results.measure_167_patient_base.base_patient_id,
       results.measure_167_patient_base.so_26_audit_key_value,
       results.measure_167_patient_base.so_26_start_dt,
       results.measure_167_patient_base.so_26_end_dt,

  (SELECT EXISTS
     (SELECT anon_2.patient_id,
             anon_2.start_dt,
             anon_2.end_dt,
             anon_2.audit_key_value
      FROM
        (SELECT results.measure_167_conj_45.patient_id AS patient_id,
                results.measure_167_conj_45.start_dt AS start_dt,
                results.measure_167_conj_45.end_dt AS end_dt,
                results.measure_167_conj_45.audit_key_value AS audit_key_value
         FROM results.measure_167_conj_45
         WHERE results.measure_167_conj_45.patient_id = results.measure_167_patient_base.base_patient_id) AS anon_2) AS anon_1) AS numerator,

  (SELECT EXISTS
     (SELECT anon_4.patient_id,
             anon_4.start_dt,
             anon_4.end_dt,
             anon_4.audit_key_value
      FROM
        (SELECT results.measure_167_conj_52.patient_id AS patient_id,
                results.measure_167_conj_52.start_dt AS start_dt,
                results.measure_167_conj_52.end_dt AS end_dt,
                results.measure_167_conj_52.audit_key_value AS audit_key_value
         FROM results.measure_167_conj_52,

           (SELECT results.measure_167_so_target_25.patient_id AS patient_id,
                   results.measure_167_so_target_25.audit_key_value AS audit_key_value,
                   results.measure_167_so_target_25.start_dt AS start_dt,
                   results.measure_167_so_target_25.end_dt AS end_dt
            FROM results.measure_167_so_target_25) AS so_26
         WHERE results.measure_167_conj_52.patient_id = results.measure_167_patient_base.base_patient_id
           AND results.measure_167_conj_52.start_dt >= so_26.start_dt
           AND results.measure_167_conj_52.end_dt <= so_26.end_dt) AS anon_4) AS anon_3) AS "denominatorExceptions",

  (SELECT (EXISTS
             (SELECT dc_53.hqmf_cypress_ep_patient_characteristic_birthdate_patient__1,
                     dc_53.hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                     dc_53.hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                     dc_53.hqmf_cypress_ep_patient_characteristic_birthdate_audit_ke_2
              FROM
                (SELECT hqmf_cypress_ep.patient_characteristic_birthdate.patient_id AS hqmf_cypress_ep_patient_characteristic_birthdate_patient__1,
                        hqmf_cypress_ep.patient_characteristic_birthdate.start_dt AS hqmf_cypress_ep_patient_characteristic_birthdate_start_dt,
                        hqmf_cypress_ep.patient_characteristic_birthdate.end_dt AS hqmf_cypress_ep_patient_characteristic_birthdate_end_dt,
                        hqmf_cypress_ep.patient_characteristic_birthdate.audit_key_value AS hqmf_cypress_ep_patient_characteristic_birthdate_audit_ke_2
                 FROM hqmf_cypress_ep.patient_characteristic_birthdate
                 JOIN
                 valuesets.individual_code_map AS individual_code_map_1 ON individual_code_map_1.code = hqmf_cypress_ep.patient_characteristic_birthdate.code
                 AND individual_code_map_1.code_system_oid = '2.16.840.1.113883.6.1'
                 AND individual_code_map_1.measure_code = '21112-8'
                 WHERE hqmf_cypress_ep.patient_characteristic_birthdate.patient_id = results.measure_167_patient_base.base_patient_id
                   AND (CAST(hqmf_cypress_ep.patient_characteristic_birthdate.negation AS BOOLEAN) IS NULL
                        OR CAST(hqmf_cypress_ep.patient_characteristic_birthdate.negation AS BOOLEAN) = false)
                   AND hqmf_cypress_ep.patient_characteristic_birthdate.start_dt < CAST('2014-01-01T00:00:00' AS TIMESTAMP WITHOUT TIME ZONE)
                   AND year_delta(hqmf_cypress_ep.patient_characteristic_birthdate.start_dt, CAST('2014-01-01T00:00:00' AS TIMESTAMP WITHOUT TIME ZONE)) >= 18) AS dc_53))
   AND (EXISTS
          (SELECT dc_54.hqmf_cypress_ep_diagnosis_active_patient_id,
                  dc_54.hqmf_cypress_ep_diagnosis_active_start_dt,
                  dc_54.hqmf_cypress_ep_diagnosis_active_end_dt,
                  dc_54.hqmf_cypress_ep_diagnosis_active_audit_key_value
           FROM
             (SELECT hqmf_cypress_ep.diagnosis_active.patient_id AS hqmf_cypress_ep_diagnosis_active_patient_id,
                     hqmf_cypress_ep.diagnosis_active.start_dt AS hqmf_cypress_ep_diagnosis_active_start_dt,
                     hqmf_cypress_ep.diagnosis_active.end_dt AS hqmf_cypress_ep_diagnosis_active_end_dt,
                     hqmf_cypress_ep.diagnosis_active.audit_key_value AS hqmf_cypress_ep_diagnosis_active_audit_key_value
              FROM
                (SELECT results.measure_167_so_target_25.patient_id AS patient_id,
                        results.measure_167_so_target_25.audit_key_value AS audit_key_value,
                        results.measure_167_so_target_25.start_dt AS start_dt,
                        results.measure_167_so_target_25.end_dt AS end_dt
                 FROM results.measure_167_so_target_25) AS so_26,
                   hqmf_cypress_ep.diagnosis_active
              JOIN
              valuesets.code_lists AS code_lists_1 ON code_lists_1.code = hqmf_cypress_ep.diagnosis_active.code
              AND code_lists_1.code_list_id = '2.16.840.1.113883.3.526.3.327'
              WHERE hqmf_cypress_ep.diagnosis_active.patient_id = results.measure_167_patient_base.base_patient_id
                AND (CAST(hqmf_cypress_ep.diagnosis_active.negation AS BOOLEAN) IS NULL
                     OR CAST(hqmf_cypress_ep.diagnosis_active.negation AS BOOLEAN) = false)
                AND (hqmf_cypress_ep.diagnosis_active.end_dt >= so_26.start_dt
                     AND so_26.end_dt >= hqmf_cypress_ep.diagnosis_active.start_dt
                     OR hqmf_cypress_ep.diagnosis_active.start_dt <= so_26.end_dt
                     AND hqmf_cypress_ep.diagnosis_active.end_dt IS NULL
                     OR so_26.start_dt <= hqmf_cypress_ep.diagnosis_active.end_dt
                     AND so_26.end_dt IS NULL
                     OR hqmf_cypress_ep.diagnosis_active.start_dt IS NULL
                     AND hqmf_cypress_ep.diagnosis_active.end_dt IS NULL)) AS dc_54)) AS anon_5) AS "initialPopulation"
FROM results.measure_167_patient_base;

CREATE TABLE results.measure_167_0_patient_summary (
	patient_id INTEGER, 
	effective_ipp BOOLEAN, 
	effective_denom BOOLEAN, 
	effective_denex BOOLEAN, 
	effective_numer BOOLEAN, 
	effective_denexcep BOOLEAN
)


;

INSERT INTO results.measure_167_0_patient_summary (patient_id, effective_ipp, effective_denom, effective_denex, effective_numer, effective_denexcep) SELECT DISTINCT anon_1.patient_id, anon_1.effective_ipp, anon_1.effective_denom, anon_1.effective_denex, anon_1.effective_numer, anon_1.effective_denexcep 
FROM (SELECT base_patient_id AS patient_id, "initialPopulation" AS effective_ipp, "initialPopulation" AS effective_denom, CAST(NULL AS BOOLEAN) AS effective_denex, "initialPopulation" AND numerator AS effective_numer, CAST(NULL AS BOOLEAN) AS effective_denexcep, rank() OVER (PARTITION BY base_patient_id ORDER BY ("initialPopulation" AND numerator) DESC, "initialPopulation" DESC) AS rank 
FROM results.measure_167_0_all 
WHERE "initialPopulation") AS anon_1 
WHERE anon_1.rank = 1
;

