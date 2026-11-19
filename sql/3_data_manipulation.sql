--(a)
DROP SEQUENCE competitor_seq;

DROP SEQUENCE team_seq;

CREATE SEQUENCE competitor_seq START
WITH
    100 INCREMENT BY 5;

CREATE SEQUENCE team_seq START
WITH
    100 INCREMENT BY 5;

--(b)
-- Insert Keith Rose (phone number: 0422141112) which is a Monash student
INSERT INTO
    competitor
VALUES
    (
        competitor_seq.nextval,
        'Keith',
        'Rose',
        'M',
        to_date ('15-Mar-2003', 'dd-Mon-yyyy'),
        'keith.rose@student.monash.edu',
        'Y',
        '0422141112'
    );

-- Insert Jackson Bull (phone number: 0422412524) which is a Monash student
INSERT INTO
    competitor
VALUES
    (
        competitor_seq.nextval,
        'Jackson',
        'Bull',
        'M',
        to_date ('20-Aug-2005', 'dd-Mon-yyyy'),
        'jackson.bull@student.monash.edu',
        'Y',
        '0422412524'
    );

-- Insert entry for Keith Rose (10 km run, Salvation Army)
INSERT INTO
    entry (
        event_id,
        entry_no,
        entry_starttime,
        entry_finishtime,
        entry_elapsedtime,
        comp_no,
        team_id,
        char_id
    )
VALUES
    (
        (
            SELECT
                e.event_id
            FROM
                event e
                JOIN carnival c ON e.carn_date = c.carn_date
                JOIN eventtype et ON e.eventtype_code = et.eventtype_code
            WHERE
                UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
        ),
        (
            SELECT
                NVL (MAX(entry_no), 0) + 1
            FROM
                entry
            WHERE
                event_id = (
                    SELECT
                        e.event_id
                    FROM
                        event e
                        JOIN carnival c ON e.carn_date = c.carn_date
                        JOIN eventtype et ON e.eventtype_code = et.eventtype_code
                    WHERE
                        UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                        AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
                )
        ),
        NULL,
        NULL,
        NULL,
        (
            SELECT
                comp_no
            FROM
                competitor
            WHERE
                UPPER(comp_fname) = UPPER('Keith')
                AND UPPER(comp_lname) = UPPER('Rose')
                AND comp_phone = '0422141112'
        ),
        NULL,
        (
            SELECT
                char_id
            FROM
                charity
            WHERE
                UPPER(char_name) = UPPER('Salvation Army')
        )
    );

-- Insert entry for Jackson Bull (10 km run, RSPCA)
INSERT INTO
    entry (
        event_id,
        entry_no,
        entry_starttime,
        entry_finishtime,
        entry_elapsedtime,
        comp_no,
        team_id,
        char_id
    )
VALUES
    (
        (
            SELECT
                e.event_id
            FROM
                event e
                JOIN carnival c ON e.carn_date = c.carn_date
                JOIN eventtype et ON e.eventtype_code = et.eventtype_code
            WHERE
                UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
        ),
        (
            SELECT
                NVL (MAX(entry_no), 0) + 1
            FROM
                entry
            WHERE
                event_id = (
                    SELECT
                        e.event_id
                    FROM
                        event e
                        JOIN carnival c ON e.carn_date = c.carn_date
                        JOIN eventtype et ON e.eventtype_code = et.eventtype_code
                    WHERE
                        UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                        AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
                )
        ),
        NULL,
        NULL,
        NULL,
        (
            SELECT
                comp_no
            FROM
                competitor
            WHERE
                UPPER(comp_fname) = UPPER('Jackson')
                AND UPPER(comp_lname) = UPPER('Bull')
                AND comp_phone = '0422412524'
        ),
        NULL,
        (
            SELECT
                char_id
            FROM
                charity
            WHERE
                UPPER(char_name) = UPPER('RSPCA')
        )
    );

-- Form Super Runners team with Keith as team leader
INSERT INTO
    team (team_id, team_name, carn_date, event_id, entry_no)
