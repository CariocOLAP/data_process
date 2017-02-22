CREATE ROLE user_tcc LOGIN
  SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;

CREATE SCHEMA IF NOT EXISTS dw AUTHORIZATION user_tcc;
CREATE SCHEMA IF NOT EXISTS stage AUTHORIZATION user_tcc;

create extension cube schema pg_catalog;
create extension earthdistance schema pg_catalog;



