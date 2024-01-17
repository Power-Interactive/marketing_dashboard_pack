--実績の集計
WITH tmp0 AS (
   SELECT 
     DATE_TRUNC(t1.close_date, MONTH) month
    ,CAST(SUM(t1.amount) AS NUMERIC) as amount
    ,t2.department AS department
    ,t2.office AS office
   FROM  `#Project-id#.#data-Ware-house#.Opportunity` t1
   LEFT JOIN `#Project-id#.#data-Ware-house#.User` t2
      ON t1.owner_id = t2.id
   GROUP BY DATE_TRUNC(t1.close_date, MONTH) ,t2.department,t2.office
), 


MT
AS
(
SELECT
   month,
   office,
   department,
   sum(sales_target) sales_target,
   sum(sales_result) sales_result
FROM
   `#Project-id#.#data-Ware-house#.Sales_Target_Team_Master`
GROUP BY
   month,
   office,
   department
),


--目標値に実績をつける
tmp AS
(
SELECT
   t1.month,
   t1.department,
   t1.office,
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
   t1.month = tmp0.month
   AND
   t1.department = tmp0.department
   AND
   t1.office = tmp0.office
GROUP BY
   t1.month,
   t1.department,
   t1.office
),


tmp2 AS (
   SELECT
       tmp1.month
      ,tmp1.department
      ,tmp1.office
      ,tmp1.amount
      ,tmp2.amount amount_1y
   FROM tmp tmp1
   LEFT JOIN tmp tmp2
   ON DATE_SUB(tmp1.month, INTERVAL 1 year) = tmp2.month
    AND tmp1.department = tmp2.department
    AND tmp1.office = tmp2.office
),

tmp3 AS (
   SELECT  
       t1.month
      ,t1.department
      ,t1.office
      ,sum(t1.sales_target) as budget
      ,sum(t2.amount) AS amount
      ,sum(t2.amount_1y) AS amount_1y
      ,sum(t2.amount)/sum(t2.amount_1y) AS amount_yoy
   FROM 
      MT AS t1
   LEFT JOIN tmp2  t2
      ON t1.month = t2.month
        AND t1.office = t2.office
        AND t1.department = t2.department
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
ORDER BY month
