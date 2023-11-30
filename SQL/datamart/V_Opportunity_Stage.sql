WITH
T1
AS
(
SELECT 
  S1.close_date,
  OH.system_modified_datetime AS  activity_date,
  S1.id AS id, --商談ID
  S1.name AS account,
  S1.account_id AS accountid,
  S1.owner_id AS owner_id,

  datamart.forecast_category(S1.forecast_phase) AS stage_name, --stage_name 永続関数を参照
  datamart.forecast_category(OH.new_value) AS new_value, --new_value 永続関数を参照
  datamart.forecast_category(OH.old_value) AS old_value, --old_value 永続関数を参照

  S1.amount,
  S2.name AS account_name,
  S3.department,
  S3.office ,
  concat(S3.last_name, S3.first_name) AS user
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity`  AS S1
LEFT JOIN
  `pi-dev-dashboard.re_datamart.V_Opportunity_History` AS OH --商談の変更履歴
ON
  S1.id = OH.opportunity_id
LEFT JOIN 
  `pi-dev-dashboard.datawarehouse.Account` AS S2
ON
  S1.account_id = S2.Id
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.User` AS S3
ON
  S1.owner_id = S3.Id
WHERE
  S1.id IS NOT NULL --商談IDがNULLでない
)

SELECT
  T1.* 
FROM
  T1 AS T1
