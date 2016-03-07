
BULK INSERT valuesets.hqmf_code_lists 
FROM 'C:\Users\yury.bekker\Projects\ephir_queries\code_lists_1.csv' 
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

BULK INSERT valuesets.individual_code_map_Eph 
FROM 'C:\Users\yury.bekker\Projects\ephir_queries\individual_code_map_1.csv' 
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a');

/*
select * from valuesets.code_lists
where code_list_id = '2.16.840.1.113883.3.464.1003.101.12.1024'
*/