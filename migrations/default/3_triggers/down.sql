-- updated_at trigger - start
DO $$
DECLARE v_table record;
DECLARE v_sql text;
BEGIN
    FOR v_table IN 
        SELECT *
        FROM information_schema.tables
        WHERE 
            table_schema = 'public'
            AND table_type <> 'VIEW'
            AND table_name <> 'profiles' -- supabase default table
    LOOP 
        v_sql := format (
        '
            DROP TRIGGER set_%s_%s_updated_at 
            ON %s.%s;
        ',
            v_table.table_schema,
            v_table.table_name,
            v_table.table_schema,
            v_table.table_name
        );
        EXECUTE v_sql;
    END LOOP;
END;
$$;
-- updated_at trigger - end
