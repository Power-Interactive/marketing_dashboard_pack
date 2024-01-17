WITH
--商談数
T1
AS
(
SELECT 
  CONCAT(LEFT(#Datamart#.fiscal_year(DATE(created_datetime, "Asia/Tokyo")),4),"年") AS Year,
  #Datamart#.lead_source(detailded_opportunity_source) AS lead_source, --永続関数を参照
  COUNT(DISTINCT id) AS opp_count,
FROM
  `#Project-id#.#data-Ware-house#.Opportunity`
GROUP BY
  1,2
),

--受注金額、件素
T2
AS
(
SELECT 
  CONCAT(LEFT(#Datamart#.fiscal_year(DATE(created_datetime, "Asia/Tokyo")),4),"年") AS Year,
  #Datamart#.lead_source(detailded_opportunity_source) AS lead_source, --永続関数を参照
  COUNT(DISTINCT id) AS oppwon_count,
  sum(amount) AS amount
FROM
  `#Project-id#.#data-Ware-house#.Opportunity`
WHERE
  forecast_phase IN ("Closed","Won")
GROUP BY
  1,2
)

SELECT
  ROI.year,
  #Datamart#.lead_source(ROI.channel) AS lead_source, --永続関数を参照
  T1.Opp_count AS opp_count, --商談数
  T2.OppWon_count AS oppwon_count, --受注数
  T2.amount AS amount, --受注金額
  ROI.cost
FROM
  `#Project-id#.#data-Ware-house#.Marketing_ROI_Master` AS ROI
LEFT JOIN
  T1 AS T1
ON
  ROI.year = T1.Year
  AND
  #Datamart#.lead_source(ROI.channel) = T1.lead_source
LEFT JOIN
  T2 AS T2
ON
  ROI.Year = T2.Year
  AND
  #Datamart#.lead_source(ROI.Channel) = T2.lead_source