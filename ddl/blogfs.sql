CREATE TABLE public.blogfs
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    title character varying(40) NOT NULL,
    location character varying(40) NOT NULL,
    type integer NOT NULL,
    added timestamp with time zone NOT NULL,
    modified timestamp with time zone,
    published boolean NOT NULL,
    summary text,
    objectid integer,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.blogfs
    OWNER to postgres;
