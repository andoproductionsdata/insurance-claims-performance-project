# 🏥 Insurance Claims Performance Project

## Project Overview

This project simulates a real-world insurance claims environment for **Insurix**, a fictional insurance company.

Following concerns from the National Consumer Protection Association (NCPA) regarding delayed claim processing, the business required greater visibility into claims operations and the ability to monitor claims approaching or exceeding key service targets.

To address this challenge, I designed and developed an interactive **Power BI dashboard using SQL Server as the data source**.

The solution provides a centralised view of claims performance, allowing managers to monitor claims aging, track open and closed claims, assess agent productivity, identify processing bottlenecks, and make data-driven decisions.



<img width="1536" height="1024" alt="Insurance thumbnail" src="https://github.com/user-attachments/assets/e5245745-05b0-4dbf-b0d2-1640e9173ac7" />


---

# 🏥 Business Problem

Insurix lacked a centralised reporting solution for monitoring insurance claims performance.

This made it difficult to:

- Monitor claims exceeding 100 days
- Track monthly claims created and closed
- Identify aging claims requiring attention
- Measure agent productivity
- Identify processing bottlenecks
- Monitor workload across different claim types
- Support regulatory and service-level reporting

---

# 🏥 Business Requirements & KPI Targets

The dashboard was designed around an important claims processing target:

- **Claims over 100 days: Below 15**

This KPI allows managers to quickly identify whether claims are being processed within expected timeframes and highlights areas where additional attention may be required.

The reporting solution also needed to provide visibility into:

- Claims created and closed each month
- Open claims by age
- Claim processing trends
- Agent productivity
- Claim type distribution
- Claims approaching the 100-day threshold

---

# 🏥 Solution

Using **SQL Server and Power BI**, I developed an end-to-end reporting solution that:

- Cleans and transforms raw insurance claims data
- Converts claim status codes into readable business values
- Calculates the age of each claim
- Categorises claims into aging buckets
- Calculates days remaining before the 100-day target
- Tracks open and closed claims
- Monitors claims exceeding the 100-day threshold
- Measures agent productivity
- Provides interactive dashboards for managers and operational teams



<img width="1536" height="1024" alt="Insurance Project Solution" src="https://github.com/user-attachments/assets/a131e917-fde0-4000-ac41-e74bbc0cfe49" />


---

# 🏥 Tech Stack

- SQL
- Microsoft SQL Server Management Studio (SSMS)
- Power BI
- DAX
- Power Query

---

# 🏥 SQL Transformation

SQL was used to transform the raw claims data into a reporting-ready dataset before loading it into Power BI.

The transformation includes:

- Converting claim status codes into readable values
- Calculating claim age using `DATEDIFF`
- Creating claim aging categories
- Calculating days remaining until the 100-day threshold
- Preparing claim status and date fields for reporting
- Creating a clean dataset for Power BI

DECLARE @report_date DATE = '2025-01-01';


```sql
SELECT 
claim_id,
account_number,
claim_status,
date, -- created date
partition_date, -- action date
owner,
claim_type,
CASE WHEN claim_status = 'A' THEN 'Approved'
     WHEN claim_status = 'O' THEN 'Open'
	 WHEN claim_status = 'C' THEN 'Cancelled'
	 WHEN claim_status = 'D' THEN 'Declined'
	 END AS claim_status_true,
	 DATEDIFF(DAY, date, @report_date) as claim_age,
CASE WHEN DATEDIFF(DAY, date, @report_date) < 30 THEN 'a. 1 - 29 Days'
     WHEN DATEDIFF(DAY, date, @report_date) BETWEEN 30 AND 70 THEN 'b. 30 - 70 Days'
	 WHEN DATEDIFF(DAY, date, @report_date) BETWEEN 71 AND 100 THEN 'c. 71 - 100 Days'
	 WHEN DATEDIFF(DAY, date, @report_date) > 100 THEN 'd. 100 Days +'
	 END AS age_category,
CASE WHEN DATEDIFF(DAY, date, partition_date) < 30 THEN 'a. 1 - 29 Days'
     WHEN DATEDIFF(DAY, date, partition_date) BETWEEN 30 AND 70 THEN 'b. 30 - 70 Days'
	 WHEN DATEDIFF(DAY, date, partition_date) BETWEEN 71 AND 100 THEN 'c. 71 - 100 Days'
	 WHEN DATEDIFF(DAY, date, partition_date) > 100 THEN 'd. 100 Days +'
	 END AS completed_age_category,
	 DATEDIFF(DAY,@report_date, DATEADD(DAY, 100, date)) as days_until_due_date
FROM claim
```

---

# 🏥 Key Challenge & Solution

One of the key challenges was accurately reporting both **claims created** and **claims closed** while allowing users to analyse the data using consistent report filters.

Claims are created on one date but may be closed on a completely different date. This means the dashboard needs to analyse multiple date relationships depending on the metric being calculated.

To solve this, I:

- Created dedicated reporting tables for different claim metrics
- Used a central Date table
- The partition date was used to identify when a claim was closed and the date field to identify when the claim was created.

<img width="1794" height="877" alt="Schema tables dates" src="https://github.com/user-attachments/assets/33b93909-79e6-45b8-83d5-f26d82b8dd69" />


- Created reference tables for Agent and Claim Type
- Connected the reporting tables using a star schema
- Built DAX measures to calculate claims using the appropriate date relationships

<img width="1620" height="786" alt="Ref Tables 2 JPG" src="https://github.com/user-attachments/assets/f37a9e8f-dcfc-4fc7-b728-0bbbf421b7e4" />


