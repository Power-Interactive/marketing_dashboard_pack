WITH
T1
AS
(
SELECT
  DATE_TRUNC(t1.close_date, MONTH) Month
 ,datamart.forecast_category(t1.forecast_phase) AS forecast_category --永続関数を参照
 ,datamart.stage_label(t1.forecast_phase) AS stage_label --永続関数を参照
 ,t1.type
 ,t2.department
 ,t2.office
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
  type,
  department,
  office,
  ifnull(sum(amount),0) AS amount
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
  S1.Type AS type,
  S1.Office AS office,
  S1.Department AS department,
  ifnull(sum(S1.SalesTarget),0)-ifnull(sum(T1_tmp.Amount),0) AS amount,
FROM
 `pi-dev-dashboard.master.SalesTarget_Team_Type` AS S1
LEFT JOIN
  T1_tmp AS T1_tmp
ON
  S1.Month = T1_tmp.Month
  AND S1.Type = T1_tmp.Type
  AND S1.Office = T1_tmp.Office
  AND S1.Department = T1_tmp.Department
GROUP BY
  1,2,3,4,5
)

SELECT
  Month,
  datamart.fiscal_year(month) AS fiscal_year, --永続関数を参照
  CONCAT(EXTRACT(YEAR FROM  DATE (month)),"年",EXTRACT(month FROM  DATE (month)),"月") year_month,
  forecast_category,
  stage_label,
  type,
  office,
  department,
  ifnull(amount,0) amount
FROM
  T1

UNION ALL

SELECT
  month,
  datamart.fiscal_year(Month) AS fiscal_year, --永続関数を参照
  CONCAT(EXTRACT(YEAR FROM  DATE (Month)),"年",EXTRACT(month FROM  DATE (Month)),"月") year_month,
  null forecast_category,
  stage_label,
  type,
  office,
  department,
  ifnull(amount,0) amount
FROM
  T2
