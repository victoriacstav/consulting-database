# Consulting Firm Database: Relational Database Design

A complete relational database design and implementation in PostgreSQL for a fictional consulting firm, covering clients, consultants, projects, meetings, timesheets, invoicing and payments.

Based on a case from my Data Management course, extended and published as a portfolio project.

## What it covers

The database models the day-to-day operations of a consulting business:

- Clients and their contact persons
- Consultants, their expertise and hourly rates
- Projects linked to clients and service types
- Many-to-many relationships (consultants and projects, meeting attendees and meetings) handled with junction tables
- Timesheets, invoices and payments for financial tracking

## Design highlights

- **Normalized schema** with redundancy removed, no multi-valued fields, designed to avoid insertion/update/deletion anomalies
- **Referential integrity** through primary/foreign keys with `ON DELETE CASCADE` where appropriate
- **ER diagram** included (see `er-diagram.png`)

## Analytical queries

The repo includes example queries demonstrating joins and aggregation for business reporting:

1. Total revenue per client
2. Total payments received per project
3. Total hours worked per consultant
4. Number of consultants per project
5. Number of meetings per client

Each query uses `INNER JOIN` / `LEFT JOIN` with `SUM()` / `COUNT()` and `GROUP BY`. A validation query that counts rows per table is also included.

## Files

| File | Description |
|------|-------------|
| `schema.sql` | CREATE TABLE statements for all tables |
| `test_data.sql` | INSERT statements with realistic test data |
| `queries.sql` | Validation query and the five analytical queries |
| `er-diagram.png` | Entity-relationship diagram |

## How to run

Requires PostgreSQL (tested on v16):

```sql
\i schema.sql
\i test_data.sql
\i queries.sql
```

## Built with

PostgreSQL · pgAdmin 4 · SQL (DDL + DML)
