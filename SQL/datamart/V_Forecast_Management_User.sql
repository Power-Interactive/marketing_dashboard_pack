WITH tmp0 AS (
   SELECT
   DATE_TRUNC(t1.close_date, MONTH) month
   ,t2.department AS department
   ,t2.office AS office
   ,CONCAT(t2.last_name , t2.first_name) name
   ,CAST(SUM(t1.amount) AS NUMERIC) as amount
   FROM `pi-dev-dashboard.datawarehouse.Opportunity` t1
   LEFT JOIN `pi-dev-dashboard.datawarehouse.User` t2
    ON t1.owner_id = t2.id
   GROUP BY
      1,2,3,4
), 


MT
AS
(
SELECT
   Month,
   Department,
   Office,
   User,
   sum(SalesTarget) SalesTarget,
   sum(SalesResult) SalesResult
FROM
   `pi-dev-dashboard.master.SalesTarget_User`
GROUP BY
   1,2,3,4
),

tmp AS
(
SELECT
   t1.Month AS Month,
   --MasterのSalesResultを優先
  CASE
    WHEN sum(tmp0.Amount) IS NOT NULL AND sum(t1.SalesResult) IS NOT NULL THEN sum(t1.SalesResult)
    WHEN sum(tmp0.Amount) IS NULL AND sum(t1.SalesResult) IS NOT NULL THEN sum(t1.SalesResult)
    WHEN sum(t1.SalesResult) IS NULL THEN sum(tmp0.Amount)
  END Amount,
  t1.Department AS department,
  t1.Office AS office,
  t1.User AS Name
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
   AND
   t1.User = tmp0.Name
GROUP BY
   t1.Month,
   t1.Department,
   t1.Office,
   t1.User
),

tmp2 AS (
   SELECT
       tmp1.*
      ,tmp2.Amount Amount_1y
      ,tmp1.Amount/tmp2.Amount Amount_yoy
   FROM tmp tmp1
   LEFT JOIN tmp tmp2
   ON DATE_SUB(tmp1.Month, INTERVAL 1 year) = tmp2.Month
    AND tmp1.Department = tmp2.Department
    AND tmp1.Office = tmp2.Office
    AND tmp1.Name = tmp2.Name
),
tmp3 AS (
   SELECT  
       t1.Month as month
      ,t1.Department AS department
      ,t1.Office AS office
      ,t1.user      
      ,sum(t1.SalesTarget) as budget
      ,sum(t2.Amount) AS Amount
      ,sum(t2.Amount_1y) AS Amount_1y
      ,sum(t2.Amount_yoy) AS Amount_yoy
   FROM
      MT AS t1
   LEFT JOIN tmp2  t2
      ON t1.month = t2.Month
        AND t1.Office = t2.Office
        AND t1.Department = t2.Department
        AND t1.User = t2.Name
   where t1.month is not null 
   GROUP BY
      t1.Month,
      t1.Department,
      t1.Office,
      t1.User
   order by Month,Department,Office,User
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
