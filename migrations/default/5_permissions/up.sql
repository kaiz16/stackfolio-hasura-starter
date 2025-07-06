GRANT USAGE ON SCHEMA public TO authenticated, anon, service_role;
GRANT ALL ON SCHEMA public to authenticated, anon, service_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public to authenticated, anon, service_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO authenticated, anon, service_role;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO authenticated, anon, service_role;