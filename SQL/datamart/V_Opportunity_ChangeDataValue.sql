WITH
T1
AS
(
SELECT
  CAST(OH.system_modified_datetime AS DATE) AS change_phase_date,
  CAST(OH.old_value_date AS DATE) AS old_change_phase_date,
  CAST(t1.created_datetime AS DATE) AS created_date,
  t1.name AS opportunity_name,
  t1.id AS opportunity_id,
  t1.opportunity_source AS lead_source,
  t1.detailded_opportunity_source AS detailded_lead_source,

  datamart.forecast_category(OH.new_value) AS new_value, --NewValue 永続関数を参照
  datamart.forecast_category(OH.old_value) AS old_value, --OldValue 永続関数を参照

  t1.amount AS amount,
  CONCAT(t2.last_name,t2.first_name) AS user
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity` AS t1
  LEFT JOIN
  `pi-dev-dashboard.re_datamart.V_Opportunity_History` AS OH --商談の変更履歴
ON
  t1.id = OH.opportunity_id
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.User` t2
ON t1.owner_id = t2.Id
WHERE
  t1.created_datetime IS NOT NULL
),

T1_tmp
AS
(
SELECT
  distinct *
FROM
  T1
),

T2
AS
(
SELECT
  change_phase_date,
  old_change_phase_date,
  created_date,
  opportunity_name,
  opportunity_id,
  lead_source,
  detailded_lead_source,
  new_value,
  old_value,
  amount,
  user
FROM
  T1_tmp
)

SELECT
  change_phase_date AS date, --change_phase_date
  datamart.fiscal_year(change_phase_date) AS fiscal_year, --永続関数を参照
  IFNULL(old_change_phase_date,created_date) old_change_phase_date,
  created_date,
  opportunity_name,
  opportunity_id,
  lead_source,
  detailded_lead_source,
  new_value,
  old_value,
  amount,
  user,
  CASE WHEN new_value IN ('1.Pipeline') THEN date_diff(change_phase_date,IFNULL(old_change_phase_date,created_date),DAY) ELSE NULL END pipeline_days, --商談作成日で計算
  CASE WHEN new_value IN ('2.BestCase') THEN date_diff(change_phase_date,IFNULL(old_change_phase_date,created_date),DAY) ELSE NULL END bestCase_days,
  CASE WHEN new_value IN ('3.Commit') THEN date_diff(change_phase_date,IFNULL(old_change_phase_date,created_date),DAY) ELSE NULL END commit_days,
  CASE WHEN new_value IN ('4.Closed Won') THEN date_diff(change_phase_date,IFNULL(old_change_phase_date,created_date),DAY) ELSE NULL END closedWon_days,
FROM
  T2 AS T2
