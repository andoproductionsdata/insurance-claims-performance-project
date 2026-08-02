# 🏥 Insurance Claims Performance Dashboard

## Project Overview

This project simulates a real-world insurance claims environment for **Insurix**, a fictional insurance company. Following concerns from the National Consumer Protection Association (NCPA) regarding delayed claim processing, the business required a reporting solution to improve visibility into claims operations and monitor key performance indicators (KPIs).

Using **SQL Server** and **Power BI**, I designed and developed an interactive dashboard that enables stakeholders to monitor claim processing, track agent productivity, identify bottlenecks, and improve operational decision-making. :contentReference[oaicite:0]{index=0}

---

# Business Problem

Insurix lacked a centralized reporting solution for monitoring insurance claims.

This made it difficult to:

- Monitor claims over 100 days old
- Track monthly claims created and closed
- Measure agent productivity
- Identify processing bottlenecks
- Monitor claim types and workload distribution
- Meet regulatory service targets

---

# Solution

Using **SQL Server** and **Power BI**, I built an end-to-end reporting solution that:

- Cleans and transforms insurance claims data
- Calculates claim age and due dates
- Categorizes claims into aging buckets
- Tracks open and closed claims
- Monitors KPI performance
- Provides interactive dashboards for managers and executives

---

# Tech Stack

- SQL Server
- Microsoft SQL Server Management Studio (SSMS)
- Power BI
- DAX
- Power Query

---

# Database Schema

The project uses two core business tables:

- **claim**
- **account**

These tables are transformed into a reporting dataset using SQL before being loaded into Power BI.

*(Insert database schema image here.)*

---

# SQL Highlights

This project demonstrates:

- CASE statements
- DATEDIFF calculations
- Date logic
- Data transformation
- Reporting datasets
- KPI calculations

The SQL solution:

- Converts claim status codes into readable values
- Calculates claim age
- Creates claim age categories
- Calculates days until the 100-day service target
- Produces a clean reporting dataset for Power BI

*(Insert SQL image here.)*

---

# Power BI Dashboard

The dashboard contains five report pages:

- Claims Overview
- Agent Claims Performance
- Open Claims Management
- Closed Claims Performance
- Raw Data

*(Insert dashboard screenshots here.)*

---

# Key Features

- KPI scorecards
- Claims aging analysis
- Open claims tracking
- Closed claims reporting
- Agent productivity analysis
- Claim type analysis
- Month-on-month trend reporting
- Interactive slicers
- Drill-through reporting

---

# Technical Challenges

## Managing Multiple Date Relationships

One of the biggest challenges was accurately reporting both **claims created** and **claims closed** while allowing both metrics to respond to the same report filters.

To solve this, I:

- Created duplicate reporting tables
- Used a reference Date table
- Built reference tables for Agent and Claim Type
- Connected all tables through a star schema

This ensured filters worked correctly across both creation and closure reporting.

---

# Project Outcomes

The dashboard provides Insurix with a centralized view of claims operations, replacing manual reporting with interactive dashboards.

Business users can now:

- Monitor claims over 100 days old
- Track monthly claims created and closed
- Identify processing bottlenecks
- Compare agent performance
- Prioritize overdue claims
- Support faster, data-driven decision-making

---

# Files Included

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

# Skills Demonstrated

- SQL
- Data Modelling
- ETL
- Power BI
- DAX
- Data Visualization
- KPI Reporting
- Business Analysis
- Dashboard Design
- Claims Analytics
