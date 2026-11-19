/* Notes:
I used GitHub Copilot to assist me with the generation of the sample data. The tool was used to provide the data insertions for the COMPETITOR, ENTRY, and TEAM tables, as well as the UPDATE statements for team membership assignments. The output from this tool was modified by manually adjusting the data to meet the data requirements, including ensuring proper date formats (`dd-Mon-yyyy`), time formats (`hh24:mi:ss`), and logical relationships between entries, teams, and carnivals. Additionally, extra data was added to ensure all queries produce meaningful output as required.
 */

-- Load the COMPETITOR, ENTRY and TEAM tables with test data

-- COMPETITOR

-- Monash staff/students (Y)
INSERT INTO
    competitor
VALUES
    (
        1,
        'Alice',
        'Johnson',
        'F',
        to_date ('15-Mar-1995', 'dd-Mon-yyyy'),
        'alice.johnson@student.monash.edu',
        'Y',
        '0412345671'
    );

INSERT INTO
    competitor
VALUES
    (
        2,
        'Bob',
        'Wilson',
        'M',
        to_date ('22-Jul-1988', 'dd-Mon-yyyy'),
        'bob.wilson@student.monash.edu',
        'Y',
        '0412345672'
    );

INSERT INTO
    competitor
VALUES
    (
        3,
        'Carol',
        'Smith',
        'F',
        to_date ('08-Nov-1992', 'dd-Mon-yyyy'),
        'carol.smith@student.monash.edu',
        'Y',
        '0412345673'
    );

INSERT INTO
    competitor
VALUES
    (
        4,
        'David',
        'Brown',
        'M',
        to_date ('12-Apr-1990', 'dd-Mon-yyyy'),
        'david.brown@student.monash.edu',
        'Y',
        '0412345674'
    );

INSERT INTO
    competitor
VALUES
    (
        5,
        'Emma',
        'Davis',
        'F',
        to_date ('25-Sep-1997', 'dd-Mon-yyyy'),
        'emma.davis@student.monash.edu',
        'Y',
        '0412345675'
    );

INSERT INTO
    competitor
VALUES
    (
        6,
        'Frank',
        'Miller',
        'M',
        to_date ('03-Dec-1985', 'dd-Mon-yyyy'),
        'frank.miller@student.monash.edu',
        'Y',
        '0412345676'
    );

-- Non-Monash competitors (N)
INSERT INTO
    competitor
VALUES
    (
        7,
        'Grace',
        'Taylor',
        'F',
        to_date ('18-Jun-1993', 'dd-Mon-yyyy'),
        'grace.taylor@gmail.com',
        'N',
        '0412345677'
    );

INSERT INTO
    competitor
VALUES
    (
        8,
        'Henry',
        'Anderson',
        'M',
        to_date ('30-Jan-1987', 'dd-Mon-yyyy'),
        'henry.anderson@yahoo.com',
        'N',
        '0412345678'
    );

INSERT INTO
    competitor
VALUES
    (
        9,
        'Ivy',
        'Thomas',
        'F',
        to_date ('14-Aug-1991', 'dd-Mon-yyyy'),
        'ivy.thomas@outlook.com',
        'N',
        '0412345679'
    );

INSERT INTO
    competitor
VALUES
    (
        10,
        'Jack',
        'Jackson',
        'M',
        to_date ('07-May-1989', 'dd-Mon-yyyy'),
        'jack.jackson@hotmail.com',
        'N',
        '0412345680'
    );

INSERT INTO
    competitor
VALUES
    (
        11,
        'Kelly',
        'White',
        'F',
        to_date ('21-Oct-1994', 'dd-Mon-yyyy'),
        'kelly.white@gmail.com',
        'N',
        '0412345681'
    );

-- ====== ADDITIONAL/EXTRA DATA ======
INSERT INTO
    competitor
VALUES
    (
        12,
        'Liam',
        'Harris',
        'M',
        to_date ('28-Feb-1986', 'dd-Mon-yyyy'),
        'liam.harris@student.monash.edu',
        'Y',
        '0412345682'
    );

