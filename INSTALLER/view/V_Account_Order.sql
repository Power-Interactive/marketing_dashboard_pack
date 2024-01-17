SELECT
  A.id account_id,
  A.name account,
  A.rank,
  O.fiscal_year,
  SUM(O.amount) amount
FROM
  (
    SELECT * 
    FROM `#Project-id#.#data-Ware-house#.Account` 
  ) A
LEFT JOIN
  (
    SELECT * 
    FROM `#Project-id#.#data-Ware-house#.Opportunity` 
  ) O
ON
  A.id = O.account_id
GROUP BY 1,2,3,4