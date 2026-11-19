# 🏃 Running Event Database

The database behind a charity **running carnival**: competitors sign up for events (5 km, 10 km and more), run for a charity, join teams and get their finish times recorded. Built in **Oracle SQL and PL/SQL**, with a **MongoDB** document model for teams.

---

## ✨ What's inside

| Script | What it does |
|---|---|
| `sql/1_schema.sql` | Designs the **competitor**, **entry** and **team** tables with keys, constraints and column documentation |
| `sql/2_seed_data.sql` | **700+ lines** of realistic test data across competitors, entries and teams |
| `sql/3_data_manipulation.sql` | Real-world changes using **sequences** and subqueries: registering new runners, adding race entries, moving team members between entries |
| `sql/4_schema_changes.sql` | Evolves the live schema, e.g. adding a "completed events" column to competitors and back-filling it from existing data |
| `sql/5_plsql.sql` | Business logic in **PL/SQL** (see below) |
| `mongodb/export_to_json.sql` | Generates JSON documents from the relational data |
| `mongodb/teams.mongodb.js` | Loads teams into **MongoDB** as documents, then queries and updates them |

### ⚙️ PL/SQL business logic
- **`calc_elapsedtime`**: function that computes a runner's race time from start and finish times
- **`trg_maintain_elapsed_time`**: trigger that keeps elapsed times correct and enforces data integrity whenever a finish time is recorded
- **`prc_entry_registration`**: stored procedure that validates and registers a competitor for an event in a carnival

Each comes with a **test harness** covering normal and edge cases.

---

## 🚀 Run it

The scripts build on a base schema of carnivals, events, event types and charities. That schema is third-party and copyrighted, so it isn't included here.

With the base schema loaded, run the scripts in order in Oracle (SQL Developer or SQLcl):
```sql
@sql/1_schema.sql
@sql/2_seed_data.sql
@sql/3_data_manipulation.sql
@sql/4_schema_changes.sql
@sql/5_plsql.sql
```
For MongoDB, open `mongodb/teams.mongodb.js` in **MongoDB for VS Code** or `mongosh`, and change the database name in `use(...)` if needed.

## 🛠️ Tech
Oracle SQL · PL/SQL (functions, triggers, procedures) · sequences · JSON · MongoDB