INSERT INTO
    competitor
VALUES
    (
        13,
        'Mia',
        'Clark',
        'F',
        to_date ('16-Jul-1996', 'dd-Mon-yyyy'),
        'mia.clark@icloud.com',
        'N',
        '0412345683'
    );

INSERT INTO
    competitor
VALUES
    (
        14,
        'Noah',
        'Lewis',
        'M',
        to_date ('09-Dec-1984', 'dd-Mon-yyyy'),
        'noah.lewis@company.com',
        'N',
        '0412345684'
    );

INSERT INTO
    competitor
VALUES
    (
        15,
        'Olivia',
        'Walker',
        'U',
        to_date ('03-Apr-1998', 'dd-Mon-yyyy'),
        'olivia.walker@student.monash.edu',
        'Y',
        '0412345685'
    );

-- ENTRY

-- Event 1: 5K on Sep 22, 2024 (event_id = 1) - CARNIVAL 1
INSERT INTO
    entry
VALUES
    (
        1,
        1,
        to_date ('09:30:00', 'hh24:mi:ss'),
        to_date ('10:05:30', 'hh24:mi:ss'),
        to_date ('00:35:30', 'hh24:mi:ss'),
        1,
        NULL,
        1
    );

INSERT INTO
    entry
VALUES
    (
        1,
        2,
        to_date ('09:30:15', 'hh24:mi:ss'),
        to_date ('10:08:45', 'hh24:mi:ss'),
        to_date ('00:38:30', 'hh24:mi:ss'),
        2,
        NULL,
        2
    );

INSERT INTO
    entry
VALUES
    (
        1,
        3,
        to_date ('09:30:30', 'hh24:mi:ss'),
        to_date ('10:02:15', 'hh24:mi:ss'),
        to_date ('00:31:45', 'hh24:mi:ss'),
        3,
        NULL,
        NULL
    );

INSERT INTO
    entry
VALUES
    (
        1,
        4,
        to_date ('09:31:00', 'hh24:mi:ss'),
        to_date ('10:12:30', 'hh24:mi:ss'),
        to_date ('00:41:30', 'hh24:mi:ss'),
        7,
        NULL,
        3
    );

INSERT INTO
    entry
VALUES
    (
        1,
        5,
        to_date ('09:31:15', 'hh24:mi:ss'),
        NULL,
        NULL,
        8,
        NULL,
        NULL
    );

-- First uncompleted entry

-- Event 2: 10K on Sep 22, 2024 (event_id = 2) - CARNIVAL 1
INSERT INTO
    entry
VALUES
    (
        2,
        1,
        to_date ('08:30:00', 'hh24:mi:ss'),
        to_date ('09:25:20', 'hh24:mi:ss'),
        to_date ('00:55:20', 'hh24:mi:ss'),
        4,
        NULL,
        1
    );

INSERT INTO
    entry
VALUES
    (
        2,
        2,
        to_date ('08:30:30', 'hh24:mi:ss'),
        to_date ('09:18:45', 'hh24:mi:ss'),
        to_date ('00:48:15', 'hh24:mi:ss'),
        5,
        NULL,
        4
    );

INSERT INTO
    entry
VALUES
    (
        2,
        3,
        to_date ('08:31:00', 'hh24:mi:ss'),
        to_date ('09:32:10', 'hh24:mi:ss'),
        to_date ('01:01:10', 'hh24:mi:ss'),
        6,
        NULL,
        NULL
    );

INSERT INTO
    entry
VALUES
    (
        2,
        4,
        to_date ('08:30:45', 'hh24:mi:ss'),
        to_date ('09:28:30', 'hh24:mi:ss'),
        to_date ('00:57:45', 'hh24:mi:ss'),
        9,
        NULL,
        2
    );

-- Event 3: 5K on Oct 5, 2024 (event_id = 3) - CARNIVAL 2
INSERT INTO
    entry
