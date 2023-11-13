WITH
T1
AS
(
SELECT
  DATE_TRUNC(t1.close_date, MONTH) month
 ,t1.contact_status
 ,datamart.ForecastCategory(t1.forecast_phase) AS forecast_phase --永続関数を参照
 ,datamart.stage_label(t1.forecast_phase) AS stage_label --永続関数を参照
 ,t2.department
 ,t2.office
 ,CONCAT(t2.last_name,t2.first_name) user
 ,SUM(t1.amount) amount
FROM `pi-dashboard-398109.datawarehouse.Opportunity`  t1
LEFT JOIN `pi-dashboard-398109.datawarehouse.User` t2
 ON t1.owner_id = t2.Id
GROUP BY 
  DATE_TRUNC(t1.close_date, MONTH)
 ,t1.contact_status
 ,t1.forecast_phase
 ,t2.department
 ,t2.office
 ,CONCAT(t2.last_name,t2.first_name) 
),

T1_tmp
AS
(
SELECT
  month,
  department,
  office,
  user,
  ifnull(sum(amount),0) AS amount
FROM
  T1
GROUP BY
  month,
  user,
  department,
  office
),

T2
AS
(
SELECT
  S1.month,
  '4.過不足' stage_name,
  '4.過不足' stage_label,
  S1.office,
  S1.department,
  S1.user AS user,
  ifnull(sum(S1.sales_target),0)-ifnull(sum(T1.amount),0) AS amount,
FROM
  `pi-dashboard-398109.datawarehouse.Sales_Target_User_Master` AS S1
LEFT JOIN
  T1_tmp AS T1
ON
  S1.month = T1.month
	AND S1.User = T1.User
  AND S1.office = T1.office
  AND S1.department = T1.department
GROUP BY
  S1.month,
  S1.user,
  S1.office,
  S1.department
)


SELECT
  month,
  datamart.fiscal_year(Month) AS fiscal_year, --永続関数を参照
  CONCAT(EXTRACT(YEAR FROM  DATE (Month)),"年",EXTRACT(month FROM  DATE (Month)),"月") year_month,
  contact_status,
  forecast_phase,
  stage_label,
  office,
  department,
  user,
  ifnull(amount,0) amount
FROM
  T1

UNION ALL

SELECT
  month,
  datamart.fiscal_year(Month) AS fiscal_year, --永続関数を参照
  CONCAT(EXTRACT(YEAR FROM  DATE (Month)),"年",EXTRACT(month FROM  DATE (Month)),"月") year_month,
  stage_name,
  null forecast_phase,
  stage_label,
  office,
  department,
  user,
  ifnull(amount,0) amount
FROM
  T2
