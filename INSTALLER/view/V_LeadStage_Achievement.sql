WITH
--リード獲得
T1
AS
(
SELECT
  CAST(CAST(updated_datetime AS DATETIME) AS DATE) AS change_date,
  #Datamart#.lead_source(lead_source) AS lead_source,
  #Datamart#.lifecycle_status(new_value) AS phase,
  COUNT(Distinct lead_id) result
FROM
  `#Project-id#.#Datamart#.V_Lead_ChangeDataValue`
GROUP BY
  1,2,3
),


--ClosedWon_OpportunityID
T2
AS
(
SELECT 
  DATE(S1.system_modified_datetime, "Asia/Tokyo") AS change_date,
  #Datamart#.lead_source(S2.detailded_opportunity_source) AS lead_source,
  CASE
    WHEN S2.forecast_phase IN ("Closed","Won") THEN '受注件数' --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  END phase,
  COUNT(DISTINCT id) result,
FROM
  `#Project-id#.#Datamart#.V_Opportunity_History` AS S1 --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
LEFT JOIN
  `#Project-id#.#data-Ware-house#.Opportunity` AS S2
ON
  S1.opportunity_id = S2.id
WHERE
  S2.forecast_phase IN ("Closed","Won")
  AND
  #Datamart#.lead_source(S2.detailded_opportunity_source) IS NOT NULL
GROUP BY
  1,2,3
),

--ClosedWon_amount
T3
AS
(
SELECT 
  DATE(S1.system_modified_datetime, "Asia/Tokyo") AS change_date,
  #Datamart#.lead_source(S2.detailded_opportunity_source) AS lead_source,
  CASE
    WHEN S2.forecast_phase IN ("Closed","Won") THEN '受注金額' --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  END phase,
  sum(amount) result
FROM
  `#Project-id#.#Datamart#.V_Opportunity_History` AS S1 --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
LEFT JOIN
  `#Project-id#.#data-Ware-house#.Opportunity` AS S2
ON
  S1.opportunity_id = S2.id
WHERE
  S2.forecast_phase IN ("Closed","Won")
  AND
  #Datamart#.lead_source(S2.detailded_opportunity_source) IS NOT NULL
GROUP BY
  1,2,3
)

SELECT
  change_date,
  lead_source,
  #Datamart#.phase_label(phase) AS phase,
  result
FROM
  T1

UNION ALL

SELECT
  change_date,
  lead_source,
  #Datamart#.phase_label(phase) AS phase,
  result
FROM
  T2

UNION ALL

SELECT
  change_date,
  lead_source,
  #Datamart#.phase_label(phase) AS phase,
  result
FROM
  T3