VALUES
    (
        3,
        1,
        to_date ('09:00:00', 'hh24:mi:ss'),
        to_date ('09:33:20', 'hh24:mi:ss'),
        to_date ('00:33:20', 'hh24:mi:ss'),
        1,
        NULL,
        3
    );

-- Competitor 1 in multiple events
INSERT INTO
    entry
VALUES
    (
        3,
        2,
        to_date ('09:00:15', 'hh24:mi:ss'),
        to_date ('09:36:45', 'hh24:mi:ss'),
        to_date ('00:36:30', 'hh24:mi:ss'),
        10,
        NULL,
        1
    );

INSERT INTO
    entry
VALUES
    (
        3,
        3,
        to_date ('09:00:30', 'hh24:mi:ss'),
        to_date ('09:39:15', 'hh24:mi:ss'),
        to_date ('00:38:45', 'hh24:mi:ss'),
        11,
        NULL,
        4
    );

INSERT INTO
    entry
VALUES
    (
        3,
        4,
        to_date ('09:01:00', 'hh24:mi:ss'),
        to_date ('09:42:30', 'hh24:mi:ss'),
        to_date ('00:41:30', 'hh24:mi:ss'),
        12,
        NULL,
        NULL
    );

-- Event 4: 10K on Oct 5, 2024 (event_id = 4) - CARNIVAL 2
INSERT INTO
    entry
VALUES
    (
        4,
        1,
        to_date ('08:30:00', 'hh24:mi:ss'),
        to_date ('09:22:15', 'hh24:mi:ss'),
        to_date ('00:52:15', 'hh24:mi:ss'),
        2,
        NULL,
        2
    );

-- Competitor 2 in multiple events
INSERT INTO
    entry
VALUES
    (
        4,
        2,
        to_date ('08:30:30', 'hh24:mi:ss'),
        to_date ('09:28:45', 'hh24:mi:ss'),
        to_date ('00:58:15', 'hh24:mi:ss'),
        13,
        NULL,
        3
    );

INSERT INTO
    entry
VALUES
    (
        4,
        3,
        to_date ('08:31:00', 'hh24:mi:ss'),
        to_date ('09:35:20', 'hh24:mi:ss'),
        to_date ('01:04:20', 'hh24:mi:ss'),
        14,
        NULL,
        1
    );

INSERT INTO
    entry
VALUES
    (
        4,
        4,
        to_date ('08:30:15', 'hh24:mi:ss'),
        NULL,
        NULL,
        15,
        NULL,
        NULL
    );

-- Second uncompleted entry

-- Event 5: 21K on Oct 5, 2024 (event_id = 5) - CARNIVAL 2
INSERT INTO
    entry
VALUES
    (
        5,
        1,
        to_date ('08:00:00', 'hh24:mi:ss'),
        to_date ('09:45:30', 'hh24:mi:ss'),
        to_date ('01:45:30', 'hh24:mi:ss'),
        3,
        NULL,
        4
    );

-- Competitor 3 in multiple events
INSERT INTO
    entry
VALUES
    (
        5,
        2,
        to_date ('08:00:30', 'hh24:mi:ss'),
        to_date ('09:52:15', 'hh24:mi:ss'),
        to_date ('01:51:45', 'hh24:mi:ss'),
        4,
        NULL,
        1
    );

-- Competitor 4 in multiple events
INSERT INTO
    entry
VALUES
    (
        5,
        3,
        to_date ('08:01:00', 'hh24:mi:ss'),
        to_date ('09:58:20', 'hh24:mi:ss'),
        to_date ('01:57:20', 'hh24:mi:ss'),
        5,
        NULL,
        2
    );

-- Competitor 5 in multiple events

-- Event 6: 3K on Feb 2, 2025 (event_id = 6) - CARNIVAL 3
INSERT INTO
    entry
VALUES
    (
        6,
        1,
        to_date ('08:30:00', 'hh24:mi:ss'),
        to_date ('08:52:30', 'hh24:mi:ss'),
        to_date ('00:22:30', 'hh24:mi:ss'),
        6,
        NULL,
        3
    );

-- Competitor 6 in multiple events

