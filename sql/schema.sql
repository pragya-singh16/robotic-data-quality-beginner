-- Create the simple SQLite table. All data is simulated.
DROP TABLE IF EXISTS robotic_data;
CREATE TABLE robotic_data (
  Record_ID TEXT,
  Operator_ID TEXT,
  Task_Type TEXT,
  Collection_Date TEXT,
  Video_Quality TEXT,
  Annotation_Status TEXT,
  Trajectory_Status TEXT,
  Final_Status TEXT
);
