-- Analytical queries for the TechX Consulting database
-- Demonstrates joins, aggregation and GROUP BY for business reporting

-- 0) Validation query: row count per table to verify the test data
SELECT 'Consultant' AS table_name, COUNT(*) AS row_count FROM Consultant
UNION ALL
SELECT 'Client', COUNT(*) FROM Client
UNION ALL
SELECT 'ClientContact', COUNT(*) FROM ClientContact
UNION ALL
SELECT 'Service', COUNT(*) FROM Service
UNION ALL
SELECT 'Project', COUNT(*) FROM Project
UNION ALL
SELECT 'ProjectConsultant', COUNT(*) FROM ProjectConsultant
UNION ALL
SELECT 'Room', COUNT(*) FROM Room
UNION ALL
SELECT 'Meeting', COUNT(*) FROM Meeting
UNION ALL
SELECT 'MeetingAttendee', COUNT(*) FROM MeetingAttendee
UNION ALL
SELECT 'Timesheet', COUNT(*) FROM Timesheet
UNION ALL
SELECT 'Invoice', COUNT(*) FROM Invoice
UNION ALL
SELECT 'Payment', COUNT(*) FROM Payment;

-- 1) Total revenue per client
SELECT
    c.legal_name AS client_name,
    SUM(i.total_amount) AS total_revenue
FROM Client c
JOIN Project p ON c.client_id = p.client_id
JOIN Invoice i ON p.project_id = i.project_id
GROUP BY c.legal_name;

-- 2) Total payments received per project
SELECT
    p.name AS project_name,
    SUM(pay.amount) AS total_payments
FROM Project p
JOIN Invoice i ON p.project_id = i.project_id
JOIN Payment pay ON i.invoice_id = pay.invoice_id
GROUP BY p.name;

-- 3) Total hours worked by consultant
SELECT
    con.first_name || ' ' || con.last_name AS consultant,
    SUM(t.hours) AS total_hours
FROM Consultant con
JOIN Timesheet t ON con.consultant_id = t.consultant_id
GROUP BY con.first_name, con.last_name;

-- 4) Number of consultants per project
SELECT
    p.name AS project_name,
    COUNT(pc.consultant_id) AS consultant_count
FROM Project p
JOIN ProjectConsultant pc ON p.project_id = pc.project_id
GROUP BY p.name;

-- 5) Number of meetings per client
SELECT
    c.legal_name AS client_name,
    COUNT(m.meeting_id) AS meeting_count
FROM Client c
LEFT JOIN Project p ON c.client_id = p.client_id
LEFT JOIN Meeting m ON p.project_id = m.project_id
GROUP BY c.legal_name;
