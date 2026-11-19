/* drop table statements */

DROP TABLE competitor CASCADE CONSTRAINTS PURGE;

DROP TABLE entry CASCADE CONSTRAINTS PURGE;

DROP TABLE team CASCADE CONSTRAINTS PURGE;

/* end of drop table statements*/

-- Create the COMPETITOR, ENTRY and TEAM tables
-- Ensure all column comments, and constraints (other than FK's)are included.
-- FK constraints are to be added at the end of this script

-- COMPETITOR
/* Add COMPETITOR attributes and data types */
CREATE TABLE
    competitor (
        comp_no NUMBER (5) NOT NULL,
        comp_fname VARCHAR2 (30),
        comp_lname VARCHAR2 (30),
        comp_gender CHAR(1) NOT NULL,
        comp_dob DATE NOT NULL,
        comp_email VARCHAR2 (50) NOT NULL,
        comp_unistatus CHAR(1) NOT NULL,
        comp_phone CHAR(10) NOT NULL
    );

COMMENT ON COLUMN competitor.comp_no IS 'Unique identifier for a competitor';

COMMENT ON COLUMN competitor.comp_fname IS 'Competitor first name';

COMMENT ON COLUMN competitor.comp_lname IS 'Competitor last name';

COMMENT ON COLUMN competitor.comp_gender IS 'Competitor gender (M, F, U)';

COMMENT ON COLUMN competitor.comp_dob IS 'Competitor date of birth';

COMMENT ON COLUMN competitor.comp_email IS 'Competitor email which is unique for each competitor';

COMMENT ON COLUMN competitor.comp_unistatus IS 'Competitor is a university student or staff (Y / N)';

COMMENT ON COLUMN competitor.comp_phone IS 'Competitor phone number which is unique for each competitor';

/* Add COMPETITOR constraints */
ALTER TABLE competitor ADD CONSTRAINT competitor_pk PRIMARY KEY (comp_no);

ALTER TABLE competitor ADD CONSTRAINT chk_comp_gender CHECK (comp_gender IN ('M', 'F', 'U'));

ALTER TABLE competitor ADD CONSTRAINT comp_email_uq UNIQUE (comp_email);

ALTER TABLE competitor ADD CONSTRAINT chk_comp_unistatus CHECK (comp_unistatus IN ('Y', 'N'));

ALTER TABLE competitor ADD CONSTRAINT comp_phone_uq UNIQUE (comp_phone);

--ENTRY
/* Add ENTRY attributes and data types */
CREATE TABLE
    entry (
        event_id NUMBER (6) NOT NULL,
        entry_no NUMBER (5) NOT NULL,
        entry_starttime DATE,
        entry_finishtime DATE,
        entry_elapsedtime DATE,
        comp_no NUMBER (5) NOT NULL,
        team_id NUMBER (3),
        char_id NUMBER (3)
    );

COMMENT ON COLUMN entry.event_id IS 'Event id - which is a surrogate primary key from EVENT table';

COMMENT ON COLUMN entry.entry_no IS 'Entry number which is unique only within an event';

COMMENT ON COLUMN entry.entry_starttime IS 'Entrant start time which is stored in hh24:mi:ss';

COMMENT ON COLUMN entry.entry_finishtime IS 'Entrant finish time which is stored in hh24:mi:ss';

COMMENT ON COLUMN entry.entry_elapsedtime IS 'Time that the entrant took to complete the event, which is stored in hh24:mi:ss';

COMMENT ON COLUMN entry.comp_no IS 'Unique identifier for a competitor from COMPETITOR table';

COMMENT ON COLUMN entry.team_id IS 'Team identifier from TEAM table';

COMMENT ON COLUMN entry.char_id IS 'Charity unique identifier from CHARITY table';

/* Add ENTRY constraints */
ALTER TABLE entry ADD CONSTRAINT entry_pk PRIMARY KEY (event_id, entry_no);

--TEAM
/* Add TEAM attributes and data types */
CREATE TABLE
    team (
        team_id NUMBER (3) NOT NULL,
        team_name VARCHAR2 (30) NOT NULL,
        carn_date DATE NOT NULL,
        event_id NUMBER (6) NOT NULL,
        entry_no NUMBER (5) NOT NULL
    );

COMMENT ON COLUMN team.team_id IS 'Team unique identifier';

COMMENT ON COLUMN team.team_name IS 'Team name';

COMMENT ON COLUMN team.carn_date IS 'Date of carnival (unique identifier) from CARNIVAL table';

COMMENT ON COLUMN team.event_id IS 'Event id - which is a surrogate primary key from EVENT table';

COMMENT ON COLUMN team.entry_no IS 'Entry number which is unique only within an event';

/* Add TEAM constraints */
ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY (team_id);

ALTER TABLE team ADD CONSTRAINT team_nk UNIQUE (team_name, carn_date);

-- Foreign key constraints

/* FK constraints for ENTRY table */
ALTER TABLE entry ADD CONSTRAINT event_entry_fk FOREIGN KEY (event_id) REFERENCES event (event_id);

ALTER TABLE entry ADD CONSTRAINT competitor_entry_fk FOREIGN KEY (comp_no) REFERENCES competitor (comp_no);

ALTER TABLE entry ADD CONSTRAINT team_entry_fk FOREIGN KEY (team_id) REFERENCES team (team_id);

ALTER TABLE entry ADD CONSTRAINT charity_entry_fk FOREIGN KEY (char_id) REFERENCES charity (char_id);

/* FK constraints for TEAM table */
ALTER TABLE team ADD CONSTRAINT carnival_team_fk FOREIGN KEY (carn_date) REFERENCES carnival (carn_date);

ALTER TABLE team ADD CONSTRAINT entry_team_fk FOREIGN KEY (event_id, entry_no) REFERENCES entry (event_id, entry_no);