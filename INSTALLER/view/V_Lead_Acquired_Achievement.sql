WITH
--リード獲得
T1
AS
(
SELECT
  DATE(created_datetime, "Asia/Tokyo") AS create_date,
  #Datamart#.lead_source(lead_source) AS lead_source,
  #Datamart#.lifecycle_status(lifecycle_status) AS phase,
  COUNT(Distinct id) result
FROM
  `#Project-id#.#data-Ware-house#.Leads`
GROUP BY
  1,2,3
),


--ClosedWon_OpportunityID
T2
AS
(
SELECT 
  DATE(created_datetime, "Asia/Tokyo") AS create_date,
  #Datamart#.lead_source(opportunity_source) AS lead_source,
  CASE
    WHEN forecast_phase IN ("Closed","Won") THEN '受注件数' --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  END phase,
  COUNT(DISTINCT id) result,
FROM
  `#Project-id#.#data-Ware-house#.Opportunity`
WHERE
  forecast_phase IN ("Closed","Won")
  AND
  #Datamart#.lead_source(opportunity_source) is not null
GROUP BY
  1,2,3
),

--ClosedWon_amount
T3
AS
(
SELECT 
  DATE(created_datetime, "Asia/Tokyo") AS create_date,
  #Datamart#.lead_source(opportunity_source) AS lead_source,
  CASE
    WHEN forecast_phase IN ("Closed","Won") THEN '受注金額' --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  END phase,
  sum(amount) result,
FROM
  `#Project-id#.#data-Ware-house#.Opportunity`
WHERE
  forecast_phase IN ("Closed","Won")
  AND
  #Datamart#.lead_source(opportunity_source) is not null
GROUP BY
  1,2,3
)

SELECT
  create_date,
  lead_source,
  #Datamart#.phase_label(phase) AS phase,
  result
FROM
  T1

UNION ALL

SELECT
  create_date,
  lead_source,
  #Datamart#.phase_label(phase) AS phase,
  result
FROM
  T2

UNION ALL

SELECT
  create_date,
  lead_source,
  #Datamart#.phase_label(phase) AS phase,
  result
FROM
  T3