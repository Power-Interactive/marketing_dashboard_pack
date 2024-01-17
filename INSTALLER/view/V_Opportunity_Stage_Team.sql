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

  #Datamart#.ForecastCategory(S1.forecast_phase) AS stage_name, --StageName
  #Datamart#.ForecastCategory(OH.new_value) AS new_value, --NewValue
  #Datamart#.ForecastCategory(OH.old_value) AS old_value, --OldValue

  S1.amount,
  S2.name AS account_name,
  S3.department,
  S3.office ,
  concat(S3.last_name, S3.first_name) user
FROM
  `#Project-id#.#data-Ware-house#.Opportunity`  AS S1  --SFA.OppotunitySnapshot_*から変更 
LEFT JOIN
  `#Project-id#.#Datamart#.V_Opportunity_History` AS OH --商談の変更履歴
ON
  S1.id = OH.opportunity_id
LEFT JOIN 
  `#Project-id#.#data-Ware-house#.Account` AS S2
ON
  S1.account_id = S2.id
LEFT JOIN
  `#Project-id#.#data-Ware-house#.User` AS S3
ON
  S1.owner_id = S3.id
WHERE
  S1.id IS NOT NULL
)

SELECT
  T1.* 
FROM
  T1 AS T1
