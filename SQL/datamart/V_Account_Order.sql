SELECT
  A.id account_id,
  A.name account,
  A.rank,
  O.fiscal_year,
  SUM(O.amount) amount
FROM
  (
    SELECT * 
    FROM `pi-dashboard-398109.datawarehouse.Account` 
  ) A
LEFT JOIN
  (
    SELECT * 
    FROM `pi-dashboard-398109.datawarehouse.Opportunity` 
  ) O
ON
  A.id = O.account_id
GROUP BY 1,2,3,4
