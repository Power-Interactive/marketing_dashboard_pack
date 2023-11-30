SELECT 
  L.id AS id,
  L.sfa_accountid AS sfa_accountid,
  datamart.lifecycle_status(L.lifecycle_status) AS lifecycle_status, --永続関数を参照
  A.industry AS industry,
  A.state AS state,
  A.rank AS rank
FROM
  `pi-dev-dashboard.datawarehouse.Leads`  L 
LEFT JOIN
  `pi-dev-dashboard.datawarehouse.Account` A 
ON
  L.sfa_accountid = A.id
