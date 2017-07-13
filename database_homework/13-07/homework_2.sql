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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: exams; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE exams (
    id integer NOT NULL,
    student_id integer NOT NULL,
    subject_id integer NOT NULL,
    score integer
);


ALTER TABLE public.exams OWNER TO postgres;

--
-- Name: exams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE exams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exams_id_seq OWNER TO postgres;

--
-- Name: exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE exams_id_seq OWNED BY exams.id;


--
-- Name: itc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE itc (
    id integer NOT NULL,
    itc character varying NOT NULL
);


ALTER TABLE public.itc OWNER TO postgres;

--
-- Name: itc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE itc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itc_id_seq OWNER TO postgres;

--
-- Name: itc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE itc_id_seq OWNED BY itc.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    name character varying NOT NULL,
    surname character varying NOT NULL,
    itc_id integer NOT NULL
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subjects (
    id integer NOT NULL,
    title character varying NOT NULL
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjects_id_seq OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;


--
-- Name: task_1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW task_1 AS
 SELECT students.name,
    students.surname,
    itc.itc,
    avg(exams.score) AS avg
   FROM ((exams
     JOIN students ON ((exams.student_id = students.id)))
     JOIN itc ON ((students.itc_id = itc.id)))
  GROUP BY students.name, students.surname, itc.itc;


ALTER TABLE public.task_1 OWNER TO postgres;

--
-- Name: task_2; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW task_2 AS
 SELECT students.name,
    students.surname,
    itc.itc,
    min(exams.score) AS min,
    max(exams.score) AS max,
    avg(exams.score) AS avg,
    count(DISTINCT itc.itc) AS count
   FROM ((exams
     JOIN students ON ((exams.student_id = students.id)))
     JOIN itc ON ((students.itc_id = itc.id)))
  GROUP BY students.name, students.surname, itc.itc;


ALTER TABLE public.task_2 OWNER TO postgres;

--
-- Name: task_3; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW task_3 AS
 SELECT itc.itc,
    subjects.title,
    max(exams.score) AS max,
    min(exams.score) AS min,
    count(exams.score) AS count
   FROM (((exams
     JOIN students ON ((exams.student_id = students.id)))
     JOIN itc ON ((students.itc_id = itc.id)))
     JOIN subjects ON ((exams.subject_id = subjects.id)))
  GROUP BY subjects.title, itc.itc;


ALTER TABLE public.task_3 OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exams ALTER COLUMN id SET DEFAULT nextval('exams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY itc ALTER COLUMN id SET DEFAULT nextval('itc_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY exams (id, student_id, subject_id, score) FROM stdin;
1	1	1	8
2	2	1	9
3	3	2	7
4	4	3	6
5	1	2	5
6	4	2	9
7	2	2	7
8	3	3	10
\.


--
-- Name: exams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('exams_id_seq', 8, true);


--
-- Data for Name: itc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY itc (id, itc) FROM stdin;
1	ITC-1
2	ITC-2
3	ITC-3
4	ITC-4
5	ITC-5
6	ITC6
7	ITC-7
8	ITC-8
\.


--
-- Name: itc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('itc_id_seq', 8, true);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY students (id, name, surname, itc_id) FROM stdin;
1	Khachik	Ghazaryan	8
2	Vrezh	Unanyan	6
3	Nelli	Melkonyan	8
4	Albert	Aghajanyan	8
5	Poxos	Poxosyan	4
6	Petros	Petrosyan	5
7	Nane	Nare	1
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('students_id_seq', 7, true);


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subjects (id, title) FROM stdin;
1	c++
2	Python
3	Bash
4	HTML/CSS
5	JS
\.


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('subjects_id_seq', 5, true);


--
-- Name: exams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (id);


--
-- Name: itc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY itc
    ADD CONSTRAINT itc_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: exams_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_student_id_fkey FOREIGN KEY (student_id) REFERENCES students(id);


--
-- Name: exams_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES subjects(id);


--
-- Name: students_itc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_itc_id_fkey FOREIGN KEY (itc_id) REFERENCES itc(id);


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

