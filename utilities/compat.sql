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
   elseif element_type = 'dd' then
      select cast('day' as text) into retval;
   elseif element_type = 'mm' then
      select cast('month' as text) into retval;
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

create or replace function datediff(text, date, date) returns integer as $$
DECLARE
   raw_element_type alias for $1;
   d1 alias for $2;
   d2 alias for $3;
   element_type text;
   retval integer;
BEGIN
   select date_part_translation(raw_element_type) into element_type;
   if element_type = 'year' then
      select cast(date_part(element_type, age($3, $2)) as integer) into retval;
   elseif element_type = 'day' then
      select d2 - d1 into retval;
   elseif element_type = 'month' then
      select (cast(date_part('year', age($3, $2)) as integer) * 12) +
              cast(date_part('month', age($3, $2)) as integer) into retval;
   else
      RAISE 'unknown date part (%)', element_type;
   end if;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function datediff(text, text, date) returns integer as $$
DECLARE
   retval integer;
BEGIN
   select datediff($1, $2::date, $3) into retval;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function datediff(text, text, timestamp) returns integer as $$
DECLARE
   retval integer;
BEGIN
   select datediff($1, $2::date, $3::date) into retval;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function datediff(text, text, timestamp with time zone) returns integer as $$
DECLARE
   retval integer;
BEGIN
   select datediff($1, $2::date, $3::date) into retval;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function datediff(text, text, text) returns integer as $$
DECLARE
   retval integer;
BEGIN
   select datediff($1, $2::date, $3::date) into retval;
   return retval;
END
$$ LANGUAGE 'plpgsql' immutable;

create or replace function year(date) returns integer as $$
   select date_part('year', ($1))::integer
$$ LANGUAGE SQL;

create or replace function year(text) returns integer as $$
   select date_part('year', ($1)::date)::integer
$$ LANGUAGE SQL;
