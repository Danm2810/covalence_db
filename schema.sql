-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table: vital_list
CREATE TABLE vital_list (
    vital_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    vital_name VARCHAR(50) UNIQUE NOT NULL
);

-- Table: vital_units
CREATE TABLE vital_units (
    unit_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    vital_id UUID REFERENCES vital_list(vital_id) ON DELETE CASCADE,
    unit_name VARCHAR(50) NOT NULL,
    unit_symbol VARCHAR(10)
);

-- Insert data into vital_list
INSERT INTO vital_list (vital_name) VALUES
    ('Weight'),
    ('Temperature'),
    ('Heart Rate'),
    ('Blood Pressure'),
    ('Respiratory Rate'),
    ('Oxygen Saturation'),
    ('Blood Glucose');

-- Insert data into vital_units
INSERT INTO vital_units (vital_id, unit_name, unit_symbol) VALUES
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Weight'), 'Kilograms', 'kg'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Weight'), 'Pounds', 'lbs'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Temperature'), 'Celsius', '°C'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Temperature'), 'Fahrenheit', '°F'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Heart Rate'), 'Beats per Minute', 'BPM'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Blood Pressure'), 'Millimeters of Mercury', 'mmHg'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Respiratory Rate'), 'Breaths per Minute', 'BPM'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Oxygen Saturation'), 'Percentage', '%'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Blood Glucose'), 'Milligrams per Deciliter', 'mg/dL'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Blood Glucose'), 'Millimoles per Liter', 'mmol/L');

-- Table: symptom_list
CREATE TABLE symptom_list (
    symptom_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    symptom_name VARCHAR(50) NOT NULL,
    common_symptom_name VARCHAR(50) NOT NULL
);

-- Insert data into symptom_list
INSERT INTO symptom_list (symptom_name, common_symptom_name) VALUES
    ('Headache', 'Headache');

-- Table: badges
CREATE TABLE badges (
    badge_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    badge_name VARCHAR(50) NOT NULL,
    badge_description VARCHAR(255) NOT NULL
);

-- Table: badge_levels
CREATE TABLE badge_levels (
    level_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    badge_id UUID REFERENCES badges(badge_id) ON DELETE CASCADE,
    level_name VARCHAR(20) NOT NULL,
    condition INTEGER NOT NULL,
    level_description VARCHAR(255)
);

-- Insert data into badges and badge_levels
INSERT INTO badges (badge_name, badge_description) VALUES
    ('Symptom Tracker', 'Awarded for tracking n symptoms into the system'),
    ('Medication Tracker', 'Awarded for tracking n medications into the system'),
    ('Appointment Scheduler', 'Awarded for scheduling n appointments into the system'),
    ('Login Tracker', 'Awarded for n logins into the app'),
    ('Notification', 'Awarded for turning on push notifications'),
    ('One Year Annie', 'Awarded for logging in after one year'),
    ('Final Boss', 'Awarded for achieving all badges');

-- Insert data into badge_levels
INSERT INTO badge_levels (badge_id, level_name, condition, level_description) VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker'), 'Bronze', 1, 'Logged 1 symptom'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker'), 'Silver', 5, 'Logged 5 symptoms'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker'), 'Gold', 10, 'Logged 10 symptoms'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Medication Tracker'), 'Bronze', 1, 'Logged 1 medication'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Medication Tracker'), 'Silver', 5, 'Logged 5 medications'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Medication Tracker'), 'Gold', 10, 'Logged 10 medications'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Appointment Scheduler'), 'Bronze', 1, 'Scheduled 1 appointment'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Appointment Scheduler'), 'Silver', 5, 'Scheduled 5 appointments'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Appointment Scheduler'), 'Gold', 10, 'Scheduled 10 appointments'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Login Tracker'), 'Bronze', 1, 'Logged in 1 time'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Login Tracker'), 'Silver', 5, 'Logged in 5 times'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Login Tracker'), 'Gold', 10, 'Logged in 10 times'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Notification'), 'Single', 1, 'Turned on push notifications'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'One Year Annie'), 'Single', 1, 'Logged in after one year'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Final Boss'), 'Single', 1, 'Collected all badges');

-- Table: test_person
CREATE TABLE test_person (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    level_id UUID REFERENCES badge_levels(level_id) ON DELETE CASCADE,
    vital_id UUID REFERENCES vital_list(vital_id) ON DELETE CASCADE,
    symptom_id UUID REFERENCES symptom_list(symptom_id) ON DELETE CASCADE
);

-- Insert sample data into test_person
INSERT INTO test_person (first_name, last_name, level_id, vital_id, symptom_id) VALUES (
    'John', 
    'Doe', 
    (SELECT level_id FROM badge_levels WHERE badge_id = (SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker') AND level_name = 'Bronze'),
    (SELECT vital_id FROM vital_list WHERE vital_name = 'Heart Rate'),
    (SELECT symptom_id FROM symptom_list WHERE symptom_name = 'Headache')
);
