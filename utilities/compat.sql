create or replace function getdate() returns date as $$
  select cast(now() as date)
$$ LANGUAGE SQL;

-- This could just be a table
create or replace function date_part_translation(text) returns text as $$
DECLARE
   element_type alias for $1;
   retval text;
BEGIN
   if element_type = 'yy' then
      select cast('year' as text) into retval;
   else
      RAISE 'unknown date part (%)', element_type;
   end if;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function dateadd(text, integer, date) returns date as $$
DECLARE
   raw_element_type alias for $1;
   num alias for $2;
   base_date alias for $3;
   element_type text;
   interval_string text;
   retval date;
BEGIN
   select date_part_translation(raw_element_type) into element_type;
   select cast($2 as text) || ' ' || element_type into interval_string;
   execute 'select $1' || ' + interval ''' || interval_string || '''' using base_date 
   into retval;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function datediff(text, numeric, date) returns integer as $$
   select cast(date_part(date_part_translation($1), ($3)) - ($2) as integer)
$$ LANGUAGE SQL;
