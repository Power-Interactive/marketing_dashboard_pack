SELECT
  id
  ,created_datetime
  ,lead_source
  ,#Datamart#.lifecycle_status(lifecycle_status) AS lifecycle_status
  ,updated_datetime AS month
FROM
  `#Project-id#.#data-Ware-house#.Leads`