This allows users to analyse both created and closed claims accurately while maintaining consistent filtering across the dashboard.

<img width="1672" height="941" alt="Insurance Challenge and Solution" src="https://github.com/user-attachments/assets/03b66ea6-8a9f-46eb-8902-f3be279abcf0" />


---

# 🏥 Power BI Dashboard

The Power BI solution contains five report pages:

## Claims Overview

This page provides managers with a high-level view of overall claims performance.

The dashboard focuses on the key target of keeping **claims over 100 days below 15**, while also providing visibility into claims created, claims closed, claim types, and monthly performance trends.

**KPI Monitoring:** Quickly identify whether the business is meeting the target for claims over 100 days.

**Claims Volume:** Monitor the number of claims created and closed.

**Trend Analysis:** Track claims performance over time and identify changes in workload.

**Claim Type Analysis:** Understand how claims are distributed across different claim types.

<img width="1481" height="831" alt="Insurance claims page 1 v2" src="https://github.com/user-attachments/assets/b04fb664-a8de-4b49-ab56-059910af4897" />


---

## Agent Claims Performance

This page provides managers with detailed visibility into individual agent performance.

It allows users to compare the number and types of claims being handled by each agent and identify differences in productivity across the team.

**Agent Performance:** Compare claim volumes across individual agents.

**Productivity Monitoring:** Identify agents closing higher or lower volumes of claims.

**Workload Analysis:** Understand the types of claims being managed by each agent.

**Performance Support:** Identify areas where additional support or workload balancing may be required.

<img width="1489" height="841" alt="Insurance page 2" src="https://github.com/user-attachments/assets/b96a613e-5757-4555-aa28-c8f8b0dd609b" />


---

## Open Claims Management

This page focuses specifically on claims that are still open and require ongoing management.

Claims are grouped into aging categories, allowing managers to quickly identify older claims and prioritise cases approaching or exceeding the 100-day threshold.

**Claims Aging:** Group open claims into age categories.

**Overdue Claims:** Quickly identify claims exceeding 100 days.

**Claims Prioritisation:** Highlight claims requiring immediate attention.

**Owner Visibility:** Identify the agent responsible for each open claim.

<img width="1490" height="842" alt="insurance page 3" src="https://github.com/user-attachments/assets/277ec3fb-797f-4668-ab96-1d41d614cf43" />

---

## Closed Claims Performance

This page provides visibility into completed claims and closure trends over time.

Managers can monitor monthly closure volumes, compare performance with previous periods, and analyse closed claims by claim type and processing age.

**Closure Trends:** Monitor the number of claims closed over time.

**Month-on-Month Analysis:** Compare closure performance against the previous month.

**Claim Type Analysis:** Understand which types of claims are being completed.

**Processing Time:** Analyse how long claims took to reach completion.

<img width="1491" height="840" alt="Insurance page 4" src="https://github.com/user-attachments/assets/0b3713ca-3ad9-4e97-a19d-8e7004eea5a0" />

---

## Raw Data

This page provides access to the underlying reporting data used throughout the dashboard.

It allows users to review individual claim records and investigate specific cases when more detailed analysis is required.

**Detailed Claims:** Review individual claim records.

**Data Validation:** Support investigation and validation of dashboard results.

**Operational Analysis:** Drill into specific claims requiring further investigation.

<img width="1491" height="839" alt="Insurance page 5" src="https://github.com/user-attachments/assets/ac0b9e14-24d3-46eb-b51e-1acbcaf80669" />

---

Each page is designed for a different level of analysis, allowing users to move from high-level claims performance down to individual claims and agent-level results.

---

# 🏥 Key Features

The dashboard includes:

- KPI scorecards
- Claims aging analysis
- Open claims tracking
- Closed claims reporting
- Agent productivity analysis
- Claim type analysis
- Month-on-month trend reporting
- Interactive slicers and filters
- Target-based KPI indicators
- Detailed claim-level reporting

---

# 🏥 How the Dashboard Supports Decisions

The dashboard helps managers quickly understand what is happening across insurance claims operations.

Managers can now:

- Identify claims approaching or exceeding 100 days
- Prioritise older claims requiring attention
- Monitor monthly claims created and closed
- Compare agent productivity
- Identify processing bottlenecks
- Monitor workload across different claim types
- Track claims performance over time
- Support workload and resource planning

---

# 🏥 Business Impact & Benefits

The solution provides Insurix with a centralised and interactive view of claims operations.

This solution allows the business to:

- Monitor important claims KPIs in one place
- Identify aging and overdue claims earlier
- Track monthly claims volumes and closure trends
- Compare agent productivity
- Prioritise claims requiring immediate attention
- Improve visibility into claims processing
- Support regulatory and service-level monitoring
- Reduce reliance on manual reporting
- Support faster, data-driven decisions

*(Insert Project Outcome image here.)*

---

# 🏥 Files Included

```text
📂 SQL Scripts
│── insurance_account_create_script.sql
│── insurance_accounts_insert.sql
│── insurance_claim_create_script.sql
│── Insurance_claim_insert.sql
│── Insurance_claim_PowerBI_Script.sql

📂 Power BI
│── Insurance Claims Dashboard.pbix

📂 Documentation
│── README.md
```

---

# 🏥 Skills Demonstrated

- SQL
- Data Modelling
- Data Transformation
- ETL
- Power BI
- DAX
- Power Query
- KPI Reporting
- Dashboard Design
- Business Analysis
- Data Visualisation
- Claims Analytics
- Business Requirements
- Problem Solving