-- ====== ADDITIONAL/EXTRA DATA ======
INSERT INTO
    entry
VALUES
    (
        6,
        2,
        to_date ('08:30:15', 'hh24:mi:ss'),
        to_date ('08:55:45', 'hh24:mi:ss'),
        to_date ('00:25:30', 'hh24:mi:ss'),
        7,
        NULL,
        1
    );

-- Competitor 7 in multiple events
INSERT INTO
    entry
VALUES
    (
        6,
        3,
        to_date ('08:30:30', 'hh24:mi:ss'),
        to_date ('08:58:15', 'hh24:mi:ss'),
        to_date ('00:27:45', 'hh24:mi:ss'),
        8,
        NULL,
        4
    );

-- Competitor 8 in multiple events

-- Event 7: 5K on Feb 2, 2025 (event_id = 7) - CARNIVAL 3
INSERT INTO
    entry
VALUES
    (
        7,
        1,
        to_date ('08:30:00', 'hh24:mi:ss'),
        to_date ('09:04:15', 'hh24:mi:ss'),
        to_date ('00:34:15', 'hh24:mi:ss'),
        9,
        NULL,
        2
    );

-- Competitor 9 in multiple events
INSERT INTO
    entry
VALUES
    (
        7,
        2,
        to_date ('08:30:30', 'hh24:mi:ss'),
        to_date ('09:07:45', 'hh24:mi:ss'),
        to_date ('00:37:15', 'hh24:mi:ss'),
        10,
        NULL,
        3
    );

-- Competitor 10 in multiple events
INSERT INTO
    entry
VALUES
    (
        7,
        3,
        to_date ('08:31:00', 'hh24:mi:ss'),
        to_date ('09:11:30', 'hh24:mi:ss'),
        to_date ('00:40:30', 'hh24:mi:ss'),
        11,
        NULL,
        1
    );

-- Competitor 11 in multiple events

-- Event 8: 10K on Feb 2, 2025 (event_id = 8) - CARNIVAL 3
INSERT INTO
    entry
VALUES
    (
        8,
        1,
        to_date ('08:00:00', 'hh24:mi:ss'),
        to_date ('08:53:20', 'hh24:mi:ss'),
        to_date ('00:53:20', 'hh24:mi:ss'),
        12,
        NULL,
        4
    );

-- Competitor 12 in multiple events
INSERT INTO
    entry
VALUES
    (
        8,
        2,
        to_date ('08:00:30', 'hh24:mi:ss'),
        to_date ('08:58:45', 'hh24:mi:ss'),
        to_date ('00:58:15', 'hh24:mi:ss'),
        13,
        NULL,
        2
    );

-- Competitor 13 in multiple events
INSERT INTO
    entry
VALUES
    (
        8,
        3,
        to_date ('08:01:00', 'hh24:mi:ss'),
        to_date ('09:03:15', 'hh24:mi:ss'),
        to_date ('01:02:15', 'hh24:mi:ss'),
        14,
        NULL,
        3
    );

-- Competitor 14 in multiple events
INSERT INTO
    entry
VALUES
    (
        8,
        4,
        to_date ('08:00:15', 'hh24:mi:ss'),
        to_date ('08:55:30', 'hh24:mi:ss'),
        to_date ('00:55:15', 'hh24:mi:ss'),
        15,
        NULL,
        1
    );

-- Competitor 15 in multiple events

-- TEAM

-- Team 1: "Speedsters" in Sep 22, 2024 carnival (managed by entry 1,1)
INSERT INTO
    team
VALUES
    (
        1,
        'Speedsters',
        to_date ('22-Sep-2024', 'dd-Mon-yyyy'),
        1,
        1
    );

-- Team 2: "Thunder Bolts" in Oct 5, 2024 carnival (managed by entry 3,1)
INSERT INTO
    team
VALUES
    (
        2,
        'Thunder Bolts',
        to_date ('05-Oct-2024', 'dd-Mon-yyyy'),
        3,
        1
    );

-- Team 3: "Lightning Runners" in Oct 5, 2024 carnival (managed by entry 4,1)
INSERT INTO
    team
