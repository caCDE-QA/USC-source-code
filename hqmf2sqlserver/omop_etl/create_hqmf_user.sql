:r defaults.sql

CREATE LOGIN @hqmfuser WITH PASSWORD=N'hQTQRUtYdXzDoxnRLfOY3IEzsSwD7BPn9pmi94VTpI8=', DEFAULT_DATABASE=@valueset_schema, DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON;

CREATE USER @hqmfuser FOR LOGIN @hqmfuser WITH DEFAULT_SCHEMA=@valueset_schema;
/*
grant usage on schema :omop_schema to :hqmfuser;
grant select on all tables in schema :omop_schema to :hqmfuser;
grant usage on schema :omop_vocab_schema to :hqmfuser;
grant select on all tables in schema :omop_vocab_schema to :hqmfuser;
grant create on database :database to :hqmfuser;
*/