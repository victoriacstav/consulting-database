-- TechX Consulting database schema
-- PostgreSQL DDL: tables, primary/foreign keys and CASCADE constraints

-- CLIENT
CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    legal_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100),
    billing_address TEXT,
    billing_email VARCHAR(150)
);

-- CLIENT CONTACT
CREATE TABLE ClientContact (
    contact_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Client(client_id) ON DELETE CASCADE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(20),
    is_primary BOOLEAN
);

-- SERVICE
CREATE TABLE Service (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- CONSULTANT
CREATE TABLE Consultant (
    consultant_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    expertise VARCHAR(100),
    employment_status VARCHAR(30),
    hourly_rate DECIMAL(10,2)
);

-- PROJECT
CREATE TABLE Project (
    project_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Client(client_id) ON DELETE CASCADE,
    service_id INT REFERENCES Service(service_id),
    name VARCHAR(150),
    start_date DATE,
    end_date DATE,
    status VARCHAR(30),
    budget DECIMAL(12,2)
);

-- PROJECT CONSULTANT (junction table: many-to-many between Project and Consultant)
CREATE TABLE ProjectConsultant (
    project_id INT REFERENCES Project(project_id) ON DELETE CASCADE,
    consultant_id INT REFERENCES Consultant(consultant_id) ON DELETE CASCADE,
    role VARCHAR(100),
    is_responsible BOOLEAN,
    PRIMARY KEY (project_id, consultant_id)
);

-- ROOM
CREATE TABLE Room (
    room_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    capacity INT
);

-- MEETING
CREATE TABLE Meeting (
    meeting_id SERIAL PRIMARY KEY,
    project_id INT REFERENCES Project(project_id) ON DELETE CASCADE,
    room_id INT REFERENCES Room(room_id),
    consultant_id INT REFERENCES Consultant(consultant_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    subject VARCHAR(150)
);

-- MEETING ATTENDEE (junction table: meetings can have many attendees)
CREATE TABLE MeetingAttendee (
    meeting_id INT REFERENCES Meeting(meeting_id) ON DELETE CASCADE,
    consultant_id INT REFERENCES Consultant(consultant_id),
    contact_id INT REFERENCES ClientContact(contact_id),
    PRIMARY KEY (meeting_id, consultant_id, contact_id)
);

-- TIMESHEET
CREATE TABLE Timesheet (
    timesheet_id SERIAL PRIMARY KEY,
    project_id INT REFERENCES Project(project_id) ON DELETE CASCADE,
    consultant_id INT REFERENCES Consultant(consultant_id),
    work_date DATE,
    hours DECIMAL(5,2),
    activity VARCHAR(150),
    billable BOOLEAN,
    billing_rate DECIMAL(10,2)
);

-- INVOICE
CREATE TABLE Invoice (
    invoice_id SERIAL PRIMARY KEY,
    project_id INT REFERENCES Project(project_id) ON DELETE CASCADE,
    issue_date DATE,
    due_date DATE,
    status VARCHAR(30),
    total_amount DECIMAL(12,2)
);

-- PAYMENT
CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES Invoice(invoice_id) ON DELETE CASCADE,
    payment_date DATE,
    amount DECIMAL(12,2),
    method VARCHAR(50)
);
