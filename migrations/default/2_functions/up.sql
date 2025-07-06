CREATE OR REPLACE FUNCTION public.lowercase_and_replace_spaces(v_string TEXT)
RETURNS TEXT AS $$
BEGIN
    RETURN LOWER(REPLACE(v_string, ' ', '_'));
END;
$$ LANGUAGE PLPGSQL STABLE;

-- Trigger function to delete user from auth.users table when public.users is deleted
CREATE OR REPLACE FUNCTION public.delete_auth_user_on_public_user_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM auth.users WHERE id = OLD.id;
    RETURN OLD;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION public.jwt_hook(event JSONB)
RETURNS JSONB
LANGUAGE plpgsql AS $$
DECLARE
    v_claims JSONB;
    v_user_id TEXT;
    v_hasura_claims JSONB;
BEGIN
    -- Get the claims from the event
    v_claims := event->'claims';
    v_user_id := v_claims->>'sub';

    -- Check if 'https://hasura.io/jwt/claims' exists in claims
    IF JSONB_TYPEOF(v_claims->'https://hasura.io/jwt/claims') IS NULL THEN
        -- Base hasura claims (will be merged dynamically)
        IF v_claims->'user_metadata'->>'role' = 'USER' THEN
            v_hasura_claims := jsonb_build_object(
                'x-hasura-default-role', 'user',
                'x-hasura-allowed-roles', '["user"]'::jsonb,
                'x-hasura-user-id', v_user_id
            );
        ELSIF v_claims->'user_metadata'->>'role' = 'AGENT' THEN
            v_hasura_claims := jsonb_build_object(
                'x-hasura-default-role', 'agent',
                'x-hasura-allowed-roles', '["agent"]'::jsonb,
                'x-hasura-user-id', v_user_id
            );
        ELSIF v_claims->'user_metadata'->>'role' = 'ADMIN' THEN
            v_hasura_claims := jsonb_build_object(
                'x-hasura-default-role', 'admin',
                'x-hasura-allowed-roles', '["admin"]'::jsonb,
                'x-hasura-user-id', v_user_id
            );
        END IF;

        -- Insert the dynamically built claims into the JWT
        v_claims := JSONB_SET(v_claims, '{https://hasura.io/jwt/claims}', v_hasura_claims);
        event := JSONB_SET(event, '{claims}', v_claims);
    END IF;

    -- Return the modified or original event
    RETURN event;
END;
$$;

CREATE OR REPLACE FUNCTION public.users_full_name(user_row users)
RETURNS TEXT AS $$
  SELECT user_row.first_name || ' ' || user_row.last_name
$$ LANGUAGE sql STABLE;
