SET SERVEROUTPUT ON

SET ECHO ON

--(a)

-- Create a function to calculate the elapsed time.
-- The function must take the start time and finish time as input parameters, and return the elapsed time.

-- Create function:
-- finish it with a slash(/) followed by a blank line

CREATE OR REPLACE FUNCTION calc_elapsedtime(f_entry_starttime IN DATE, f_entry_finishtime IN DATE)
    RETURN DATE
    IS v_entry_elapsedtime NUMBER;
    BEGIN
        v_entry_elapsedtime := f_entry_finishtime - f_entry_starttime;
        RETURN (to_date ('00:00:00', 'hh24:mi:ss') + v_entry_elapsedtime);
    END;
/

-- Write Test Harness for (a)

-- test case 1
-- test function with various sample time combinations
SELECT
    lpad (
        to_char (
            calc_elapsedtime (
                to_date ('09:00:00', 'hh24:mi:ss'),
                to_date ('09:30:00', 'hh24:mi:ss')
            ),
            'hh24:mi:ss'
        ),
        10
    ) AS test_30min,
    lpad (
        to_char (
            calc_elapsedtime (
                to_date ('08:30:00', 'hh24:mi:ss'),
                to_date ('09:15:00', 'hh24:mi:ss')
            ),
            'hh24:mi:ss'
        ),
        10
    ) AS test_45min,
    lpad (
        to_char (
            calc_elapsedtime (
                to_date ('10:15:00', 'hh24:mi:ss'),
                to_date ('11:45:00', 'hh24:mi:ss')
            ),
            'hh24:mi:ss'
        ),
        10
    ) AS test_90min,
    lpad (
        to_char (
            calc_elapsedtime (
                to_date ('07:00:00', 'hh24:mi:ss'),
                to_date ('09:30:00', 'hh24:mi:ss')
            ),
            'hh24:mi:ss'
        ),
        11
    ) AS test_150min
FROM
    dual;

-- test case 2
-- test function with actual entry data from database
SELECT
    event_id,
    entry_no,
    lpad (to_char (entry_starttime, 'hh24:mi:ss'), 16) AS entry_start_time,
    lpad (to_char (entry_finishtime, 'hh24:mi:ss'), 17) AS entry_finish_time,
    lpad (
        to_char (
            calc_elapsedtime (entry_starttime, entry_finishtime),
            'hh24:mi:ss'
        ),
        18
    ) AS entry_elapsed_time,
    comp_no,
    team_id
FROM
    entry
WHERE
    entry_starttime IS NOT NULL
    AND entry_finishtime IS NOT NULL
ORDER BY
    event_id,
    entry_no;

-- End of Test Harness

--(b)

-- From this point onwards, RM wants to automatically maintain elapsed time and ensure other data consistency/integrity when a runner has completed an event.
-- Create one trigger to implement this business rule.

-- Create trigger:
-- finish it with a slash(/) followed by a blank line

CREATE OR REPLACE TRIGGER trg_maintain_elapsed_time
    BEFORE UPDATE OF entry_finishtime ON entry
    FOR EACH ROW
BEGIN
    -- ensure data integrity when runner completes the event
    IF :new.entry_finishtime IS NOT NULL THEN
        -- start time must exist
        IF :new.entry_starttime IS NULL THEN
            raise_application_error (-20001, 'Start time must be recorded before finish time');
        END IF;

        -- finish time must be after start time
        IF :new.entry_finishtime <= :new.entry_starttime THEN
            raise_application_error (-20002, 'Finish time must be after start time');
        END IF;

        -- automatically calculate elapsed time
        :new.entry_elapsedtime := calc_elapsedtime(:new.entry_starttime, :new.entry_finishtime);

        dbms_output.put_line ('Runner has completed the event and elapsed time are automatically calculated for entry ' || :new.entry_no);
    END IF;
END;
/

-- Write Test Harness for (b)

