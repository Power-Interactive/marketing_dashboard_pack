WITH
--リード獲得
T1
AS
(
SELECT
  CAST(CAST(updated_datetime AS DATETIME) AS DATE) AS change_date,
  datamart.lead_source(lead_source) AS lead_source,
  datamart.lifecycle_status(new_value) AS phase,
  COUNT(Distinct lead_id) result
FROM
  `pi-dev-dashboard.re_datamart.V_Lead_ChangeDataValue` --開発時に参照先を変更する必要がある(re_datamart→datamart)
GROUP BY
  1,2,3
),


--ClosedWon_OpportunityID
T2
AS
(
SELECT 
  DATE(S1.system_modified_datetime, "Asia/Tokyo") AS change_date,
  datamart.lead_source(S2.detailded_opportunity_source) AS lead_source,
  CASE
    WHEN S2.forecast_phase IN ("Closed","Won") THEN '受注件数' --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  END phase,
  COUNT(DISTINCT S2.id) result,
FROM
  `pi-dev-dashboard.re_datamart.V_Opportunity_History` AS S1 --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  --開発時に参照先を変更する必要がある(re_datamart→datamart)
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.Opportunity` AS S2
ON
  S1.opportunity_id = S2.id
WHERE
  S2.forecast_phase IN ("Closed","Won")
  AND
  datamart.lead_source(S2.detailded_opportunity_source) IS NOT NULL
GROUP BY
  1,2,3
),

--ClosedWon_amount
T3
AS
(
SELECT 
  DATE(S1.system_modified_datetime, "Asia/Tokyo") AS change_date,
  datamart.lead_source(S2.detailded_opportunity_source) AS lead_source,
  CASE
    WHEN S2.forecast_phase IN ("Closed","Won") THEN '受注金額' --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  END phase,
  sum(S2.amount) result
FROM
  `pi-dev-dashboard.re_datamart.V_Opportunity_History` AS S1 --他社への実装時に修正が必要（ForecastCategoryの値に合わせて変更）
  --開発時に参照先を変更する必要がある(re_datamart→datamart)
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.Opportunity` AS S2
ON
  S1.opportunity_id = S2.id
WHERE
  S2.forecast_phase IN ("Closed","Won")
  AND
  datamart.lead_source(S2.detailded_opportunity_source) IS NOT NULL
GROUP BY
  1,2,3
)

SELECT
  change_date,
  lead_source,
  datamart.phase_label(phase) AS phase,
  result
FROM
  T1

UNION ALL

SELECT
  change_date,
  lead_source,
  datamart.phase_label(phase) AS phase,
  result
FROM
  T2

UNION ALL

SELECT
  change_date,
  lead_source,
  datamart.phase_label(phase) AS phase,
  result
FROM
  T3
