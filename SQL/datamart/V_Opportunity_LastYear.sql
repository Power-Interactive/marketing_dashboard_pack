WITH
T1
AS
(
SELECT
  close_date AS closed_date,
  close_date AS month,
  CONCAT(EXTRACT(YEAR FROM  DATE (close_date)),"年",EXTRACT(month FROM  DATE (close_date)),"月") year_month,

  datamart.fiscal_year(close_date) AS fiscal_year,

  date_sub(close_date, INTERVAL 1 Year) closed_date_lastyear,
  opportunity_source AS lead_source, --本来はLeadSourceが入る
  CASE
    WHEN forecast_phase IN ("Closed","Won") THEN 'Closed Won'
    WHEN forecast_phase IN ("Omitted","Lost") THEN 'Closed Lost'
    ELSE 'Other'
  END stage_name,
  COUNT(DISTINCT id) opportunity_count
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity`
WHERE
  forecast_phase in ('Closed','Omitted','Won','Lost')
GROUP BY
  1,2,3,4,5,6,7
),

T2
AS
(
SELECT
  T1.*,
  S1.opportunity_count AS opportunity_count_lastyear
FROM
  T1 AS T1
LEFT JOIN
  T1 AS S1
ON
  T1.closed_date_lastyear = S1.closed_date
  AND
  T1.lead_source = S1.lead_source
  AND
  T1.stage_name = S1.stage_name
)

SELECT 
  *
FROM
  T2
