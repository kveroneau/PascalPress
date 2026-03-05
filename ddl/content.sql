CREATE TABLE public.content
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    title character varying(80),
    content text NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.content
    OWNER to postgres;
