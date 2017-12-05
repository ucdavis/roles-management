SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
-- Name: activity_log_tag_associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE activity_log_tag_associations (
    id integer NOT NULL,
    activity_log_id integer,
    activity_log_tag_id integer
);


--
-- Name: activity_log_tag_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activity_log_tag_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_log_tag_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activity_log_tag_associations_id_seq OWNED BY activity_log_tag_associations.id;


--
-- Name: activity_log_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE activity_log_tags (
    id integer NOT NULL,
    tag character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: activity_log_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activity_log_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_log_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activity_log_tags_id_seq OWNED BY activity_log_tags.id;


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE activity_logs (
    id integer NOT NULL,
    message character varying(255),
    performed_at timestamp without time zone,
    level integer
);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activity_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activity_logs_id_seq OWNED BY activity_logs.id;


--
-- Name: affiliation_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE affiliation_assignments (
    id integer NOT NULL,
    affiliation_id integer,
    person_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: affiliation_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE affiliation_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliation_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE affiliation_assignments_id_seq OWNED BY affiliation_assignments.id;


--
-- Name: affiliations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE affiliations (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: affiliations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE affiliations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE affiliations_id_seq OWNED BY affiliations.id;


--
-- Name: api_key_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_key_users (
    id integer NOT NULL,
    secret character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(255),
    logged_in_at timestamp without time zone
);


--
-- Name: api_key_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_key_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_key_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_key_users_id_seq OWNED BY api_key_users.id;


--
-- Name: api_whitelisted_ip_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE api_whitelisted_ip_users (
    id integer NOT NULL,
    address character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reason text,
    logged_in_at timestamp without time zone
);


--
-- Name: api_whitelisted_ip_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE api_whitelisted_ip_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_whitelisted_ip_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE api_whitelisted_ip_users_id_seq OWNED BY api_whitelisted_ip_users.id;


--
-- Name: application_ownerships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE application_ownerships (
    id integer NOT NULL,
    entity_id integer,
    application_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    parent_id integer
);


--
-- Name: application_manager_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE application_manager_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_manager_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE application_manager_assignments_id_seq OWNED BY application_ownerships.id;


--
-- Name: application_operatorships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE application_operatorships (
    id integer NOT NULL,
    application_id integer,
    entity_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    parent_id integer
);


--
-- Name: application_operatorships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE application_operatorships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_operatorships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE application_operatorships_id_seq OWNED BY application_operatorships.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE applications (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    url character varying(255)
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE applications_id_seq OWNED BY applications.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE departments (
    id bigint NOT NULL,
    code character varying NOT NULL,
    "officialName" character varying NOT NULL,
    "displayName" character varying NOT NULL,
    abbreviation character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departments_id_seq OWNED BY departments.id;


--
-- Name: entities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE entities (
    id integer NOT NULL,
    type character varying(255),
    name character varying(255),
    first character varying(255),
    last character varying(255),
    email character varying(255),
    loginid character varying(255),
    active boolean DEFAULT true,
    phone character varying(255),
    address character varying(255),
    title_id integer,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    logged_in_at timestamp without time zone,
    is_employee boolean,
    is_hs_employee boolean,
    is_faculty boolean,
    is_student boolean,
    is_staff boolean,
    is_external boolean,
    iam_id integer
);


--
-- Name: entities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE entities_id_seq OWNED BY entities.id;


--
-- Name: group_ownerships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_ownerships (
    id integer NOT NULL,
    group_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    entity_id integer
);


--
-- Name: group_manager_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_manager_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_manager_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_manager_assignments_id_seq OWNED BY group_ownerships.id;


--
-- Name: group_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_memberships (
    group_id integer,
    entity_id integer,
    id integer NOT NULL,
    calculated boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: group_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_memberships_id_seq OWNED BY group_memberships.id;


--
-- Name: group_operatorships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_operatorships (
    id integer NOT NULL,
    group_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    entity_id integer
);


--
-- Name: group_operatorships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_operatorships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_operatorships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_operatorships_id_seq OWNED BY group_operatorships.id;


--
-- Name: group_rule_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_rule_results (
    id integer NOT NULL,
    group_rule_set_id integer,
    entity_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_rule_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_rule_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_rule_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_rule_results_id_seq OWNED BY group_rule_results.id;


--
-- Name: group_rule_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_rule_sets (
    id bigint NOT NULL,
    "column" character varying,
    condition boolean,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_rule_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_rule_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_rule_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_rule_sets_id_seq OWNED BY group_rule_sets.id;


--
-- Name: group_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE group_rules (
    id integer NOT NULL,
    "column" character varying(255),
    condition character varying(255),
    value character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    group_id integer,
    group_rule_set_id integer
);


--
-- Name: group_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_rules_id_seq OWNED BY group_rules.id;


--
-- Name: majors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE majors (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: majors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE majors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: majors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE majors_id_seq OWNED BY majors.id;


--
-- Name: organization_entity_associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organization_entity_associations (
    id integer NOT NULL,
    organization_id integer,
    entity_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title_id integer
);


--
-- Name: organization_entity_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_entity_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_entity_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_entity_associations_id_seq OWNED BY organization_entity_associations.id;


--
-- Name: organization_managers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organization_managers (
    id integer NOT NULL,
    organization_id integer,
    manager_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organization_managers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_managers_id_seq OWNED BY organization_managers.id;


--
-- Name: organization_org_ids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organization_org_ids (
    id integer NOT NULL,
    organization_id integer,
    org_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organization_org_ids_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_org_ids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_org_ids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_org_ids_id_seq OWNED BY organization_org_ids.id;


--
-- Name: organization_parent_ids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organization_parent_ids (
    id integer NOT NULL,
    organization_id integer,
    parent_org_id integer DEFAULT 1,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organization_parent_ids_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organization_parent_ids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_parent_ids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organization_parent_ids_id_seq OWNED BY organization_parent_ids.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying(255),
    dept_code character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: person_favorite_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person_favorite_assignments (
    id integer NOT NULL,
    entity_id integer,
    owner_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: person_favorite_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE person_favorite_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_favorite_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE person_favorite_assignments_id_seq OWNED BY person_favorite_assignments.id;


--
-- Name: pps_associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pps_associations (
    id bigint NOT NULL,
    person_id integer NOT NULL,
    title_id integer NOT NULL,
    department_id integer NOT NULL,
    association_rank integer NOT NULL,
    position_type_code integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pps_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pps_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pps_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pps_associations_id_seq OWNED BY pps_associations.id;


--
-- Name: role_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE role_assignments (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role_id integer,
    entity_id integer,
    parent_id integer
);


--
-- Name: role_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE role_assignments_id_seq OWNED BY role_assignments.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE roles (
    id integer NOT NULL,
    token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    application_id integer,
    name character varying(255),
    description character varying(255),
    ad_path character varying(255),
    last_ad_sync timestamp without time zone,
    ad_guid character varying(255) DEFAULT NULL::character varying
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sis_associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sis_associations (
    id bigint NOT NULL,
    major_id integer,
    entity_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    level_code character varying(2),
    association_rank integer
);


--
-- Name: sis_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sis_associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sis_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sis_associations_id_seq OWNED BY sis_associations.id;


--
-- Name: titles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE titles (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    unit character varying(3)
);


--
-- Name: titles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE titles_id_seq OWNED BY titles.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE versions (
    id integer NOT NULL,
    versioned_id integer,
    versioned_type character varying(255),
    user_id integer,
    user_type character varying(255),
    user_name character varying(255),
    modifications text,
    number integer,
    reverted_from integer,
    tag character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: activity_log_tag_associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_log_tag_associations ALTER COLUMN id SET DEFAULT nextval('activity_log_tag_associations_id_seq'::regclass);


--
-- Name: activity_log_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_log_tags ALTER COLUMN id SET DEFAULT nextval('activity_log_tags_id_seq'::regclass);


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_logs ALTER COLUMN id SET DEFAULT nextval('activity_logs_id_seq'::regclass);


--
-- Name: affiliation_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliation_assignments ALTER COLUMN id SET DEFAULT nextval('affiliation_assignments_id_seq'::regclass);


--
-- Name: affiliations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliations ALTER COLUMN id SET DEFAULT nextval('affiliations_id_seq'::regclass);


--
-- Name: api_key_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_key_users ALTER COLUMN id SET DEFAULT nextval('api_key_users_id_seq'::regclass);


--
-- Name: api_whitelisted_ip_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_whitelisted_ip_users ALTER COLUMN id SET DEFAULT nextval('api_whitelisted_ip_users_id_seq'::regclass);


--
-- Name: application_operatorships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY application_operatorships ALTER COLUMN id SET DEFAULT nextval('application_operatorships_id_seq'::regclass);


--
-- Name: application_ownerships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY application_ownerships ALTER COLUMN id SET DEFAULT nextval('application_manager_assignments_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY applications ALTER COLUMN id SET DEFAULT nextval('applications_id_seq'::regclass);


--
-- Name: delayed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments ALTER COLUMN id SET DEFAULT nextval('departments_id_seq'::regclass);


--
-- Name: entities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY entities ALTER COLUMN id SET DEFAULT nextval('entities_id_seq'::regclass);


--
-- Name: group_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_memberships ALTER COLUMN id SET DEFAULT nextval('group_memberships_id_seq'::regclass);


--
-- Name: group_operatorships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_operatorships ALTER COLUMN id SET DEFAULT nextval('group_operatorships_id_seq'::regclass);


--
-- Name: group_ownerships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_ownerships ALTER COLUMN id SET DEFAULT nextval('group_manager_assignments_id_seq'::regclass);


--
-- Name: group_rule_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_rule_results ALTER COLUMN id SET DEFAULT nextval('group_rule_results_id_seq'::regclass);


--
-- Name: group_rule_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_rule_sets ALTER COLUMN id SET DEFAULT nextval('group_rule_sets_id_seq'::regclass);


--
-- Name: group_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_rules ALTER COLUMN id SET DEFAULT nextval('group_rules_id_seq'::regclass);


--
-- Name: majors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY majors ALTER COLUMN id SET DEFAULT nextval('majors_id_seq'::regclass);


--
-- Name: organization_entity_associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_entity_associations ALTER COLUMN id SET DEFAULT nextval('organization_entity_associations_id_seq'::regclass);


--
-- Name: organization_managers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_managers ALTER COLUMN id SET DEFAULT nextval('organization_managers_id_seq'::regclass);


--
-- Name: organization_org_ids id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_org_ids ALTER COLUMN id SET DEFAULT nextval('organization_org_ids_id_seq'::regclass);


--
-- Name: organization_parent_ids id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_parent_ids ALTER COLUMN id SET DEFAULT nextval('organization_parent_ids_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: person_favorite_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_favorite_assignments ALTER COLUMN id SET DEFAULT nextval('person_favorite_assignments_id_seq'::regclass);


--
-- Name: pps_associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pps_associations ALTER COLUMN id SET DEFAULT nextval('pps_associations_id_seq'::regclass);


--
-- Name: role_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_assignments ALTER COLUMN id SET DEFAULT nextval('role_assignments_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: sis_associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sis_associations ALTER COLUMN id SET DEFAULT nextval('sis_associations_id_seq'::regclass);


--
-- Name: titles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY titles ALTER COLUMN id SET DEFAULT nextval('titles_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: activity_log_tag_associations activity_log_tag_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_log_tag_associations
    ADD CONSTRAINT activity_log_tag_associations_pkey PRIMARY KEY (id);


--
-- Name: activity_log_tags activity_log_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_log_tags
    ADD CONSTRAINT activity_log_tags_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: affiliation_assignments affiliation_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliation_assignments
    ADD CONSTRAINT affiliation_assignments_pkey PRIMARY KEY (id);


--
-- Name: affiliations affiliations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_pkey PRIMARY KEY (id);


--
-- Name: api_key_users api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_key_users
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- Name: api_whitelisted_ip_users api_whitelisted_ips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY api_whitelisted_ip_users
    ADD CONSTRAINT api_whitelisted_ips_pkey PRIMARY KEY (id);


--
-- Name: application_ownerships application_manager_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY application_ownerships
    ADD CONSTRAINT application_manager_assignments_pkey PRIMARY KEY (id);


--
-- Name: application_operatorships application_operator_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY application_operatorships
    ADD CONSTRAINT application_operator_assignments_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: delayed_jobs delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (id);


--
-- Name: group_ownerships group_manager_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_ownerships
    ADD CONSTRAINT group_manager_assignments_pkey PRIMARY KEY (id);


--
-- Name: group_memberships group_member_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_memberships
    ADD CONSTRAINT group_member_assignments_pkey PRIMARY KEY (id);


--
-- Name: group_operatorships group_operator_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_operatorships
    ADD CONSTRAINT group_operator_assignments_pkey PRIMARY KEY (id);


--
-- Name: group_rule_results group_rule_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_rule_results
    ADD CONSTRAINT group_rule_results_pkey PRIMARY KEY (id);


--
-- Name: group_rule_sets group_rule_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_rule_sets
    ADD CONSTRAINT group_rule_sets_pkey PRIMARY KEY (id);


--
-- Name: group_rules group_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_rules
    ADD CONSTRAINT group_rules_pkey PRIMARY KEY (id);


--
-- Name: majors majors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY majors
    ADD CONSTRAINT majors_pkey PRIMARY KEY (id);


--
-- Name: organization_entity_associations organization_entity_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_entity_associations
    ADD CONSTRAINT organization_entity_associations_pkey PRIMARY KEY (id);


--
-- Name: organization_managers organization_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_managers
    ADD CONSTRAINT organization_managers_pkey PRIMARY KEY (id);


--
-- Name: organization_org_ids organization_org_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_org_ids
    ADD CONSTRAINT organization_org_ids_pkey PRIMARY KEY (id);


--
-- Name: organization_parent_ids organization_parent_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organization_parent_ids
    ADD CONSTRAINT organization_parent_ids_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: person_favorite_assignments person_manager_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_favorite_assignments
    ADD CONSTRAINT person_manager_assignments_pkey PRIMARY KEY (id);


--
-- Name: pps_associations pps_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pps_associations
    ADD CONSTRAINT pps_associations_pkey PRIMARY KEY (id);


--
-- Name: role_assignments role_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_assignments
    ADD CONSTRAINT role_assignments_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sis_associations sis_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sis_associations
    ADD CONSTRAINT sis_associations_pkey PRIMARY KEY (id);


--
-- Name: titles titles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titles
    ADD CONSTRAINT titles_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: idx_app_operatorships_on_app_id_and_entity_id_and_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_app_operatorships_on_app_id_and_entity_id_and_parent_id ON application_operatorships USING btree (application_id, entity_id, parent_id);


--
-- Name: index_affiliations_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_affiliations_on_name ON affiliations USING btree (name);


--
-- Name: index_api_key_users_on_name_and_secret; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_key_users_on_name_and_secret ON api_key_users USING btree (name, secret);


--
-- Name: index_api_whitelisted_ip_users_on_address; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_whitelisted_ip_users_on_address ON api_whitelisted_ip_users USING btree (address);


--
-- Name: index_applications_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_applications_on_name ON applications USING btree (name);


--
-- Name: index_entities_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entities_on_id ON entities USING btree (id);


--
-- Name: index_entities_on_loginid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entities_on_loginid ON entities USING btree (loginid);


--
-- Name: index_entities_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entities_on_name ON entities USING btree (name);


--
-- Name: index_entities_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entities_on_type ON entities USING btree (type);


--
-- Name: index_majors_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_majors_on_name ON majors USING btree (name);


--
-- Name: index_organization_managers_on_manager_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_managers_on_manager_id ON organization_managers USING btree (manager_id);


--
-- Name: index_organization_managers_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_managers_on_organization_id ON organization_managers USING btree (organization_id);


--
-- Name: index_organization_org_ids_on_org_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_org_ids_on_org_id ON organization_org_ids USING btree (org_id);


--
-- Name: index_organization_org_ids_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_org_ids_on_organization_id ON organization_org_ids USING btree (organization_id);


--
-- Name: index_organization_parent_ids_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_parent_ids_on_organization_id ON organization_parent_ids USING btree (organization_id);


--
-- Name: index_organization_parent_ids_on_parent_org_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_parent_ids_on_parent_org_id ON organization_parent_ids USING btree (parent_org_id);


--
-- Name: index_organizations_on_dept_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_dept_code ON organizations USING btree (dept_code);


--
-- Name: index_role_assignments_on_role_id_and_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_assignments_on_role_id_and_entity_id ON role_assignments USING btree (role_id, entity_id);


--
-- Name: index_role_assignments_on_role_id_and_entity_id_and_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_assignments_on_role_id_and_entity_id_and_parent_id ON role_assignments USING btree (role_id, entity_id, parent_id);


--
-- Name: index_roles_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_id ON roles USING btree (id);


--
-- Name: index_titles_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_titles_on_code ON titles USING btree (code);


--
-- Name: index_versions_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_created_at ON versions USING btree (created_at);


--
-- Name: index_versions_on_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_number ON versions USING btree (number);


--
-- Name: index_versions_on_tag; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_tag ON versions USING btree (tag);


--
-- Name: index_versions_on_user_id_and_user_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_user_id_and_user_type ON versions USING btree (user_id, user_type);


--
-- Name: index_versions_on_user_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_user_name ON versions USING btree (user_name);


--
-- Name: index_versions_on_versioned_id_and_versioned_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_versioned_id_and_versioned_type ON versions USING btree (versioned_id, versioned_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20110705231808'),
('20110705232234'),
('20110705233754'),
('20110705233802'),
('20110705233830'),
('20110706203805'),
('20110706205216'),
('20110707185914'),
('20110707192540'),
('20110707193119'),
('20110707193157'),
('20110707224852'),
('20110707224858'),
('20110713182509'),
('20110713185236'),
('20110713190442'),
('20110713191029'),
('20110713224114'),
('20110714175233'),
('20110714175452'),
('20110714212146'),
('20110714212739'),
('20110721202343'),
('20110721203315'),
('20110721203524'),
('20110721204228'),
('20110722204523'),
('20110722204634'),
('20110722215416'),
('20110722215915'),
('20110725022452'),
('20110725220911'),
('20110725221127'),
('20110725224135'),
('20110725224540'),
('20110725225032'),
('20110726213049'),
('20110726215822'),
('20110809183113'),
('20110809183201'),
('20110809183706'),
('20110809183917'),
('20110809192418'),
('20110809192622'),
('20110811230402'),
('20110815191320'),
('20110815193732'),
('20110816191321'),
('20110912210919'),
('20110912211726'),
('20110912221137'),
('20110914180827'),
('20110915201132'),
('20110916211450'),
('20110916222102'),
('20110916231520'),
('20110919185259'),
('20110919212931'),
('20110919213143'),
('20110927183439'),
('20111010200215'),
('20111017180322'),
('20111017180505'),
('20111018185439'),
('20111129004627'),
('20111129195818'),
('20111129200108'),
('20111129213054'),
('20111129213621'),
('20111129214001'),
('20111130194415'),
('20111130195628'),
('20111130204253'),
('20111130205014'),
('20111201201047'),
('20111209233227'),
('20111209235922'),
('20111210000838'),
('20111219190921'),
('20111221203346'),
('20111221235902'),
('20111222001235'),
('20120130211619'),
('20120210210931'),
('20120210211055'),
('20120214202147'),
('20120214213720'),
('20120214214550'),
('20120320195610'),
('20120327170024'),
('20120327172324'),
('20120327172532'),
('20120328191703'),
('20120330022905'),
('20120330183506'),
('20120330184453'),
('20120417080941'),
('20120417081104'),
('20120417081308'),
('20120417082816'),
('20120417083034'),
('20120417205722'),
('20120417223512'),
('20120417232742'),
('20120417233206'),
('20120418202616'),
('20120627190323'),
('20120710004746'),
('20120710184529'),
('20120710185121'),
('20120710194819'),
('20120710200138'),
('20120710211900'),
('20120719184105'),
('20120719184258'),
('20120719214438'),
('20120820202514'),
('20120830195252'),
('20120907220039'),
('20120920180934'),
('20120920182514'),
('20120920183326'),
('20120921202424'),
('20120925223544'),
('20120925223702'),
('20120925224547'),
('20120925231755'),
('20121002214938'),
('20121101211510'),
('20121102231326'),
('20121102231921'),
('20121102232431'),
('20121102232624'),
('20121103000925'),
('20121103235044'),
('20121105220612'),
('20121105222218'),
('20121105223718'),
('20121105224012'),
('20121210220541'),
('20121210220659'),
('20121217224332'),
('20130108000003'),
('20130206064347'),
('20130213232752'),
('20130213235417'),
('20130214025836'),
('20130315200349'),
('20130410220103'),
('20130515223442'),
('20130517201701'),
('20130524181332'),
('20130524190557'),
('20130529233715'),
('20130529233812'),
('20130618234552'),
('20130619000231'),
('20130619000919'),
('20130619003240'),
('20130619004048'),
('20130619185045'),
('20130619190036'),
('20130625000216'),
('20130702043936'),
('20130801211054'),
('20130807020938'),
('20130816020037'),
('20130822170844'),
('20130903183025'),
('20130903191922'),
('20130903220931'),
('20130913034216'),
('20130913034407'),
('20130913043851'),
('20131003221507'),
('20131003222310'),
('20131003233813'),
('20131017205406'),
('20131017210924'),
('20131106032345'),
('20131106033725'),
('20131106034234'),
('20131106034653'),
('20131106035243'),
('20131106035923'),
('20131106040101'),
('20140128193631'),
('20140128201637'),
('20140129221633'),
('20140129223722'),
('20140129231443'),
('20140129231852'),
('20140206190740'),
('20140206221454'),
('20140206221540'),
('20140207004659'),
('20140207004849'),
('20140207021029'),
('20140207023123'),
('20140214014726'),
('20140214015018'),
('20140227181541'),
('20140227181618'),
('20140307211801'),
('20140307213604'),
('20140320224546'),
('20140320225349'),
('20140320225522'),
('20140321005717'),
('20141120203425'),
('20150715180506'),
('20150716194554'),
('20150721190626'),
('20171019180618'),
('20171019181402'),
('20171019182132'),
('20171019221454'),
('20171020180823'),
('20171026174011'),
('20171026212019'),
('20171026212915'),
('20171030211820'),
('20171109234921'),
('20171127233800');


