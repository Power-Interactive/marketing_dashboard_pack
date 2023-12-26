--W_Leads_Snapdate の更新が必要
WITH LatestActivity AS (
    SELECT 
        L.snapshot_date,
        L.id,
        L.created_datetime,
        datamart.lead_source(L.lead_source) AS lead_source,
        L.lifecycle_status AS original_lifecycle_status,
        AC.new_value,
        ROW_NUMBER() OVER(PARTITION BY L.id, L.snapshot_date ORDER BY AC.activity_datetime DESC) AS row_num
    FROM
        `pi-dev-dashboard.datamart.W_Leads_Snapdate` AS L
    LEFT JOIN
        `pi-dev-dashboard.datamart.V_Lead_ChangeDataValue` AS AC
    ON
        L.id = AC.lead_id
        AND
        CAST(SUBSTR(AC.activity_datetime, 1, 10) AS DATE) <= L.snapshot_date
    WHERE
        L.snapshot_date >= DATE(L.created_datetime, "Asia/Tokyo")
        
)

SELECT
    snapshot_date,
    id,
    created_datetime,
    lead_source,   
    COALESCE(new_value, original_lifecycle_status) AS lifecycle_status,
    CONCAT(EXTRACT(YEAR FROM  DATE (snapshot_date)),"年",EXTRACT(month FROM  DATE (snapshot_date)),"月") year_month,
FROM
    LatestActivity
WHERE
    row_num = 1 OR row_num IS NULL
ORDER BY
    id,
    snapshot_date DESC;
