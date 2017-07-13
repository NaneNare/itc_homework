--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: obj_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE obj_type AS ENUM (
    'human',
    'animal',
    'car'
);


ALTER TYPE public.obj_type OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE user_role AS ENUM (
    'admin',
    'simple'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: camera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE camera (
    camera_name character varying NOT NULL,
    location character varying NOT NULL,
    on_off boolean,
    description character varying,
    last_run_date date NOT NULL
);


ALTER TABLE public.camera OWNER TO postgres;

--
-- Name: traffic; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE traffic (
    id integer NOT NULL,
    camera_name character varying NOT NULL,
    date date NOT NULL,
    images_album_path path NOT NULL,
    object_type obj_type
);


ALTER TABLE public.traffic OWNER TO postgres;

--
-- Name: traffic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE traffic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.traffic_id_seq OWNER TO postgres;

--
-- Name: traffic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE traffic_id_seq OWNED BY traffic.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    email character varying NOT NULL,
    name character varying NOT NULL,
    role user_role NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY traffic ALTER COLUMN id SET DEFAULT nextval('traffic_id_seq'::regclass);


--
-- Data for Name: camera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY camera (camera_name, location, on_off, description, last_run_date) FROM stdin;
\.


--
-- Data for Name: traffic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY traffic (id, camera_name, date, images_album_path, object_type) FROM stdin;
\.


--
-- Name: traffic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('traffic_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (email, name, role) FROM stdin;
\.


--
-- Name: camera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY camera
    ADD CONSTRAINT camera_pkey PRIMARY KEY (camera_name);


--
-- Name: traffic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY traffic
    ADD CONSTRAINT traffic_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: traffic_camera_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY traffic
    ADD CONSTRAINT traffic_camera_name_fkey FOREIGN KEY (camera_name) REFERENCES camera(camera_name);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