VALUES
    (
        team_seq.NEXTVAL,
        'Super Runners',
        (
            SELECT
                carn_date
            FROM
                carnival
            WHERE
                UPPER(carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
        ),
        (
            SELECT
                e.event_id
            FROM
                event e
                JOIN carnival c ON e.carn_date = c.carn_date
                JOIN eventtype et ON e.eventtype_code = et.eventtype_code
            WHERE
                UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
        ),
        (
            SELECT
                entry_no
            FROM
                entry
            WHERE
                comp_no = (
                    SELECT
                        comp_no
                    FROM
                        competitor
                    WHERE
                        UPPER(comp_fname) = UPPER('Keith')
                        AND UPPER(comp_lname) = UPPER('Rose')
                        AND comp_phone = '0422141112'
                )
                AND event_id = (
                    SELECT
                        e.event_id
                    FROM
                        event e
                        JOIN carnival c ON e.carn_date = c.carn_date
                        JOIN eventtype et ON e.eventtype_code = et.eventtype_code
                    WHERE
                        UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                        AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
                )
        )
    );

-- Update Keith's entry to assign team (Keith as team leader)
UPDATE entry
SET
    team_id = (
        SELECT
            team_id
        FROM
            team
        WHERE
            UPPER(team_name) = UPPER('Super Runners')
            AND carn_date = (
                SELECT
                    carn_date
                FROM
                    carnival
                WHERE
                    UPPER(carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            )
    )
WHERE
    comp_no = (
        SELECT
            comp_no
        FROM
            competitor
        WHERE
            UPPER(comp_fname) = UPPER('Keith')
            AND UPPER(comp_lname) = UPPER('Rose')
            AND comp_phone = '0422141112'
    )
    AND event_id = (
        SELECT
            e.event_id
        FROM
            event e
            JOIN carnival c ON e.carn_date = c.carn_date
            JOIN eventtype et ON e.eventtype_code = et.eventtype_code
        WHERE
            UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
    );

-- Update Jackson's entry to assign team (Jackson as team member)
UPDATE entry
SET
    team_id = (
        SELECT
            team_id
        FROM
            team
        WHERE
            UPPER(team_name) = UPPER('Super Runners')
            AND carn_date = (
                SELECT
                    carn_date
                FROM
                    carnival
                WHERE
                    UPPER(carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            )
    )
WHERE
    comp_no = (
        SELECT
            comp_no
        FROM
            competitor
        WHERE
            UPPER(comp_fname) = UPPER('Jackson')
            AND UPPER(comp_lname) = UPPER('Bull')
            AND comp_phone = '0422412524'
    )
    AND event_id = (
        SELECT
            e.event_id
        FROM
            event e
            JOIN carnival c ON e.carn_date = c.carn_date
            JOIN eventtype et ON e.eventtype_code = et.eventtype_code
        WHERE
            UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
    );

COMMIT;

--(c)
-- Insert Jackson Bull's new 5 km entry with Beyond Blue
INSERT INTO
    entry (
        event_id,
        entry_no,
        entry_starttime,
        entry_finishtime,
        entry_elapsedtime,
        comp_no,
        team_id,
        char_id
    )
VALUES
    (
        (
            SELECT
                e.event_id
            FROM
                event e
                JOIN carnival c ON e.carn_date = c.carn_date
                JOIN eventtype et ON e.eventtype_code = et.eventtype_code
            WHERE
                UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                AND UPPER(et.eventtype_desc) = UPPER('5 Km Run')
        ),
        (
            SELECT
                NVL (MAX(entry_no), 0) + 1
            FROM
                entry
            WHERE
                event_id = (
                    SELECT
                        e.event_id
                    FROM
                        event e
                        JOIN carnival c ON e.carn_date = c.carn_date
                        JOIN eventtype et ON e.eventtype_code = et.eventtype_code
                    WHERE
                        UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                        AND UPPER(et.eventtype_desc) = UPPER('5 Km Run')
                )
        ),
        NULL,
        NULL,
        NULL,
        (
            SELECT
                comp_no
            FROM
                competitor
            WHERE
                UPPER(comp_fname) = UPPER('Jackson')
                AND UPPER(comp_lname) = UPPER('Bull')
                AND comp_phone = '0422412524'
        ),
        (
            SELECT
                team_id
            FROM
                team
            WHERE
                UPPER(team_name) = UPPER('Super Runners')
                AND carn_date = (
                    SELECT
                        carn_date
                    FROM
                        carnival
                    WHERE
                        UPPER(carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                )
        ),
        (
            SELECT
                char_id
            FROM
                charity
            WHERE
                UPPER(char_name) = UPPER('Beyond Blue')
        )
    );

-- Delete Jackson's old 10 km entry
DELETE FROM entry
WHERE
    comp_no = (
        SELECT
            comp_no
        FROM
            competitor
        WHERE
            UPPER(comp_fname) = UPPER('Jackson')
            AND UPPER(comp_lname) = UPPER('Bull')
            AND comp_phone = '0422412524'
    )
    AND event_id = (
        SELECT
            e.event_id
        FROM
            event e
            JOIN carnival c ON e.carn_date = c.carn_date
            JOIN eventtype et ON e.eventtype_code = et.eventtype_code
        WHERE
            UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
    );

COMMIT;

--(d)
-- Update team to reference Jackson's 5km entry instead of Keith's 10km entry
UPDATE team
SET
    event_id = (
        SELECT
            e.event_id
        FROM
            event e
            JOIN carnival c ON e.carn_date = c.carn_date
            JOIN eventtype et ON e.eventtype_code = et.eventtype_code
        WHERE
            UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            AND UPPER(et.eventtype_desc) = UPPER('5 Km Run')
    ),
    entry_no = (
        SELECT
            entry_no
        FROM
            entry
        WHERE
            comp_no = (
                SELECT
                    comp_no
                FROM
                    competitor
                WHERE
                    UPPER(comp_fname) = UPPER('Jackson')
                    AND UPPER(comp_lname) = UPPER('Bull')
                    AND comp_phone = '0422412524'
            )
            AND event_id = (
                SELECT
                    e.event_id
                FROM
                    event e
                    JOIN carnival c ON e.carn_date = c.carn_date
                    JOIN eventtype et ON e.eventtype_code = et.eventtype_code
                WHERE
                    UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
                    AND UPPER(et.eventtype_desc) = UPPER('5 Km Run')
            )
    )
WHERE
    UPPER(team_name) = UPPER('Super Runners')
    AND carn_date = (
        SELECT
            carn_date
        FROM
            carnival
        WHERE
            UPPER(carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
    );

-- Delete Keith's entry from the 10km run
DELETE FROM entry
WHERE
    comp_no = (
        SELECT
            comp_no
        FROM
            competitor
        WHERE
            UPPER(comp_fname) = UPPER('Keith')
            AND UPPER(comp_lname) = UPPER('Rose')
            AND comp_phone = '0422141112'
    )
    AND event_id = (
        SELECT
            e.event_id
        FROM
            event e
            JOIN carnival c ON e.carn_date = c.carn_date
            JOIN eventtype et ON e.eventtype_code = et.eventtype_code
        WHERE
            UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            AND UPPER(et.eventtype_desc) = UPPER('10 Km Run')
    );

-- Update Jackson's entry to remove team assignment (becomes individual runner)
UPDATE entry
SET
    team_id = NULL
WHERE
    comp_no = (
        SELECT
            comp_no
        FROM
            competitor
        WHERE
            UPPER(comp_fname) = UPPER('Jackson')
            AND UPPER(comp_lname) = UPPER('Bull')
            AND comp_phone = '0422412524'
    )
    AND event_id = (
        SELECT
            e.event_id
        FROM
            event e
            JOIN carnival c ON e.carn_date = c.carn_date
            JOIN eventtype et ON e.eventtype_code = et.eventtype_code
        WHERE
            UPPER(c.carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
            AND UPPER(et.eventtype_desc) = UPPER('5 Km Run')
    );

-- Delete Super Runners team
DELETE FROM team
WHERE
    UPPER(team_name) = UPPER('Super Runners')
    AND carn_date = (
        SELECT
            carn_date
        FROM
            carnival
        WHERE
            UPPER(carn_name) = UPPER('RM WINTER SERIES CAULFIELD 2025')
    );

COMMIT;