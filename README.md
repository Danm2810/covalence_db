# Covalence Database Schema | PostgreSQL
## Vital tracker Table Specifications
### Concept
Each vital can have different units of measurement. If we want to store multiple units in the DB, we need to create separate columns for each unit

```sql
CREATE TABLE vital_track (
	vital_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
	vital_name VARCHAR(50) NOT NULL,
	weight_kg DECIMAL(10,2),  -- Stores weight in kg
	weight_lbs DECIMAL(10,2), -- Stores weight in lbs
	temperature_c DECIMAL(5,2), -- Stores temperature in Celsius
	temperature_f DECIMAL(5,2)  -- Stores temperature in Fahrenheit
);
```
Example Data Insertion

```sql
INSERT INTO vital_track (vital_name, weight_kg, weight_lbs)
VALUES ('Weight', 70.00, 154.32);

INSERT INTO vital_track (vital_name, temperature_c, temperature_f)
VALUES ('Temperature', 37.0, 98.6);
```

Flutter Function
Inside the app when a user inputs weight in kg, our function must automatically convert it to lbs before storing it in the database

```dart
double kgToLbs(double kg) {
  return kg * 2.20462;
}

double lbsToKg(double lbs) {
  return lbs / 2.20462;
}
```

When used for data insertion:

```dart
double weightKg = 70;
double weightLbs = kgToLbs(weightKg);
//then post that new data with the rest of the tracker
```

### Summary
Each distinct unit of measurement (kg, lbs, °C, °F) gets its own column.
The app handles conversions automatically, so users don’t need to enter both.
When querying the database, we show whichever unit the user prefers.


## Medication Tracker Table Specifications
### Concept

```badges``` Table
This table store the general information about each badge and task condition.

```badge_levels``` Table
This table tracks the levels (e.g., Bronze, Silver, Gold) and the associated number of task completions for each badge.