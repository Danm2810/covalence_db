CREATE EXTENSION IF NOT EXISTS "uuid-oosp";

CREATE TABLE vital_list (
    vital_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    vital_name VARCHAR(50) UNIQUE NOT NULL,
);

CREATE TABLE vital_units (
    unit_id UUID uuid_generate_v4() PRIMARY KEY,
    vital_id UUID REFERENCES vital_list(vital_id) ON DELETE CASCADE,
    unit_name VARCHAR(50) NOT NULL,
    unit_symbol VARCHAR(3)
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
    condition VARCHAR(80) NOT NULL,
    badge_description VARCHAR(255) NOT NULL
);