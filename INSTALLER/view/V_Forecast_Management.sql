WITH tmp0 AS (
   SELECT 
      DATE_TRUNC(close_date, MONTH) close_date
   , CAST(SUM(amount) AS NUMERIC) as amount
   FROM `#Project-id#.#data-Ware-house#.Opportunity`
   GROUP BY DATE_TRUNC(close_date, MONTH) 
   
), 

MT
AS
(
SELECT
   month,
   sum(sales_target) sales_target,
   sum(sales_result) sales_result
FROM
   `#Project-id#.#data-Ware-house#.Sales_Target_Team_Master`
GROUP BY
   month
),

tmp AS
(
SELECT
   t1.month AS close_date,
   --MasterのSalesResultを優先
  CASE
    WHEN sum(tmp0.amount) IS NOT NULL AND sum(t1.sales_result) IS NOT NULL THEN sum(t1.sales_result)
    WHEN sum(tmp0.amount) IS NULL AND sum(t1.sales_result) IS NOT NULL THEN sum(t1.sales_result)
    WHEN sum(t1.sales_result) IS NULL THEN sum(tmp0.amount)
  END amount
FROM
   MT AS t1
LEFT JOIN
   tmp0 AS tmp0
ON
   t1.month = tmp0.close_date
GROUP BY
   t1.month
),

tmp2 AS (
   SELECT
      tmp1.close_date
      ,tmp1.amount
      ,tmp2.amount amount_1y
      ,tmp1.amount/tmp2.amount amount_yoy
   FROM tmp tmp1
   LEFT JOIN tmp tmp2
   ON DATE_SUB(tmp1.close_Date, INTERVAL 1 year) = tmp2.close_Date
),

tmp3 AS (
   SELECT  
      t1.month as close_date
      ,sum(t1.sales_target) as budget
      ,sum(t2.amount) AS amount
      ,sum(t2.amount_1y) AS amount_1y
      ,sum(t2.amount_yoy) AS amount_yoy
   FROM
      MT AS t1
   LEFT JOIN tmp2  t2
      ON t1.month = t2.close_date
   where t1.month is not null 
   GROUP BY
      t1.month
   order by t1.month
)

-- UNPIVOT：横持ちを縦持ちに変換
SELECT
 *
 ,CONCAT(EXTRACT(YEAR FROM  DATE (Close_Date)),"年",EXTRACT(month FROM  DATE (Close_Date)),"月") year_month,
FROM tmp3
UNPIVOT (
    amount
    FOR class IN (budget,amount,amount_1y,amount_yoy)
)
ORDER BY close_date