VALUES
    (
        3,
        'Lightning Runners',
        to_date ('05-Oct-2024', 'dd-Mon-yyyy'),
        4,
        1
    );

-- Team 4: "Speedsters" in Feb 2, 2025 carnival (managed by entry 6,1) - SAME NAME, DIFFERENT CARNIVAL
INSERT INTO
    team
VALUES
    (
        4,
        'Speedsters',
        to_date ('02-Feb-2025', 'dd-Mon-yyyy'),
        6,
        1
    );

-- Team 5: "Storm Chasers" in Feb 2, 2025 carnival (managed by entry 7,1)
INSERT INTO
    team
VALUES
    (
        5,
        'Storm Chasers',
        to_date ('02-Feb-2025', 'dd-Mon-yyyy'),
        7,
        1
    );

-- ====== TEAM MEMBERSHIP ASSIGNMENTS ======
-- Updating entries to create teams with multiple members
-- Team 1 "Speedsters" (Sep 22) - 3 members
UPDATE entry
SET
    team_id = 1
WHERE
    event_id = 1
    AND entry_no = 1;

-- Alice (manager) - TEAM 1 MEMBER 1
UPDATE entry
SET
    team_id = 1
WHERE
    event_id = 1
    AND entry_no = 2;

-- Bob - TEAM 1 MEMBER 2
UPDATE entry
SET
    team_id = 1
WHERE
    event_id = 2
    AND entry_no = 1;

-- David (in different event) - TEAM 1 MEMBER 3

-- Team 2 "Thunder Bolts" (Oct 5) - MULTIPLE MEMBERS
UPDATE entry
SET
    team_id = 2
WHERE
    event_id = 3
    AND entry_no = 1;

-- Alice (manager, in multiple events) - TEAM 2 MEMBER 1
UPDATE entry
SET
    team_id = 2
WHERE
    event_id = 3
    AND entry_no = 2;

-- Jack - TEAM 2 MEMBER 2
UPDATE entry
SET
    team_id = 2
WHERE
    event_id = 4
    AND entry_no = 1;

-- Bob (in multiple events) - TEAM 2 MEMBER 3
UPDATE entry
SET
    team_id = 2
WHERE
    event_id = 5
    AND entry_no = 1;

-- Carol (in multiple events) - TEAM 2 MEMBER 4

-- ====== ADDITIONAL/EXTRA TEAMS AND MEMBERSHIPS ======
-- Team 3 "Lightning Runners" (Oct 5) - 2 members
UPDATE entry
SET
    team_id = 3
WHERE
    event_id = 4
    AND entry_no = 1;

-- Bob (manager, but already in team 2 - will override) - TEAM 3 MEMBER 1
UPDATE entry
SET
    team_id = 3
WHERE
    event_id = 5
    AND entry_no = 2;

-- David (in multiple events) - TEAM 3 MEMBER 2

-- Team 4 "Speedsters" (Feb 2) - 3 members (same name as team 1, different carnival)
UPDATE entry
SET
    team_id = 4
WHERE
    event_id = 6
    AND entry_no = 1;

-- Frank (manager) - TEAM 4 MEMBER 1
UPDATE entry
SET
    team_id = 4
WHERE
    event_id = 6
    AND entry_no = 2;

-- Grace (in multiple events) - TEAM 4 MEMBER 2
UPDATE entry
SET
    team_id = 4
WHERE
    event_id = 7
    AND entry_no = 1;

-- Henry (in multiple events) - TEAM 4 MEMBER 3

-- Team 5 "Storm Chasers" (Feb 2) - 2 members
UPDATE entry
SET
    team_id = 5
WHERE
    event_id = 7
    AND entry_no = 1;

-- Henry (manager, but already in team 4 - will override) - TEAM 5 MEMBER 1
UPDATE entry
SET
    team_id = 5
WHERE
    event_id = 8
    AND entry_no = 1;

-- Liam (in multiple events) - TEAM 5 MEMBER 2

COMMIT;