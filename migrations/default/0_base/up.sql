CREATE SCHEMA IF NOT EXISTS types;
CREATE SCHEMA IF NOT EXISTS public;
SET check_function_bodies = false;
SET TIMEZONE='etc/UTC';
CREATE OR REPLACE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
SET check_function_bodies = true;