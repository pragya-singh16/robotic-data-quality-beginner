# Robotic Data Quality Analysis using SQL & Excel

> **Beginner-friendly, simulation-only portfolio project.**
> No physical robots, real robotic demonstrations, Skild AI datasets, or real collection experiments were used.

![Dashboard preview](screenshots/dashboard_preview.png)

## Overview

This project demonstrates how an analyst can check the quality of **100 synthetic robotic task records** using **basic SQLite queries** and an **Excel dashboard**.

Imagine an operations team collecting demonstrations of simple tasks (such as picking and placing an object). Before the collected data is used, someone checks whether its video, annotation, and trajectory information are acceptable. This project simulates that simple check.

## Dataset and acceptance rule

| Column | Meaning |
|---|---|
| `Record_ID` | Unique demonstration ID |
| `Operator_ID` | Simulated person collecting the record |
| `Task_Type` | Pick and Place, Object Sorting, or Box Moving |
| `Collection_Date` | Simulated collection date |
| `Video_Quality` | Good / Poor |
| `Annotation_Status` | Correct / Incorrect |
| `Trajectory_Status` | Complete / Incomplete |
| `Final_Status` | Accepted / Rejected |

**Acceptance rule:** A record is **Accepted** only when `Video_Quality = Good`, `Annotation_Status = Correct`, AND `Trajectory_Status = Complete`. Otherwise it is **Rejected**.

For clarity, **every rejected record has exactly one injected defect**. This simplifies defect counting, but is a limitation compared with real collection workflows where defects can overlap.

## Tools

- **SQLite / DB Browser for SQLite** — run beginner SQL queries.
- **Microsoft Excel** — explore the data, read formula-based summaries, and view charts.
- **GitHub** — publish the project and documentation.

## Project files

```text
robotic-data-quality-beginner/
├── README.md
├── dataset/
│   └── robotic_task_data.csv
├── sql/
│   ├── schema.sql
│   └── data_quality_analysis.sql
├── excel/
│   └── data_quality_dashboard.xlsx
├── screenshots/
│   └── dashboard_preview.png
├── documentation/
│   ├── beginner_explanation.md
│   ├── github_upload_guide.md
│   └── interview_prep.md
└── .gitignore
```

## Calculated findings (on this synthetic dataset only)

| Metric | Calculated result |
|---|---:|
| Total records | 100 |
| Accepted records | 72 |
| Rejected records | 28 |
| Acceptance rate | 72% |
| Rejection rate | 28% |
| Poor video defects | 12 |
| Incorrect annotation defects | 9 |
| Incomplete trajectory defects | 7 |
| Highest operator rejection rate | OP03: 11/25 = 44% |
| Highest task rejection rate | Object Sorting: 12/40 = 30% |

These are **results from a generated example**, not observed trends in real robot operations. The dataset's defect distribution was deliberately constructed for learning. You should not infer why OP03 or Object Sorting has more rejections without a real-world investigation.

## SQL analysis

Eight annotated queries in [`sql/data_quality_analysis.sql`](sql/data_quality_analysis.sql) calculate:
1. Total records
2. Accepted/rejected counts
3. Acceptance/rejection rates
4. Operator rejection rates
5. Task rejection rates
6. Video-quality distribution
7. Three defect categories
8. Status-rule consistency check

The main SQL concepts are `SELECT`, `WHERE`, `COUNT`, `SUM`, `CASE`, `GROUP BY`, `ORDER BY`, and `ROUND`. No joins or advanced SQL features are required.

## Excel dashboard

Open [`excel/data_quality_dashboard.xlsx`](excel/data_quality_dashboard.xlsx):
- `Data` — all 100 original synthetic records.
- `Analysis` — formula-based operator, task, video, and defect summaries.
- `Dashboard` — five KPIs and three charts.

The numbers are calculated from the `Data` sheet with `COUNTIF`, `COUNTIFS` and basic formulas. Charts are linked to the `Analysis` sheet. The workbook is designed for Microsoft Excel; open it in Excel to view/refresh chart rendering.

## Run SQL in DB Browser for SQLite (beginner steps)

1. Install [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Open the app, then use **File → Import → Table from CSV file**.
3. Select `dataset/robotic_task_data.csv`, name the table **`robotic_data`**, choose a comma delimiter, tick **Column names in first line**, and finish. Save the database when prompted.
4. Open the **Execute SQL** tab and paste queries from `sql/data_quality_analysis.sql` **one query at a time**. Click the Run/Execute button.
5. Check: total **100**, accepted **72**, rejected **28**, acceptance rate **72%**.
6. The `sql/schema.sql` file documents the table structure. **You don't need to run it if you imported the CSV as a new table**. (It drops/recreates the table, so running it afterwards would erase your imported rows.)

**Optional SQLite command-line route** from the repository root:

```bash
sqlite3 robotic_data.db
```
Then enter these lines in the SQLite prompt:

```text
.read sql/schema.sql
.mode csv
.import --skip 1 dataset/robotic_task_data.csv robotic_data
.read sql/data_quality_analysis.sql
```

SQLite CLI commands beginning with a dot (`.`) are not ordinary SQL statements.

## Quality interpretation and improvement ideas

- **Measured in this simulated dataset:** 28 rejected records; the most frequent injected defect is Poor Video (12).
- **Possible checks to investigate in practice (not validated):**
  - Add a pre-collection camera/lighting checklist to reduce unusable videos.
  - Use reference examples and annotation review to reduce labeling mistakes.
  - Add a trajectory-completeness check before accepting submissions.
- **Fair operator comparison:** compare rejection **rates**, not only rejected counts; real investigations should also control for task difficulty, environment, and workload.
- **Example 5 Whys hypothesis:** Bad video → poor lighting → setup not checked → checklist missing → quality control performed only after collection. This is **illustrative, not a discovered root cause**.

## Limitations

- All data is synthetic and intentionally simplified.
- Exactly one defect per rejected record; no overlapping defects, missing fields, duplicates, or annotation agreement scores.
- This project does not involve robotics hardware, model training, or real-world experiments.
- No process improvement has been tested, deployed, or proven effective.

## More resources

- [Step-by-step beginner explanation](documentation/beginner_explanation.md)
- [GitHub upload guide](documentation/github_upload_guide.md)
- [Interview answers + resume bullet points](documentation/interview_prep.md)

## Disclaimer

**This is an independently created educational simulation.** It is not affiliated with or endorsed by Skild AI and does not use proprietary or collected robot data.
