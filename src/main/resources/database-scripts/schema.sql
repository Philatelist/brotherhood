/*==============================================================*/
/* DBMS name:      PostgreSQL 9                                 */
/* Created on:     11/15/2017                                   */
/*==============================================================*/

DROP TABLE IF EXISTS Permission CASCADE;

DROP INDEX IF EXISTS AK_ROLE, AK_USER CASCADE;

DROP DOMAIN IF EXISTS E_TIMESTAMP, PRIMARY_ID, STATUS,
TABLENAME, XMLDEFPATH, XMLVERSION;

DROP SEQUENCE IF EXISTS S_PERMISSION_SEQ CASCADE;

CREATE SEQUENCE S_PERMISSION_SEQ;


/*==============================================================*/
/* Domain: E_TIMESTAMP                                          */
/*==============================================================*/
CREATE DOMAIN E_TIMESTAMP AS TIMESTAMP;

/*==============================================================*/
/* Domain: PRIMARY_ID                                           */
/*==============================================================*/
CREATE DOMAIN PRIMARY_ID AS NUMERIC;

/*==============================================================*/
/* Domain: STATUS                                               */
/*==============================================================*/

CREATE DOMAIN STATUS AS NUMERIC(1);

COMMENT ON DOMAIN STATUS IS
'0 - active, -1 - deleted';

/*==============================================================*/
/* Domain: TABLENAME                                            */
/*==============================================================*/
CREATE DOMAIN TABLENAME AS VARCHAR(32);

/*==============================================================*/
/* Domain: XMLDEFPATH                                           */
/*==============================================================*/
CREATE DOMAIN XMLDEFPATH AS VARCHAR(200);

COMMENT ON DOMAIN XMLDEFPATH IS
'Full path nane for XML definishion of object';

/*==============================================================*/
/* Domain: XMLVERSION                                           */
/*==============================================================*/
CREATE DOMAIN XMLVERSION AS NUMERIC(5);

/*==============================================================*/
/* Table: Permission                                            */
/*==============================================================*/
CREATE TABLE Permission (
  ID          BIGINT      NOT NULL DEFAULT NEXTVAL('s_permission_seq'),
  ROLE_ID     BIGINT,
  TYPE        NUMERIC(2)  NOT NULL DEFAULT 0,
  NAME        VARCHAR(64) NOT NULL,
  ACCESS_FLAG VARCHAR(1)  NOT NULL,
  OBJECT      VARCHAR(64) NOT NULL
    CONSTRAINT CKC_BOBJECT_DEF_PATH_S_PERMIS CHECK (OBJECT IN
                                                    ('Profile', 'User', 'Group', 'Event', 'Calendar', 'Feed', 'Accept', 'Denied', 'Location', 'Password', 'Permission',
                                                     'Relationship', 'Role')),
  SYS_STATUS  NUMERIC(1)  NOT NULL DEFAULT 0,
  CREATE_DTM  TIMESTAMP   NOT NULL DEFAULT NOW(),
  MODIFY_DTM  TIMESTAMP   NULL,
  CONSTRAINT PK_PERMISSION PRIMARY KEY (ID)
);

COMMENT ON COLUMN Permission.TYPE IS 'static(0)/dynamic(1)';

COMMENT ON COLUMN Permission.ACCESS_FLAG IS 'C/R/W/D (Create, Read, Write, Delete)';

-- ALTER TABLE Permission
-- ADD CONSTRAINT FK_PERMISSION_ROLE FOREIGN KEY (ROLE_ID)
-- REFERENCES Role (ID)
  -- ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ON DELETE CASCADE ON UPDATE CASCADE;
