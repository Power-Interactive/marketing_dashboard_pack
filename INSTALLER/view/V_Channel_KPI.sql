SELECT
  month,
  month AS date,
  CONCAT(EXTRACT(YEAR FROM  DATE (Month)),"年",EXTRACT(month FROM  DATE (Month)),"月") year_month,
  #Datamart#.fiscal_year(Month) AS fiscal_year, --永続関数を参照
  channel AS lead_source,
  AfterStatus as after_status,
  kpi
FROM
  `#Project-id#.#data-Ware-house#.Channel_KPI_Master`