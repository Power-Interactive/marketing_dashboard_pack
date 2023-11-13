SELECT 
L.id
,L.sfa_accountid 
,datamart.lifecycle_status(L.lifecycle_status) AS lifecycle_status --永続関数を参照
,A.industry
,A.state
,A.rank
FROM `pi-dashboard-398109.datawarehouse.Leads`  L 
LEFT JOIN `pi-dashboard-398109.datawarehouse.Account` A 
ON L.sfa_accountid  = A.id
