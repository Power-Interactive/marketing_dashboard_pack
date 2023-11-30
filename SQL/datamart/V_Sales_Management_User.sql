WITH
T1
AS
(
SELECT
  Master.Month AS month,
  SFA.id AS id,
  SFA.department AS department,
  SFA.office AS office,
  Master.User AS user,
  Master.SalesTarget AS sales_target
FROM
  `pi-dev-dashboard.master.SalesTarget_User` AS Master
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.User` AS SFA
ON
  CONCAT(SFA.last_name,SFA.first_name) = Master.User
  AND
  SFA.department = Master.Department 
  AND
  SFA.office = Master.Office 
WHERE
  Master.Month IS NOT NULL
),

--新規
T2
AS
(
SELECT
  DATE_TRUNC(OP.close_date, MONTH) month,
  SFA.id AS id,
  SFA.department AS department,
  SFA.office AS office,
  CONCAT(SFA.last_name,SFA.first_name) AS user,
  OP.name AS new_opportunity, 
  CAST(SUM(OP.amount) AS NUMERIC) as new_amount,
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity` AS OP  --SFA.OppotunitySnapshot_*から変更
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.User` AS SFA
ON
  OP.owner_id = SFA.id
WHERE
  type IN ('新規','新規商談')
GROUP BY
  1,2,3,4,5,6
),

--既存
T3
AS
(
SELECT
  DATE_TRUNC(OP.close_date, MONTH) AS month,
  SFA.id AS id,
  SFA.department AS department,
  SFA.office AS office,
  CONCAT(SFA.last_name,SFA.first_name) AS user,
  OP.name AS keep_opportunity,
  CAST(SUM(OP.Amount) AS NUMERIC) as keep_amount
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity` AS OP
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.User` AS SFA
ON
  OP.owner_id = SFA.id
WHERE
  Type LIKE '%既存%' OR Type IS NULL --('既存','既存商談','')
GROUP BY
  1,2,3,4,5,6
),

T4
AS
(
SELECT
  DATE_TRUNC(OP.close_date, MONTH) AS month,
  SFA.id AS id,
  SFA.department AS department,
  SFA.office AS office,
  CONCAT(SFA.last_name,SFA.first_name) AS user,
  CASE WHEN OP.forecast_phase IN ('Commit') THEN OP.name END stage_commit, --完了予定
  CASE WHEN OP.forecast_phase IN ('Won','Closed Won','4.Closed Won') THEN OP.name END stage_closedwon, --受注
  CASE WHEN OP.forecast_phase IN ('Lost','Closed Lost','5.Closed Lost') THEN OP.name END stage_closedlost --失注
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity` AS OP  --SFA.OppotunitySnapshot_*から変更
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.User` AS SFA
ON
  OP.owner_id = SFA.id
)


SELECT
  T1.month,
  T1.id,
  T1.department ,
  T1.office ,
  T1.user,
  T1.sales_target,
  NULL new_opportunity,
  NULL new_amount,
  NULL keep_opportunity,
  NULL keep_amount,
  NULL stage_commit,
  NULL stage_closedwon,
  NULL stage_closedlost
FROM
  T1 AS T1

UNION ALL

SELECT
  T2.month,
  T2.id,
  T2.department ,
  T2.office ,
  T2.user,
  NULL sales_target,
  T2.new_opportunity,
  T2.new_amount,
  NULL keep_opportunity,
  NULL keep_amount,
  NULL stage_commit,
  NULL stage_closedwon,
  NULL stage_closedlost
FROM
  T2


UNION ALL

SELECT
  T3.month,
  T3.id,
  T3.department ,
  T3.office ,
  T3.user,
  NULL sales_target,
  NULL new_opportunity,
  NULL new_amount,
  T3.keep_opportunity,
  T3.keep_amount,
  NULL stage_commit,
  NULL stage_closedwon,
  NULL stage_closedlost
FROM
  T3


UNION ALL

SELECT
  T4.month,
  T4.id,
  T4.department ,
  T4.office ,
  T4.user,
  NULL sales_target,
  NULL new_opportunity,
  NULL new_amount,
  NULL keep_opportunity,
  NULL keep_amount,
  T4.stage_commit,
  T4.stage_closedwon,
  T4.stage_closedlost
FROM
  T4
