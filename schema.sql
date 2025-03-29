CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE vital_list (
    vital_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    vital_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE vital_units (
    unit_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    vital_id UUID REFERENCES vital_list(vital_id) ON DELETE CASCADE,
    unit_name VARCHAR(50) NOT NULL,
    unit_symbol VARCHAR(10)
);

INSERT INTO vital_list(vital_name)
VALUES
    ('Weight'),
    ('Temperature'),
    ('Heart Rate'),
    ('Blood Pressure'),
    ('Respiratory Rate'),
    ('Oxygen Saturation'),
    ('Blood Glucose');

INSERT INTO vital_units(vital_id, unit_name, unit_symbol)
VALUES
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Weight'), 'Kilograms', 'kg'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Weight'), 'Pounds', 'lbs'),

    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Temperature'), 'Celcius', '°C'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Temperature'), 'Fahrenheit', '°F'),

    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Heart Rate'), 'Beats per Minute', 'BPM'),

    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Blood Pressure'), 'Millimeters of Mercury', 'mmHg'),

    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Respiratory Rate'), 'Breaths per Minute', 'BPM'),

    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Oxygen Saturation'), 'Percentage', '%'),

    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Blood Glucose'), 'Milligrams per Deciliter', 'mg/dL'),
    ((SELECT vital_id FROM vital_list WHERE vital_name = 'Blood Glucose'), 'Millimoles per Liter', 'mmol/L');

CREATE TABLE symptom_list (
    symptom_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    symptom_name VARCHAR(50) NOT NULL,
    common_symptom_name VARCHAR(50) NOT NULL
);

CREATE TABLE badges (
    badge_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    badge_name VARCHAR(50) NOT NULL,
    badge_description VARCHAR(255) NOT NULL
);

CREATE TABLE badge_levels (
    level_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    badge_id UUID REFERENCES badges(badge_id) ON DELETE CASCADE,
    level_name VARCHAR(20) NOT NULL,
    condition INTEGER NOT NULL,
    level_description VARCHAR(255)
);

INSERT INTO badges (badge_name, badge_description)
VALUES
    ('Symptom Tracker', 'Awarded for tracking n symptoms into the system');

INSERT INTO badge_levels (badge_id, level_name, condition, level_description)
VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker'), 'Bronze', 1, 'Logged 1 symptom'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker'), 'Silver', 5, 'Logged 5 symptoms')
    ((SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker'), 'Gold', 10, 'Logged 10 symptoms');

INSERT INTO badges (badge_name, badge_description)
VALUES
    ('Medication Tracker', 'Awarded for tracking n medication into the system');

INSERT INTO badge_levels(badge_id, level_name, condition, level_description)
VALUES  
    ((SELECT badge_id FROM badges WHERE badge_name = 'Medication Tracker'), 'Bronze', 1, 'Logged 1 medication'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Medication Tracker'), 'Silver', 5, 'Logged 5 medications'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Medication Tracker'), 'Gold', 10, 'Logged 10 medications');

INSERT INTO badges (badge_name, badge_description)
VALUES
    ('Appointment Scheduler', 'Awarded for scheduling n appointments into the system');

INSERT INTO badge_levels(badge_id, level_name, condition, level_description)
VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'Appointment Scheduler'), 'Bronze', 1, 'Scheduled 1 appointment'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Appointment Scheduler'), 'Silver', 5, 'Scheduled 5 appointments'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Appointment Scheduler'), 'Gold', 10, 'Scheduled 10 appointments');

INSERT INTO badges(badge_name, badge_description)
VALUES
    ('Login Tracker', 'Awarded for n logins into the app');

INSERT INTO badge_levels(badge_id, level_name, condition, level_description)
VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'Login Tracker'), 'Bronze', 1, 'Logged in 1 time'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Login Tracker'), 'Silver', 5, 'Logged in 5 times'),
    ((SELECT badge_id FROM badges WHERE badge_name = 'Login Tracker'), 'Gold', 10, 'Logged in 10 times');

INSERT INTO badges (badge_name, badge_description)
VALUES
    ('Notificaiton', 'Awarded for turning on push notificaitons');

INSERT INTO badge_levels (badge_id, level_name, condition, level_description),
VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'Notification'), 'Single', 1, 'Turned on push notificaitons');

INSERT INTO badges (badge_name, badge_description)
VALUES
    ('One Year Annie', 'Awarded for logging in after one year');

INSERT INTO badge_levels (badge_id, level_name, condition, level_description),
VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'One Year Annie'), 'Single', 1, 'Logged in after one year');

INSERT INTO badges (badge_name, badge_description)
VALUES
    ('Final Boss', 'Awarded for achieving all badges');

INSERT INTO badge_levels (badge_id, level_name, condition, level_description)
VALUES
    ((SELECT badge_id FROM badges WHERE badge_name = 'Final Boss'), 'Single', 1, 'Collecting all badges');


-- CREATE TABLE test_person (
--     id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
--     first_name VARCHAR(50) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     level_id UUID REFERENCES badge_levels(level_id) ON DELETE CASCADE,  -- Relates to specific badge level
--     vital_id UUID REFERENCES vital_list(vital_id) ON DELETE CASCADE,
--     symptom_id UUID REFERENCES symptom_list(symptom_id) ON DELETE CASCADE
-- );

-- INSERT INTO test_person (first_name, last_name, level_id, vital_id, symptom_id)
-- VALUES (
--     'John', 
--     'Doe', 
--     (SELECT level_id FROM badge_levels WHERE badge_id = (SELECT badge_id FROM badges WHERE badge_name = 'Symptom Tracker') AND level_name = 'Bronze'),
--     (SELECT vital_id FROM vital_list WHERE vital_name = 'Heart Rate'),
--     (SELECT symptom_id FROM symptom_list WHERE symptom_name = 'Headache')
-- );

-- SELECT 
--     tp.id, 
--     tp.first_name, 
--     tp.last_name, 
--     b.badge_name, 
--     bl.level_name, 
--     v.vital_name, 
--     s.symptom_name
-- FROM test_person tp
-- LEFT JOIN badge_levels bl ON tp.level_id = bl.level_id
-- LEFT JOIN badges b ON bl.badge_id = b.badge_id
-- LEFT JOIN vital_list v ON tp.vital_id = v.vital_id
-- LEFT JOIN symptom_list s ON tp.symptom_id = s.symptom_id;
