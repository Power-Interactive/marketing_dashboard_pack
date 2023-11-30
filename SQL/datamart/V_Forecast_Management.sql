WITH tmp0 AS (
   SELECT 
      DATE_TRUNC(close_date, MONTH) close_date
   , CAST(SUM(amount) AS NUMERIC) as amount
   FROM `pi-dev-dashboard.datawarehouse.Opportunity`
   GROUP BY DATE_TRUNC(close_date, MONTH) 
   
), 

MT
AS
(
SELECT
   Month,
   sum(SalesTarget) SalesTarget,
   sum(SalesResult) SalesResult
FROM
   `pi-dev-dashboard.master.SalesTarget_Team_Type`
GROUP BY
   Month
),

tmp AS
(
SELECT
   t1.Month AS close_date,
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
   t1.Month = tmp0.close_date
GROUP BY
   t1.Month
),

tmp2 AS (
   SELECT
      tmp1.close_date
      ,tmp1.Amount
      ,tmp2.Amount Amount_1y
      ,tmp1.Amount/tmp2.Amount Amount_yoy
   FROM tmp tmp1
   LEFT JOIN tmp tmp2
   ON DATE_SUB(tmp1.close_Date, INTERVAL 1 year) = tmp2.close_Date
),

tmp3 AS (
   SELECT  
      t1.month as close_date
      ,sum(t1.SalesTarget) as budget
      ,sum(t2.Amount) AS Amount
      ,sum(t2.Amount_1y) AS Amount_1y
      ,sum(t2.Amount_yoy) AS Amount_yoy
   FROM
      MT AS t1
   LEFT JOIN tmp2  t2
      ON t1.month = t2.Close_Date
   where t1.month is not null 
   GROUP BY
      t1.month
   order by t1.month
)

-- UNPIVOT：横持ちを縦持ちに変換
SELECT
 *
 ,CONCAT(EXTRACT(YEAR FROM  DATE (close_date)),"年",EXTRACT(month FROM  DATE (close_date)),"月") year_month,
FROM tmp3
UNPIVOT (
    amount
    FOR class IN (budget,amount,amount_1y,amount_yoy)
)
ORDER BY Close_Date
