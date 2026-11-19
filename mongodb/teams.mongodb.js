// Use (connect to) your database

use("running_event");

// (b)

// Drop collection
db.teams.drop();

// Create collection and insert documents
db.teams.insertMany([
    {
        "_id": 1,
        "carn_name": "RM Spring Series Clayton 2024",
        "carn_date": "22-Sep-2024",
        "team_name": "Speedsters",
        "team_leader": {
            "name": "Alice Johnson",
            "phone": "0412345671",
            "email": "alice.johnson@student.monash.edu"
        },
        "team_no_of_members": 3,
        "team_members": [
            {
                "competitor_name": "Alice Johnson",
                "competitor_phone": "0412345671",
                "event_type": "5 Km Run",
                "entry_no": 1,
                "starttime": "09:30:00",
                "finishtime": "10:05:30",
                "elapsedtime": "00:35:30"
            },
            {
                "competitor_name": "David Brown",
                "competitor_phone": "0412345674",
                "event_type": "5 Km Run",
                "entry_no": 1,
                "starttime": "08:30:00",
                "finishtime": "09:25:20",
                "elapsedtime": "00:55:20"
            },
            {
                "competitor_name": "Bob Wilson",
                "competitor_phone": "0412345672",
                "event_type": "5 Km Run",
                "entry_no": 2,
                "starttime": "09:30:15",
                "finishtime": "10:08:45",
                "elapsedtime": "00:38:30"
            }
        ]
    },
    {
        "_id": 2,
        "carn_name": "RM Spring Series Caulfield 2024",
        "carn_date": "05-Oct-2024",
        "team_name": "Thunder Bolts",
        "team_leader": {
            "name": "Alice Johnson",
            "phone": "0412345671",
            "email": "alice.johnson@student.monash.edu"
        },
        "team_no_of_members": 3,
        "team_members": [
            {
                "competitor_name": "Alice Johnson",
                "competitor_phone": "0412345671",
                "event_type": "5 Km Run",
                "entry_no": 1,
                "starttime": "09:00:00",
                "finishtime": "09:33:20",
                "elapsedtime": "00:33:20"
            },
            {
                "competitor_name": "Jack Jackson",
                "competitor_phone": "0412345680",
                "event_type": "5 Km Run",
                "entry_no": 2,
                "starttime": "09:00:15",
                "finishtime": "09:36:45",
                "elapsedtime": "00:36:30"
            },
            {
                "competitor_name": "Carol Smith",
                "competitor_phone": "0412345673",
                "event_type": "5 Km Run",
                "entry_no": 1,
                "starttime": "08:00:00",
                "finishtime": "09:45:30",
                "elapsedtime": "01:45:30"
            }
        ]
    },
    {
        "_id": 3,
        "carn_name": "RM Spring Series Caulfield 2024",
        "carn_date": "05-Oct-2024",
        "team_name": "Lightning Runners",
        "team_leader": {
            "name": "Bob Wilson",
            "phone": "0412345672",
            "email": "bob.wilson@student.monash.edu"
        },
        "team_no_of_members": 2,
        "team_members": [
            {
                "competitor_name": "Bob Wilson",
                "competitor_phone": "0412345672",
                "event_type": "10 Km Run",
                "entry_no": 1,
                "starttime": "08:30:00",
                "finishtime": "09:22:15",
                "elapsedtime": "00:52:15"
            },
            {
                "competitor_name": "David Brown",
                "competitor_phone": "0412345674",
                "event_type": "10 Km Run",
                "entry_no": 2,
                "starttime": "08:00:30",
                "finishtime": "09:52:15",
                "elapsedtime": "01:51:45"
            }
        ]
    },
    {
        "_id": 4,
        "carn_name": "RM Summer Series Caulfield 2025",
        "carn_date": "02-Feb-2025",
        "team_name": "Speedsters",
        "team_leader": {
            "name": "Frank Miller",
            "phone": "0412345676",
            "email": "frank.miller@student.monash.edu"
        },
        "team_no_of_members": 2,
        "team_members": [
            {
                "competitor_name": "Frank Miller",
                "competitor_phone": "0412345676",
                "event_type": "3 Km Community Run/Walk",
                "entry_no": 1,
                "starttime": "08:30:00",
                "finishtime": "08:52:30",
                "elapsedtime": "00:22:30"
            },
            {
                "competitor_name": "Grace Taylor",
                "competitor_phone": "0412345677",
                "event_type": "3 Km Community Run/Walk",
                "entry_no": 2,
                "starttime": "08:30:15",
                "finishtime": "08:55:45",
                "elapsedtime": "00:25:30"
            }
        ]
    },
    {
        "_id": 5,
        "carn_name": "RM Summer Series Caulfield 2025",
        "carn_date": "02-Feb-2025",
        "team_name": "Storm Chasers",
        "team_leader": {
            "name": "Ivy Thomas",
            "phone": "0412345679",
            "email": "ivy.thomas@outlook.com"
        },
        "team_no_of_members": 2,
        "team_members": [
            {
                "competitor_name": "Ivy Thomas",
                "competitor_phone": "0412345679",
                "event_type": "5 Km Run",
                "entry_no": 1,
                "starttime": "08:30:00",
                "finishtime": "09:04:15",
                "elapsedtime": "00:34:15"
            },
            {
                "competitor_name": "Liam Harris",
                "competitor_phone": "0412345682",
                "event_type": "5 Km Run",
                "entry_no": 1,
                "starttime": "08:00:00",
                "finishtime": "08:53:20",
                "elapsedtime": "00:53:20"
            }
        ]
    },
    {
        "_id": 110,
        "carn_name": "RM Winter Series Caulfield 2025",
        "carn_date": "29-Jun-2025",
        "team_name": "Test Runners A",
        "team_leader": {
            "name": "Keith Rose",
            "phone": "0422141112",
            "email": "keith.rose@student.monash.edu"
        },
        "team_no_of_members": 1,
        "team_members": [
            {
                "competitor_name": "Keith Rose",
                "competitor_phone": "0422141112",
                "event_type": "5 Km Run",
                "entry_no": 2,
                "starttime": "-",
                "finishtime": "-",
                "elapsedtime": "-"
            }
        ]
    }
]);

