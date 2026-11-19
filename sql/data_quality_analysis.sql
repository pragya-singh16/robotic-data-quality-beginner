-- PROJECT: Robotic Data Quality Analysis (BEGINNER)
-- DATA: 100 SYNTHETIC records. NOT real robotic experiments.
-- Run schema.sql first and import dataset/robotic_task_data.csv into robotic_data.
-- All queries are compatible with SQLite.

-- Q1. How many demonstrations are present?
SELECT COUNT(*) AS Total_Records
FROM robotic_data;

-- Q2. How many records were accepted and rejected?
SELECT Final_Status, COUNT(*) AS Record_Count
FROM robotic_data
GROUP BY Final_Status
ORDER BY Final_Status;

-- Q3. What percentage of records were accepted / rejected?
-- COUNT(*) is the total; AVG of a 0/1 flag gives its share.
SELECT
  ROUND(100.0 * SUM(CASE WHEN Final_Status = 'Accepted' THEN 1 ELSE 0 END)
        / COUNT(*), 2) AS Acceptance_Rate_Pct,
  ROUND(100.0 * SUM(CASE WHEN Final_Status = 'Rejected' THEN 1 ELSE 0 END)
        / COUNT(*), 2) AS Rejection_Rate_Pct
FROM robotic_data;

-- Q4. Compare operators using rejection RATES (fairer than counts alone).
SELECT
  Operator_ID,
  COUNT(*) AS Total_Records,
  SUM(CASE WHEN Final_Status = 'Rejected' THEN 1 ELSE 0 END) AS Rejected_Records,
  ROUND(100.0 * SUM(CASE WHEN Final_Status = 'Rejected' THEN 1 ELSE 0 END)
        / COUNT(*), 1) AS Rejection_Rate_Pct
FROM robotic_data
GROUP BY Operator_ID
ORDER BY Rejection_Rate_Pct DESC;

-- Q5. Which tasks have the highest rejection percentage?
SELECT
  Task_Type,
  COUNT(*) AS Total_Records,
  SUM(CASE WHEN Final_Status = 'Rejected' THEN 1 ELSE 0 END) AS Rejected_Records,
  ROUND(100.0 * SUM(CASE WHEN Final_Status = 'Rejected' THEN 1 ELSE 0 END)
        / COUNT(*), 1) AS Rejection_Rate_Pct
FROM robotic_data
GROUP BY Task_Type
ORDER BY Rejection_Rate_Pct DESC;

-- Q6. What is the video quality distribution?
SELECT Video_Quality, COUNT(*) AS Record_Count
FROM robotic_data
GROUP BY Video_Quality
ORDER BY Record_Count DESC;

-- Q7. How many records have each kind of defect?
-- Each rejected record was assigned EXACTLY ONE defect in this beginner dataset.
SELECT 'Poor Video' AS Defect_Type, COUNT(*) AS Records
FROM robotic_data WHERE Video_Quality = 'Poor'
UNION ALL
SELECT 'Incorrect Annotation', COUNT(*)
FROM robotic_data WHERE Annotation_Status = 'Incorrect'
UNION ALL
SELECT 'Incomplete Trajectory', COUNT(*)
FROM robotic_data WHERE Trajectory_Status = 'Incomplete';

-- Q8. Quick validation: find rows whose recorded status breaks our rule.
-- The rule: good video + correct annotation + complete trajectory => Accepted.
-- Expected result: 0 rows.
SELECT *
FROM robotic_data
WHERE Final_Status <>
  CASE
    WHEN Video_Quality = 'Good'
     AND Annotation_Status = 'Correct'
     AND Trajectory_Status = 'Complete'
    THEN 'Accepted'
    ELSE 'Rejected'
  END;