-- before value
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
WHERE
    event_id = 1
    AND entry_no = 1;

-- test trigger - update - success case 1
BEGIN
    UPDATE entry
    SET
        entry_finishtime = to_date ('09:45:30', 'hh24:mi:ss')
    WHERE
        event_id = 1
        AND entry_no = 1;
END;
/

-- after value
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
WHERE
    event_id = 1
    AND entry_no = 1;

-- test trigger - update - success case 2
BEGIN
    UPDATE entry
    SET
        entry_finishtime = to_date ('10:30:15', 'hh24:mi:ss')
    WHERE
        event_id = 1
        AND entry_no = 1;
END;
/

-- after value
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
WHERE
    event_id = 1
    AND entry_no = 1;

-- test trigger - update - error case 1 (finish time before start time)
BEGIN
    UPDATE entry
    SET
        entry_finishtime = to_date ('08:00:00', 'hh24:mi:ss')
    WHERE
        event_id = 1
        AND entry_no = 1;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line ('Expected error caught: ' || SQLERRM);
END;
/

-- after value (verify no change)
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
WHERE
    event_id = 1
    AND entry_no = 1;

-- test trigger - update - error case 2 (missing start time)
BEGIN
    UPDATE entry
    SET
        entry_starttime = NULL,
        entry_finishtime = to_date ('11:00:00', 'hh24:mi:ss')
    WHERE
        event_id = 1
        AND entry_no = 1;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line ('Expected error caught: ' || SQLERRM);
END;
/

-- after value (verify no change)
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
WHERE
    event_id = 1
    AND entry_no = 1;

-- closes transaction
ROLLBACK;

-- End of Test Harness

--(c)

-- Write one stored procedure called prc_entry_registration that handles the registration of a competitor for an event in a carnival (i.e. an entry).
-- The procedure must only handle one registration at a time.

-- You must also consider these additional business rules:
    -- each competitor can only nominate one charity when they register for the event
    -- if the inputted team name does not exist, a new team will be created, and the competitor's details will be stored as the team leader
    -- if the inputted team name exists in the system, the competitor is included as a member of the existing team.

-- The procedure requires:
    -- Five input parameters (you must not change the parameter order)
        -- 1. competitor number
        -- 2. carnival name (e.g. RM WINTER SERIES CAULFIELD 2025)
        -- 3. event type description (e.g. 5 km Run)
        -- 4. team name (e.g. Super Runners)
        -- 5. supported charity name (e.g. Amnesty International)
    -- One output parameter

-- Create procedure:
-- finish it with a slash(/) followed by a blank line

CREATE OR REPLACE PROCEDURE prc_entry_registration (
    p_comp_no IN NUMBER,
    p_carn_name IN VARCHAR2,
    p_eventtype_desc IN VARCHAR2,
    p_team_name IN VARCHAR2,
    p_char_name IN VARCHAR2,
    p_output OUT VARCHAR2
) IS
    var_comp_found NUMBER;
    var_carn_found NUMBER;
    var_event_found NUMBER;
    var_char_found NUMBER;
    var_existing_registration NUMBER;
    var_team_found NUMBER;
    var_event_id NUMBER;
    var_char_id NUMBER;
    var_team_id NUMBER;
    var_entry_no NUMBER;
    var_carn_date DATE;
