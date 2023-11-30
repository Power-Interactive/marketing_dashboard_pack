WITH
T1
AS
(
SELECT
  DATE_TRUNC(t1.close_date, MONTH) month
 ,datamart.forecast_category(t1.forecast_phase) AS forecast_category --永続関数を参照
 ,datamart.stage_label(t1.forecast_phase) AS stage_label --永続関数を参照
 ,t2.department
 ,t2.office
 ,CONCAT(t2.last_name,t2.first_name) AS user
 ,SUM(t1.amount) amount
FROM `pi-dev-dashboard.datawarehouse.Opportunity`  t1
LEFT JOIN `pi-dev-dashboard.datawarehouse.User` t2
 ON t1.owner_id = t2.Id
GROUP BY 
  1,2,3,4,5,6
),

T1_tmp
AS
(
SELECT
  month,
  department,
  office,
  user,
  ifnull(sum(Amount),0) AS amount
FROM
  T1
GROUP BY
  1,2,3,4
),

T2
AS
(
SELECT
  S1.Month AS month,
  '4.過不足' stage_label,
  S1.Office AS office,
  S1.Department AS department,
  S1.User AS user,
  ifnull(sum(S1.SalesTarget),0)-ifnull(sum(T1.Amount),0) AS amount,
FROM
  `pi-dev-dashboard.master.SalesTarget_User` AS S1
LEFT JOIN
  T1_tmp AS T1
ON
  S1.Month = T1.month
  AND S1.Office = T1.office
  AND S1.Department = T1.department
  AND S1.User = T1.user
GROUP BY
  1,2,3,4,5
)


SELECT
  month,
  datamart.fiscal_year(month) AS fiscal_year, --永続関数を参照
  CONCAT(EXTRACT(YEAR FROM  DATE (month)),"年",EXTRACT(month FROM  DATE (month)),"月") year_month,
  forecast_category,
  stage_label,
  office,
  department,
  user,
  ifnull(amount,0) AS amount
FROM
  T1

UNION ALL

SELECT
  month,
  datamart.fiscal_year(month) AS fiscal_year, --永続関数を参照
  CONCAT(EXTRACT(YEAR FROM  DATE (Month)),"年",EXTRACT(month FROM  DATE (Month)),"月") year_month,
  null forecast_category,
  stage_label,
  office,
  department,
  user,
  ifnull(amount,0) amount
FROM
  T2
