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
            AND table_name NOT LIKE 'enum_%'
    LOOP 
        v_sql := format (
        '
            CREATE OR REPLACE TRIGGER set_%s_%s_updated_at 
            BEFORE UPDATE ON %s.%s 
            FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
            COMMENT ON TRIGGER set_%s_%s_updated_at ON %s.%s IS %s;
        ',
            v_table.table_schema,
            v_table.table_name,
            v_table.table_schema,
            v_table.table_name,
            v_table.table_schema,
            v_table.table_name,
            v_table.table_schema,
            v_table.table_name,
            '''trigger to set value of column "updated_at" to current timestamp on row update'''
        );
        EXECUTE v_sql;
    END LOOP;
END;
$$;
-- updated_at trigger - end
