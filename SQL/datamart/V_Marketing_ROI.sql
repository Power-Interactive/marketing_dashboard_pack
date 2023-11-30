WITH
--商談数
T1
AS
(
SELECT 
  CONCAT(LEFT(datamart.fiscal_year(DATE(created_datetime, "Asia/Tokyo")),4),"年") AS year,
  datamart.lead_source(detailded_opportunity_source) AS lead_source, --永続関数を参照
  COUNT(DISTINCT id) AS Opp_count,
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity`
GROUP BY
  1,2
),

--受注金額、件素
T2
AS
(
SELECT 
  CONCAT(LEFT(datamart.fiscal_year(DATE(created_datetime, "Asia/Tokyo")),4),"年") AS year,
  datamart.lead_source(detailded_opportunity_source) AS lead_source, --永続関数を参照
  COUNT(DISTINCT id) AS oppwon_count,
  sum(amount) AS amount
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity`
WHERE
  forecast_phase IN ("Closed","Won")
GROUP BY
  1,2
)

SELECT
  ROI.Year AS year,
  datamart.lead_source(ROI.Channel) AS lead_source, --永続関数を参照
  T1.Opp_count AS opp_count, --商談数
  T2.OppWon_count AS oppwon_count, --受注数
  T2.amount AS amount, --受注金額
  ROI.Cost as cost
FROM
  `pi-dev-dashboard.master.MarketingROI` AS ROI
LEFT JOIN
  T1 AS T1
ON
  ROI.Year = T1.year
  AND
  datamart.lead_source(ROI.Channel) = T1.lead_source
LEFT JOIN
  T2 AS T2
ON
  ROI.Year = T2.year
  AND
  datamart.lead_source(ROI.Channel) = T2.lead_source
