WITH tmp0 AS (
   SELECT 
      DATE_TRUNC(close_date, MONTH) month
   , CAST(SUM(amount) AS NUMERIC) as amount
    ,department
    ,office
    ,CONCAT(last_name , first_name) name
   FROM `#Project-id#.#data-Ware-house#.Opportunity` t1
   LEFT JOIN `#Project-id#.#data-Ware-house#.User` t2
    ON t1.owner_id = t2.id
   GROUP BY
      DATE_TRUNC(close_date, MONTH) ,
      Department,
      Office,
      CONCAT(last_name , first_name)
), 


MT
AS
(
SELECT
   month,
   department,
   office,
   user,
   sum(sales_target) sales_target,
   sum(sales_result) sales_result
FROM
   `#Project-id#.#data-Ware-house#.Sales_Target_User_Master`
GROUP BY
   month,
   department,
   office,
   user
),

tmp AS
(
SELECT
   t1.month AS month,
   --MasterのSalesResultを優先
  CASE
    WHEN sum(tmp0.amount) IS NOT NULL AND sum(t1.sales_result) IS NOT NULL THEN sum(t1.sales_result)
    WHEN sum(tmp0.amount) IS NULL AND sum(t1.sales_result) IS NOT NULL THEN sum(t1.sales_result)
    WHEN sum(t1.sales_result) IS NULL THEN sum(tmp0.amount)
  END amount,
  t1.department,
  t1.office,
  t1.user AS name
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
   AND
   t1.user = tmp0.name
GROUP BY
   t1.month,
   t1.department,
   t1.office,
   t1.user
),

tmp2 AS (
   SELECT
       tmp1.*
      ,tmp2.amount amount_1y
      ,tmp1.amount/tmp2.amount amount_yoy
   FROM tmp tmp1
   LEFT JOIN tmp tmp2
   ON DATE_SUB(tmp1.month, INTERVAL 1 year) = tmp2.month
    AND tmp1.department = tmp2.department
    AND tmp1.office = tmp2.office
    AND tmp1.name = tmp2.name
),
tmp3 AS (
   SELECT  
       t1.month as month
      ,t1.department AS department
      ,t1.office AS office
      ,t1.user      
      ,sum(t1.sales_target) as budget
      ,sum(t2.amount) AS amount
      ,sum(t2.amount_1y) AS amount_1y
      ,sum(t2.amount_yoy) AS amount_yoy
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