BEGIN
    -- Validate competitor exists
    SELECT
        COUNT(*) INTO var_comp_found
    FROM
        competitor
    WHERE
        comp_no = p_comp_no;

    IF (var_comp_found = 0) THEN
        p_output := 'Invalid competitor number, registration cancelled';
    ELSE
        -- Validate carnival exists and get carnival date
        BEGIN
            SELECT
                COUNT(*),
                MAX(carn_date) INTO var_carn_found,
                var_carn_date
            FROM
                carnival
            WHERE
                UPPER(carn_name) = UPPER(p_carn_name);
        END;

        IF (var_carn_found = 0) THEN
            p_output := 'Invalid carnival name, registration cancelled';
        ELSE
            -- Validate event exists in this carnival
            BEGIN
                SELECT
                    COUNT(*),
                    MAX(e.event_id) INTO var_event_found,
                    var_event_id
                FROM
                    event e
                    JOIN carnival c ON e.carn_date = c.carn_date
                    JOIN eventtype et ON e.eventtype_code = et.eventtype_code
                WHERE
                    UPPER(c.carn_name) = UPPER(p_carn_name)
                    AND UPPER(et.eventtype_desc) = UPPER(p_eventtype_desc);
            END;

            IF (var_event_found = 0) THEN
                p_output := 'Invalid event type for this carnival, registration cancelled';
            ELSE
                -- Validate charity exists
                BEGIN
                    SELECT
                        COUNT(*),
                        MAX(char_id) INTO var_char_found,
                        var_char_id
                    FROM
                        charity
                    WHERE
                        UPPER(char_name) = UPPER(p_char_name);
                END;

                IF (var_char_found = 0) THEN
                    p_output := 'Invalid charity name, registration cancelled';
                ELSE
                    -- Check if competitor already registered for this carnival
                    SELECT
                        COUNT(*) INTO var_existing_registration
                    FROM
                        entry e
                        JOIN event ev ON e.event_id = ev.event_id
                        JOIN carnival c ON ev.carn_date = c.carn_date
                    WHERE
                        e.comp_no = p_comp_no
                        AND UPPER(c.carn_name) = UPPER(p_carn_name);

                    IF (var_existing_registration <> 0) THEN
                        p_output := 'Competitor already registered for this carnival';
                    ELSE
                        -- Get next entry number for this event
                        SELECT
                            NVL (MAX(entry_no), 0) + 1 INTO var_entry_no
                        FROM
                            entry
                        WHERE
                            event_id = var_event_id;

                        -- Handle team logic
                        SELECT
                            COUNT(*) INTO var_team_found
                        FROM
                            team
                        WHERE
                            UPPER(team_name) = UPPER(p_team_name)
                            AND carn_date = var_carn_date;

                        IF (var_team_found = 0) THEN
                            -- Create entry record first (with NULL team_id temporarily)
                            INSERT INTO entry (event_id, entry_no, comp_no, team_id)
                            VALUES (var_event_id, var_entry_no, p_comp_no, NULL);

                            -- Create new team with competitor as leader
                            var_team_id := team_seq.NEXTVAL;
                            INSERT INTO
                                team (team_id, team_name, carn_date, event_id, entry_no)
                            VALUES
                                (
                                    var_team_id,
                                    p_team_name,
                                    var_carn_date,
                                    var_event_id,
                                    var_entry_no
                                );

                            -- Update entry record with correct team_id
                            UPDATE entry
                            SET team_id = var_team_id
                            WHERE event_id = var_event_id AND entry_no = var_entry_no;

                            dbms_output.put_line ('New team created: ' || p_team_name);
                        ELSE
                            -- Use existing team
                            SELECT
                                team_id INTO var_team_id
                            FROM
                                team
                            WHERE
                                UPPER(team_name) = UPPER(p_team_name)
                                AND carn_date = var_carn_date;

                            -- Create entry record with existing team
                            INSERT INTO entry (event_id, entry_no, comp_no, team_id)
                            VALUES (var_event_id, var_entry_no, p_comp_no, var_team_id);

                            dbms_output.put_line ('Joined existing team: ' || p_team_name);
                        END IF;

                        -- Create charity support record
                        INSERT INTO
                            entrycharity (
                                entrycharity_id,
                                event_id,
                                entry_no,
                                char_id,
                                donate_percentage
                            )
                        VALUES
                            (
                                entrycharity_seq.NEXTVAL,
                                var_event_id,
                                var_entry_no,
                                var_char_id,
                                100
                            );

                        -- Success message
                        p_output := 'Registration successful for competitor ' || p_comp_no ||
                                   ', entry number ' || var_entry_no ||
                                   ', team: ' || p_team_name ||
                                   ', charity: ' || p_char_name;

                        dbms_output.put_line (p_output);
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        p_output := 'Data not found error during registration process';
    WHEN OTHERS THEN
        p_output := 'Error: ' || SQLERRM;
