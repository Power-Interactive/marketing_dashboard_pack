SELECT
  A.Id AS account_id,
  A.Name AS account,
  A.industry AS industry,
  A.type AS type,
  A.amount AS amount,
  A.state,
  A.city,
  A.street,
  A.fiscal_year AS end_of_period,
  A.website,
  A.rank,
  C.department,
  C.title,
  C.last_name AS last_name,
  C.first_name AS first_name,
  C.id AS contactid,
  IFNULL(D.number_of_employee,'不明') AS number_of_employee
FROM
  (SELECT * 
    FROM `pi-dev-dashboard.datawarehouse.Account`
  ) A
LEFT JOIN
    (
    SELECT * 
    FROM `pi-dev-dashboard.datawarehouse.Contact`
  ) C
ON
  A.Id = C.account_id

LEFT JOIN
  (
  SELECT
    sfa_contactid,
    number_of_employee
  FROM
    `pi-dev-dashboard.datawarehouse.Leads`
  ) D
ON
  C.Id = D.sfa_contactid
