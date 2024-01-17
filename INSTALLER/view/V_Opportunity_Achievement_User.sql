SELECT
  T1.name AS opportunity_name,
  T1.id id,
  T1.owner_id,
  T2.department,
  T2.office,
  concat(T2.last_name, T2.first_name) user,

  #Datamart#.ForecastCategory(T1.forecast_phase) AS stage_name, --永続関数を参照

  T1.created_datetime AS created_date,
  T1.close_date AS close_date,
  T1.last_modified_datetime AS last_modified_datetime,--最終更新日
  CAST(date_diff(T1.last_modified_datetime,T1.created_datetime,DAY) AS NUMERIC) opportunity_days,--商談日数
  T1.amount
FROM
`#Project-id#.#data-Ware-house#.Opportunity`  AS T1
LEFT JOIN
    `#Project-id#.#data-Ware-house#.User` AS T2
ON
  T1.owner_id = T2.id
