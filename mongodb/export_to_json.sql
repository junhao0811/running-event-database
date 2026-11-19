-- (a)

SELECT
    JSON_OBJECT (
        '_id' VALUE t.team_id,
        'carn_name' VALUE c.carn_name,
        'carn_date' VALUE to_char (c.carn_date, 'dd-Mon-yyyy'),
        'team_name' VALUE t.team_name,
        'team_leader' VALUE JSON_OBJECT (
            'name' VALUE TRIM(leader.comp_fname || ' ' || leader.comp_lname),
            'phone' VALUE NVL (leader.comp_phone, '-'),
            'email' VALUE NVL (leader.comp_email, '-')
        ),
        'team_no_of_members' VALUE COUNT(e.comp_no),
        'team_members' VALUE JSON_ARRAYAGG (
            JSON_OBJECT (
                'competitor_name' VALUE TRIM(comp.comp_fname || ' ' || comp.comp_lname),
                'competitor_phone' VALUE NVL (comp.comp_phone, '-'),
                'event_type' VALUE et.eventtype_desc,
                'entry_no' VALUE e.entry_no,
                'starttime' VALUE NVL (to_char (e.entry_starttime, 'hh24:mi:ss'), '-'),
                'finishtime' VALUE NVL (to_char (e.entry_finishtime, 'hh24:mi:ss'), '-'),
                'elapsedtime' VALUE NVL (to_char (e.entry_elapsedtime, 'hh24:mi:ss'), '-')
            )
        ) FORMAT JSON
    ) || ','
FROM
    team t
    JOIN carnival c ON t.carn_date = c.carn_date
    JOIN event ev ON t.event_id = ev.event_id
    JOIN eventtype et ON ev.eventtype_code = et.eventtype_code
    JOIN entry e ON t.team_id = e.team_id
    JOIN competitor comp ON e.comp_no = comp.comp_no
    JOIN entry leader_entry ON t.event_id = leader_entry.event_id
    AND t.entry_no = leader_entry.entry_no
    JOIN competitor leader ON leader_entry.comp_no = leader.comp_no
GROUP BY
    t.team_id,
    c.carn_name,
    c.carn_date,
    t.team_name,
    leader.comp_fname,
    leader.comp_lname,
    leader.comp_phone,
    leader.comp_email
ORDER BY
    t.team_id;