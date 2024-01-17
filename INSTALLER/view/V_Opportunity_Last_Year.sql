WITH
T1
AS
(
SELECT
  close_date AS closed_date,
  close_date AS month,
  CONCAT(EXTRACT(YEAR FROM  DATE (close_date)),"年",EXTRACT(month FROM  DATE (close_date)),"月") year_month,
  #Datamart#.fiscal_year(close_date) AS fiscal_year,
  /*
  CASE
    WHEN CAST(fiscal_year AS STRING) IN ('1') THEN CONCAT(1 + EXTRACT(YEAR FROM  DATE(close_date)),".Q1")
    WHEN CAST(fiscal_year AS STRING) IN ('2') THEN CONCAT(EXTRACT(YEAR FROM  DATE(close_date)),".Q2")
    WHEN CAST(fiscal_year AS STRING) IN ('3') THEN CONCAT(EXTRACT(YEAR FROM  DATE(close_date)),".Q3")
    WHEN CAST(fiscal_year AS STRING) IN ('4') THEN CONCAT(EXTRACT(YEAR FROM  DATE(close_date)),".Q4")
  END fiscal_year,
  */

  date_sub(close_date, INTERVAL 1 Year) closed_date_lastyear,
  detailded_opportunity_source AS lead_source, --本来はLeadSourceが入る
  CASE
    WHEN forecast_phase IN ("Closed","Won") THEN 'Closed Won'
    WHEN forecast_phase IN ("Omitted","Lost") THEN 'Closed Lost'
    ELSE 'Other'
  END stage_name,
  COUNT(DISTINCT id) opportunity_count
FROM
  `#Project-id#.#data-Ware-house#.Opportunity`
WHERE
  forecast_phase in ('Closed','Omitted','Won','Lost')
GROUP BY
  close_date,
  fiscal_year,
  detailded_opportunity_source,
  stage_name
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
  T1.Closed_date_lastyear = S1.Closed_date
  AND
  T1.lead_source = S1.lead_source
  AND
  T1.stage_name = S1.stage_name
)

SELECT 
  *
FROM
  T2