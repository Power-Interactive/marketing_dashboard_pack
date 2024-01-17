SELECT
  A.id account_id,
  A.name account,
  A.industry,
  A.type,
  A.amount,
  A.state,
  A.city,
  A.street,
  A.end_of_period, --closing_monthから変更
  A.website,
  A.rank,
  C.department,
  C.title,
  C.last_name,
  C.first_name,
  C.id contactid,
  IFNULL(D.number_of_employee,'不明') AS number_of_employee
FROM
  (SELECT * 
    FROM `#Project-id#.#data-Ware-house#.Account`
  ) A
LEFT JOIN
    (
    SELECT * 
    FROM `#Project-id#.#data-Ware-house#.Contact`
  ) C
ON
  A.Id = C.id

LEFT JOIN
  (
  SELECT
    sfa_contactid,
    number_of_employee
  FROM
    `#Project-id#.#data-Ware-house#.Leads`
  ) D
ON
  C.Id = D.sfa_contactid