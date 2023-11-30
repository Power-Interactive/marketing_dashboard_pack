SELECT
  A.Id account_id,
  A.Name account,
  A.rank,
  O.fiscal_year AS fiscal_year,
  SUM(O.amount) amount
FROM
  (
    SELECT * 
    FROM `pi-dev-dashboard.datawarehouse.Account` 
  ) A
LEFT JOIN
  (
    SELECT * 
    FROM `pi-dev-dashboard.datawarehouse.Opportunity`
  ) O
ON
  A.Id = O.account_id
GROUP BY 1,2,3,4
