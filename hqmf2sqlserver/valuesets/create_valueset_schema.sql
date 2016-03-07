:r defaults.sql

EXEC ('CREATE SCHEMA '+@valueset_schema+';');
--set search_path = :valueset_schema;
EXEC ('ALTER USER '+@hqmfuser + ' SET DEFAULT SCHEMA = '+@valueset_schema+';');
