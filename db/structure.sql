--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: checkins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE checkins (
    id integer NOT NULL,
    cohort_user_id integer NOT NULL,
    cohort_lesson_id integer NOT NULL,
    time_spent double precision,
    difficulty integer,
    feedback text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: checkins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE checkins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: checkins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE checkins_id_seq OWNED BY checkins.id;


--
-- Name: cohort_lessons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cohort_lessons (
    id integer NOT NULL,
    cohort_id integer NOT NULL,
    permalink character varying(255) NOT NULL,
    title character varying(255),
    "position" integer,
    repo character varying(255),
    discourse_thread_id integer
);


--
-- Name: cohort_lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cohort_lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cohort_lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cohort_lessons_id_seq OWNED BY cohort_lessons.id;


--
-- Name: cohort_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cohort_users (
    id integer NOT NULL,
    cohort_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: cohort_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cohort_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cohort_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cohort_users_id_seq OWNED BY cohort_users.id;


--
-- Name: cohorts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cohorts (
    id integer NOT NULL,
    permalink character varying(255) NOT NULL
);


--
-- Name: cohorts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cohorts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cohorts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cohorts_id_seq OWNED BY cohorts.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE courses (
    id integer NOT NULL,
    short_id character varying(255) NOT NULL,
    commit character varying(255),
    git_url character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lessons (
    id integer NOT NULL,
    course_id integer NOT NULL,
    short_id character varying(255) NOT NULL,
    commit character varying(40),
    "position" integer,
    title character varying(255),
    intro text,
    content text,
    deleted boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lessons_id_seq OWNED BY lessons.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: test_reports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE test_reports (
    id integer NOT NULL,
    user_id integer NOT NULL,
    project character varying(255) NOT NULL,
    suite character varying(255) NOT NULL,
    section character varying(255),
    code integer NOT NULL,
    created_at timestamp without time zone,
    stdout text
);


--
-- Name: test_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE test_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE test_reports_id_seq OWNED BY test_reports.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    github_id character varying(255) NOT NULL,
    github_data json,
    name character varying(255),
    email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    is_admin boolean,
    auth_token character varying(255) DEFAULT ''::character varying NOT NULL,
    discourse_username character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY checkins ALTER COLUMN id SET DEFAULT nextval('checkins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cohort_lessons ALTER COLUMN id SET DEFAULT nextval('cohort_lessons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cohort_users ALTER COLUMN id SET DEFAULT nextval('cohort_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cohorts ALTER COLUMN id SET DEFAULT nextval('cohorts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lessons ALTER COLUMN id SET DEFAULT nextval('lessons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY test_reports ALTER COLUMN id SET DEFAULT nextval('test_reports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: checkins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY checkins
    ADD CONSTRAINT checkins_pkey PRIMARY KEY (id);


--
-- Name: cohort_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cohort_lessons
    ADD CONSTRAINT cohort_lessons_pkey PRIMARY KEY (id);


--
-- Name: cohort_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cohort_users
    ADD CONSTRAINT cohort_users_pkey PRIMARY KEY (id);


--
-- Name: cohorts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cohorts
    ADD CONSTRAINT cohorts_pkey PRIMARY KEY (id);


--
-- Name: courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: test_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY test_reports
    ADD CONSTRAINT test_reports_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_checkins_on_cohort_user_id_and_cohort_lesson_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_checkins_on_cohort_user_id_and_cohort_lesson_id ON checkins USING btree (cohort_user_id, cohort_lesson_id);


--
-- Name: index_cohort_lessons_on_cohort_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cohort_lessons_on_cohort_id ON cohort_lessons USING btree (cohort_id);


--
-- Name: index_cohort_lessons_on_permalink_and_cohort_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_cohort_lessons_on_permalink_and_cohort_id ON cohort_lessons USING btree (permalink, cohort_id);


--
-- Name: index_cohorts_on_permalink; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_cohorts_on_permalink ON cohorts USING btree (permalink);


--
-- Name: index_courses_on_short_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_courses_on_short_id ON courses USING btree (short_id);


--
-- Name: index_lessons_on_course_id_and_short_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_lessons_on_course_id_and_short_id ON lessons USING btree (course_id, short_id);


--
-- Name: index_lessons_on_short_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lessons_on_short_id ON lessons USING btree (short_id);


--
-- Name: index_test_reports_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_reports_on_user_id ON test_reports USING btree (user_id);


--
-- Name: index_users_on_github_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_github_id ON users USING btree (github_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140312081334');

INSERT INTO schema_migrations (version) VALUES ('20140312142529');

INSERT INTO schema_migrations (version) VALUES ('20140314081239');

INSERT INTO schema_migrations (version) VALUES ('20140319084712');

INSERT INTO schema_migrations (version) VALUES ('20140319090709');

INSERT INTO schema_migrations (version) VALUES ('20140424141239');

INSERT INTO schema_migrations (version) VALUES ('20140425142832');

INSERT INTO schema_migrations (version) VALUES ('20140430014620');

INSERT INTO schema_migrations (version) VALUES ('20140430014749');

INSERT INTO schema_migrations (version) VALUES ('20140430032415');

INSERT INTO schema_migrations (version) VALUES ('20140504152211');

INSERT INTO schema_migrations (version) VALUES ('20140504162504');

INSERT INTO schema_migrations (version) VALUES ('20140505013322');

INSERT INTO schema_migrations (version) VALUES ('20140505020905');
