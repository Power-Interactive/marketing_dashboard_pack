SELECT
  id
  ,created_datetime
  ,lead_source AS lead_source
  ,datamart.lifecycle_status(lifecycle_status) AS lifecycle_status
  ,updated_datetime AS month
FROM
  `pi-dev-dashboard.datawarehouse.Leads`
