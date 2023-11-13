SELECT
  id
  ,created_datetime
  ,lead_source
  ,datamart.lifecycle_status(lifecycle_status) AS lifecycle_status
  ,updated_datetime AS month
FROM
  `pi-dashboard-398109.datawarehouse.Leads`