// List all documents you added
db.teams.find({});

// (c)
db.teams.find(
    { "team_members.event_type": { "$in": ["5 Km Run", "10 Km Run"] } },
    {
        "carn_date": 1,
        "carn_name": 1,
        "team_name": 1,
        "team_leader.name": 1,
        "_id": 0
    }
);

// (d)

// (i) Add new team
db.teams.insertOne({
    "_id": 666,
    "carn_name": "RM WINTER SERIES CAULFIELD 2025",
    "carn_date": "29-Jun-2025",
    "team_name": "The Great Runners",
    "team_leader": {
        "name": "Jackson Bull",
        "phone": "0422412524",
        "email": "jackson.bull@student.monash.edu"
    },
    "team_no_of_members": 1,
    "team_members": [
        {
            "competitor_name": "Jackson Bull",
            "competitor_phone": "0422412524",
            "event_type": "5 Km Run",
            "entry_no": 1,
            "starttime": "-",
            "finishtime": "-",
            "elapsedtime": "-"
        }
    ]
});

// Illustrate/confirm changes made
db.teams.find({ "team_name": "The Great Runners" });

// (ii) Add new team member
db.teams.updateOne(
    { "team_name": "The Great Runners" },
    {
        "$push": {
            "team_members": {
                "competitor_name": "Steve Bull",
                "competitor_phone": "0422251427",
                "event_type": "10 Km Run",
                "entry_no": 2,
                "starttime": "-",
                "finishtime": "-",
                "elapsedtime": "-"
            }
        },
        "$inc": { "team_no_of_members": 1 }
    }
);

// Illustrate/confirm changes made
db.teams.find({ "team_name": "The Great Runners" });