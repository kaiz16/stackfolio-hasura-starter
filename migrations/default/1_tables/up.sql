CREATE TABLE types.user_roles (
    type text NOT NULL PRIMARY KEY CHECK (upper(type) = type),
    comment text
);

CREATE TABLE public.users (
    id UUID NOT NULL PRIMARY KEY REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    first_name TEXT NOT NULL,
    last_name TEXT,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    avatar_url TEXT,
    bio TEXT,
    is_deleted BOOLEAN DEFAULT FALSE,
    role TEXT NOT NULL REFERENCES types.user_roles(type) ON UPDATE CASCADE ON DELETE RESTRICT,
    suspended BOOLEAN DEFAULT FALSE,
    last_name_changed_at DATE,
    moderator_id UUID REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
COMMENT ON TABLE public.users IS 'Base type for all users.';
