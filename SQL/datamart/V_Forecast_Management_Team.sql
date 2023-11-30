--実績の集計
WITH tmp0 AS (
   SELECT 
     DATE_TRUNC(t1.close_date, MONTH) month
    ,CAST(SUM(t1.amount) AS NUMERIC) as amount
    ,t2.Department AS department
    ,t2.office AS office
   FROM  `pi-dev-dashboard.datawarehouse.Opportunity` t1
   LEFT JOIN `pi-dev-dashboard.datawarehouse.User` t2
      ON t1.owner_id = t2.id
   GROUP BY DATE_TRUNC(t1.close_date, MONTH) ,t2.department,t2.office
), 


MT
AS
(
SELECT
   Month,
   Office,
   Department,
   sum(SalesTarget) SalesTarget,
   sum(SalesResult) SalesResult
FROM
   `pi-dev-dashboard.master.SalesTarget_Team_Type`
GROUP BY
   Month,
   Office,
   Department
),


--目標値に実績をつける
tmp AS
(
SELECT
   t1.Month AS Month,
   t1.Department AS department,
   t1.Office,
   --MasterのSalesResultを優先
  CASE
    WHEN sum(tmp0.Amount) IS NOT NULL AND sum(t1.SalesResult) IS NOT NULL THEN sum(t1.SalesResult)
    WHEN sum(tmp0.Amount) IS NULL AND sum(t1.SalesResult) IS NOT NULL THEN sum(t1.SalesResult)
    WHEN sum(t1.SalesResult) IS NULL THEN sum(tmp0.Amount)
  END Amount
FROM
   MT AS t1
LEFT JOIN
   tmp0 AS tmp0
ON
   t1.Month = tmp0.Month
   AND
   t1.Department = tmp0.Department
   AND
   t1.Office = tmp0.office
GROUP BY
   t1.Month,
   t1.Department,
   t1.Office
),


tmp2 AS (
   SELECT
       tmp1.Month
      ,tmp1.department
      ,tmp1.Office
      ,tmp1.Amount
      ,tmp2.Amount Amount_1y
   FROM tmp tmp1
   LEFT JOIN tmp tmp2
   ON DATE_SUB(tmp1.Month, INTERVAL 1 year) = tmp2.Month
    AND tmp1.Department = tmp2.Department
    AND tmp1.office = tmp2.office
),

tmp3 AS (
   SELECT  
       t1.Month as month
      ,t1.Department AS department
      ,t1.Office AS office
      ,sum(t1.SalesTarget) as budget
      ,sum(t2.Amount) AS Amount
      ,sum(t2.Amount_1y) AS Amount_1y
      ,sum(t2.Amount)/sum(t2.Amount_1y) AS Amount_yoy
   FROM 
      MT AS t1
   LEFT JOIN tmp2  t2
      ON t1.month = t2.Month
        AND t1.Office = t2.Office
        AND t1.Department = t2.Department
   where t1.month is not null 
   GROUP BY
      t1.month,
      t1.department,
      t1.office
   order by t1.month,t1.department,t1.office
)

--横持に変換
SELECT
 *
FROM tmp3
UNPIVOT (
    amount
    FOR class IN (budget,amount,amount_1y,amount_yoy)
)
ORDER BY Month
