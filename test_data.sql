-- Test data for the TechX Consulting database
-- Fictional but realistic data to test relationships and constraints

-- CLIENTS
INSERT INTO Client (legal_name, industry, billing_address, billing_email)
VALUES
('Star Technologies AS', 'Information Technology', 'Bryggegata 9, 0250 Oslo', 'post@startech.no'),
('BigData Solutions AS', 'Information Technology', 'Dronning Eufemias gate 14, 0191 Oslo', 'contact@bigdatasolutions.no');

-- SERVICES
INSERT INTO Service (name)
VALUES ('Cybersecurity'), ('Data Science'), ('Cloud Migration'), ('ERP');

-- CONSULTANTS
INSERT INTO Consultant (first_name, last_name, expertise, employment_status, hourly_rate)
VALUES
('Lars', 'Johansen', 'Cybersecurity', 'Active', 900.00),
('Anne', 'Berg', 'Cloud Migration', 'Active', 950.00),
('Markus', 'Solheim', 'Data Science', 'On Leave', 750.00);

-- PROJECTS
INSERT INTO Project (client_id, service_id, name, start_date, end_date, status, budget)
VALUES
(1, 1, 'Project X', '2025-09-02', '2025-10-10', 'Completed', 80000.00),
(2, 3, 'Project B', '2025-09-09', '2025-10-13', 'In Progress', 90000.00);

-- PROJECT CONSULTANTS
INSERT INTO ProjectConsultant (project_id, consultant_id, role, is_responsible)
VALUES
(1, 1, 'Senior Consultant', FALSE),
(1, 3, 'Security Analyst', TRUE),
(2, 2, 'Senior Cloud Architect', TRUE);

-- ROOMS
INSERT INTO Room (name, capacity)
VALUES ('Room Oslo', 8), ('Room Trondheim', 10);

-- MEETINGS
INSERT INTO Meeting (project_id, room_id, consultant_id, start_time, end_time, subject)
VALUES
(1, 1, 1, '2025-09-12 09:00', '2025-09-12 10:00', 'Check-in - Security Testing'),
(2, 2, 2, '2025-10-07 13:00', '2025-10-07 14:00', 'Planning - Cloud Migration');

-- CLIENT CONTACTS
INSERT INTO ClientContact (client_id, first_name, last_name, email, phone, is_primary)
VALUES
(1, 'Anne', 'Hansen', 'anne.hansen@startech.no', '41224567', FALSE),
(1, 'Jonas', 'Vangen', 'jonas.vangen@startech.no', '47341023', TRUE),
(2, 'Hilde', 'Hvaler', 'hilde.hvaler@bigdatasolutions.no', '40405040', TRUE);

-- MEETING ATTENDEES
INSERT INTO MeetingAttendee (meeting_id, consultant_id, contact_id)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 3);

-- TIMESHEETS
INSERT INTO Timesheet (project_id, consultant_id, work_date, hours, activity, billable, billing_rate)
VALUES
(1, 1, '2025-09-15', 6.5, 'Open Assessment', TRUE, 900.00),
(1, 3, '2025-09-24', 4.0, 'Security Report', TRUE, 750.00),
(2, 2, '2025-10-10', 7.0, 'Cloud Desk Setup', TRUE, 950.00);

-- INVOICES
INSERT INTO Invoice (project_id, issue_date, due_date, status, total_amount)
VALUES
(1, '2025-09-30', '2025-10-15', 'Paid', 80000.00),
(2, '2025-10-05', '2025-10-20', 'Partially Paid', 90000.00);

-- PAYMENTS
INSERT INTO Payment (invoice_id, payment_date, amount, method)
VALUES
(1, '2025-10-10', 80000.00, 'Bank Transfer'),
(2, '2025-10-15', 45000.00, 'Bank Transfer');
