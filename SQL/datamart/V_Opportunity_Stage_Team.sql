WITH
T1
AS
(
SELECT 
  S1.close_date,
  OH.system_modified_datetime AS  activity_date,
  S1.id id,
  S1.name AS account,
  S1.account_id accountid,
  S1.owner_id,

  datamart.ForecastCategory(S1.forecast_phase) AS stage_name, --StageName
  datamart.ForecastCategory(OH.new_value) AS new_value, --NewValue
  datamart.ForecastCategory(OH.old_value) AS old_value, --OldValue

  S1.amount,
  S2.name AS account_name,
  S3.department,
  S3.office ,
  concat(S3.last_name, S3.first_name) user
FROM
  `pi-dashboard-398109.datawarehouse.Opportunity`  AS S1  --SFA.OppotunitySnapshot_*から変更 
LEFT JOIN
  `pi-dashboard-398109.datamart.V_Opportunity_History` AS OH --商談の変更履歴
ON
  S1.id = OH.opportunity_id
LEFT JOIN 
  `pi-dashboard-398109.datawarehouse.Account` AS S2
ON
  S1.account_id = S2.id
LEFT JOIN
  `pi-dashboard-398109.datawarehouse.User` AS S3
ON
  S1.owner_id = S3.id
WHERE
  S1.id IS NOT NULL
)

SELECT
  T1.* 
FROM
  T1 AS T1
