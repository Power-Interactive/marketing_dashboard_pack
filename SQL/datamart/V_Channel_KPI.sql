SELECT
  Month AS month,
  Month AS date,
  CONCAT(EXTRACT(YEAR FROM  DATE (Month)),"年",EXTRACT(month FROM  DATE (Month)),"月") year_month,
  datamart.fiscal_year(Month) AS fiscal_year, --永続関数を参照
  Channel AS lead_source,
  AfterStatus AS after_status,
  KPI AS kpi
FROM
  `pi-dev-dashboard.master.ChannelKPI`
