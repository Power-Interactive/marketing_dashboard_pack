WITH
tmp
AS
(
SELECT
    opportunity_id,
    forecast_phase,
    min(system_modified_datetime) AS system_modified_datetime --ForcastCategory以外の更新を考慮
FROM
    `pi-dashboard-398109.datawarehouse.OpportunityHistory`
WHERE
    forecast_phase IS NOT NULL
GROUP BY
    1,2
),

OrderedHistory
AS
(
SELECT
    opportunity_id,
    forecast_phase,
    system_modified_datetime,
    LAG(forecast_phase, 1) OVER (PARTITION BY opportunity_id ORDER BY system_modified_datetime) AS old_value,
    LAG(system_modified_datetime, 1) OVER (PARTITION BY opportunity_id ORDER BY system_modified_datetime) AS old_value_date
FROM tmp
)
SELECT
    opportunity_id,
    system_modified_datetime,
    forecast_phase,
    forecast_phase AS new_value,
    system_modified_datetime AS new_value_date,
    old_value,
    old_value_date,
    TIMESTAMP_DIFF(system_modified_datetime,old_value_date,DAY) AS diff_days
FROM OrderedHistory
WHERE forecast_phase <> old_value OR old_value IS NULL
ORDER BY opportunity_id, system_modified_datetime;
