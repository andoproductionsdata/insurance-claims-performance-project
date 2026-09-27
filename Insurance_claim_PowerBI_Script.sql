DECLARE @report_date DATE = '2025-01-01';

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