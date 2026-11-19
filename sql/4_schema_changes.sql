--(a)
-- Show the structure of the COMPETITOR table before modification
DESC competitor;

-- Show original data in the COMPETITOR table before modification
SELECT
    *
FROM
    competitor
ORDER BY
    comp_no;

-- Add a new column to COMPETITOR table to store the number of completed events
ALTER TABLE competitor ADD comp_completed_events NUMBER (3, 0) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN competitor.comp_completed_events IS 'Number of completed events by the competitor';

-- Populate the new column based on the current data in the database
UPDATE competitor
SET
    comp_completed_events = (
        SELECT
            COUNT(*)
        FROM
            entry e
        WHERE
            e.comp_no = competitor.comp_no
            AND e.entry_finishtime IS NOT NULL
    );

COMMIT;

-- Show the structure of the COMPETITOR table after modification
DESC competitor;

-- Show changes made to the COMPETITOR table
SELECT
    *
FROM
    competitor
ORDER BY
    comp_no;

--(b)

-- Drop existing ENTRYCHARITY table if it exists
DROP TABLE entrycharity CASCADE CONSTRAINTS PURGE;

-- Create new table to handle multiple charity support per entry
CREATE TABLE
    entrycharity (
        entrycharity_id NUMBER (6) NOT NULL,
        event_id NUMBER (6) NOT NULL,
        entry_no NUMBER (5) NOT NULL,
        char_id NUMBER (3) NOT NULL,
        donate_percentage NUMBER (3) NOT NULL
    );

COMMENT ON COLUMN entrycharity.entrycharity_id IS 'Entry charity id (surrogate primary key)';

COMMENT ON COLUMN entrycharity.event_id IS 'Event id from EVENT table';

COMMENT ON COLUMN entrycharity.entry_no IS 'Entry number which is unique only within an event';

COMMENT ON COLUMN entrycharity.char_id IS 'Charity unique identifier from CHARITY table';

COMMENT ON COLUMN entrycharity.donate_percentage IS 'Percentage (0-100) of funds allocated to this charity for this entry';

-- Add constraints to ENTRYCHARITY table
ALTER TABLE entrycharity ADD CONSTRAINT entrycharity_pk PRIMARY KEY (entrycharity_id);

ALTER TABLE entrycharity ADD CONSTRAINT entrycharity_nk UNIQUE (event_id, entry_no, char_id);

-- Check constraint
ALTER TABLE entrycharity ADD CONSTRAINT chk_donate_percentage CHECK (donate_percentage BETWEEN 0 AND 100);

-- Add FK Constraints
ALTER TABLE entrycharity ADD CONSTRAINT entry_entrycharity_fk FOREIGN KEY (event_id, entry_no) REFERENCES entry (event_id, entry_no);

ALTER TABLE entrycharity ADD CONSTRAINT charity_entrycharity_fk FOREIGN KEY (char_id) REFERENCES charity (char_id);

-- Drop existing sequence if it exists
DROP SEQUENCE entrycharity_seq;

-- Create sequence for surrogate primary key
CREATE SEQUENCE entrycharity_seq START
WITH
    1 INCREMENT BY 1;

-- Show the structure of the ENTRY and new ENTRYCHARITY tables before migrating data
DESC entry;

DESC entrycharity;

-- Show current data in ENTRY table before migration
SELECT
    event_id,
    entry_no,
    lpad (to_char (entry_starttime, 'hh24:mi:ss'), 16) AS entry_start_time,
    lpad (to_char (entry_finishtime, 'hh24:mi:ss'), 17) AS entry_finish_time,
    lpad (to_char (entry_elapsedtime, 'hh24:mi:ss'), 18) AS entry_elapsed_time,
    comp_no,
    team_id,
    char_id
FROM
    entry
ORDER BY
    event_id,
    entry_no;

-- Show current data in ENTRYCHARITY table before migration (should be empty)
SELECT
    *
FROM
    entrycharity
ORDER BY
    entrycharity_id;

-- Migrate existing data from ENTRY table to ENTRYCHARITY table
-- For entries that have a charity, set them to 100% allocation
INSERT INTO
    entrycharity (
        entrycharity_id,
        event_id,
        entry_no,
        char_id,
        donate_percentage
    )
SELECT
    entrycharity_seq.NEXTVAL,
    event_id,
    entry_no,
    char_id,
    100
FROM
    entry
WHERE
    char_id IS NOT NULL;

COMMIT;

-- Remove the char_id column from ENTRY table as it is now in ENTRYCHARITY
ALTER TABLE entry
DROP CONSTRAINT charity_entry_fk;

ALTER TABLE entry
DROP COLUMN char_id;

-- Show any table structural changes that have occurred
DESC entry;

DESC entrycharity;

-- Show any data changes that have occurred
SELECT
    event_id,
    entry_no,
    lpad (to_char (entry_starttime, 'hh24:mi:ss'), 16) AS entry_start_time,
    lpad (to_char (entry_finishtime, 'hh24:mi:ss'), 17) AS entry_finish_time,
    lpad (to_char (entry_elapsedtime, 'hh24:mi:ss'), 18) AS entry_elapsed_time,
    comp_no,
    team_id
FROM
    entry
ORDER BY
    event_id,
    entry_no;

SELECT
    *
FROM
    entrycharity
ORDER BY
    entrycharity_id;