END;
/

-- Write Test Harness for (c)

-- before value
SELECT
    COUNT(*) AS total_entries
FROM
    entry;

SELECT
    COUNT(*) AS total_teams
FROM
    team;

SELECT
    COUNT(*) AS total_entrycharity
FROM
    entrycharity;

-- test case 1: successful registration with new team creation
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(100, 'RM Winter Series Caulfield 2025', '5 Km Run', 'Monash Mavericks', 'RSPCA', output);
    dbms_output.put_line ('Test 1 Result: ' || output);
END;
/

-- after value
SELECT
    COUNT(*) AS total_entries
FROM
    entry;

SELECT
    COUNT(*) AS total_teams
FROM
    team;

SELECT
    COUNT(*) AS total_entrycharity
FROM
    entrycharity;

-- Verify new registration
SELECT
    e.event_id,
    e.entry_no,
    e.comp_no,
    e.team_id,
    t.team_name,
    ch.char_name
FROM
    entry e
    LEFT JOIN team t ON e.team_id = t.team_id
    LEFT JOIN entrycharity ec ON e.event_id = ec.event_id
    AND e.entry_no = ec.entry_no
    LEFT JOIN charity ch ON ec.char_id = ch.char_id
WHERE
    e.comp_no = 100
ORDER BY
    e.event_id,
    e.entry_no;

-- test case 2: successful registration joining existing team
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(105, 'RM Winter Series Caulfield 2025', '5 Km Run', 'Monash Mavericks', 'Beyond Blue', output);
    dbms_output.put_line ('Test 2 Result: ' || output);
END;
/

-- Verify team membership
SELECT
    e.event_id,
    e.entry_no,
    e.comp_no,
    e.team_id,
    t.team_name,
    ch.char_name
FROM
    entry e
    LEFT JOIN team t ON e.team_id = t.team_id
    LEFT JOIN entrycharity ec ON e.event_id = ec.event_id
    AND e.entry_no = ec.entry_no
    LEFT JOIN charity ch ON ec.char_id = ch.char_id
WHERE
    e.comp_no IN (100, 105)
    AND t.team_name = 'Monash Mavericks'
ORDER BY
    e.entry_no;

-- test case 3: Error - Invalid competitor
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(99999, 'RM Winter Series Caulfield 2025', '5 Km Run', 'Lightning Runners', 'RSPCA', output);
    dbms_output.put_line ('Test 3 Result: ' || output);
END;
/

-- test case 4: Error - Invalid carnival
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(100, 'Melbourne Marathon Festival 2025', '5 Km Run', 'Speed Demons', 'RSPCA', output);
    dbms_output.put_line ('Test 4 Result: ' || output);
END;
/

-- test case 5: Error - Invalid event type
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(105, 'RM Winter Series Caulfield 2025', '42 Km Marathon', 'Elite Athletes', 'RSPCA', output);
    dbms_output.put_line ('Test 5 Result: ' || output);
END;
/

-- test case 6: Error - Invalid charity
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(105, 'RM Winter Series Caulfield 2025', '5 Km Run', 'Charity Champions', 'World Wildlife Foundation', output);
    dbms_output.put_line ('Test 6 Result: ' || output);
END;
/

-- test case 7: Error - Duplicate registration
DECLARE
    output VARCHAR2(500);
BEGIN
    prc_entry_registration(100, 'RM Winter Series Caulfield 2025', '10 Km Run', 'Thunder Bolts', 'Salvation Army', output);
    dbms_output.put_line ('Test 7 Result: ' || output);
END;
/

-- closes transaction
ROLLBACK;
-- End of Test Harness