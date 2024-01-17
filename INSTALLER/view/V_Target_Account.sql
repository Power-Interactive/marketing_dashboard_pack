SELECT 
L.id
,L.sfa_accountid 
,#Datamart#.lifecycle_status(L.lifecycle_status) AS lifecycle_status --永続関数を参照
,A.industry
,A.state
,A.rank
FROM `#Project-id#.#data-Ware-house#.Leads`  L 
LEFT JOIN `#Project-id#.#data-Ware-house#.Account` A 
ON L.sfa_accountid  = A.id