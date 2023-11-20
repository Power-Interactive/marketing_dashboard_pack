--W_Leads_snapdate の更新が必要
WITH LatestActivity AS (
    SELECT 
        L.snapshot_date,
        L.customer_id,
        L.createdAt,
        datamart.lead_source(LeadSource1) AS lead_source,
        L.lifecycle_status AS OriginalLifecycleStatus,
        AC.NewValue,
        ROW_NUMBER() OVER(PARTITION BY L.customer_id, L.snapshot_date ORDER BY AC.ActivityDate DESC) AS row_num
    FROM
        `pi-dev-dashboard.datamart.W_Leads_snapdate` AS L
    LEFT JOIN
        `pi-dev-dashboard.datamart.V_Lead_ChangeDataValue` AS AC ON L.customer_id = AC.LeadId AND CAST(SUBSTR(AC.ActivityDate, 1, 10) AS DATE) <= L.snapshot_date
    WHERE
        L.snapshot_date >= DATE(L.createdAt, "Asia/Tokyo")
        
)

SELECT
    snapshot_date,
    customer_id,
    createdAt AS CreatedAt,
    lead_source,   
    COALESCE(NewValue, OriginalLifecycleStatus) AS lifecycle_status,
    CONCAT(EXTRACT(YEAR FROM  DATE (snapshot_date)),"年",EXTRACT(month FROM  DATE (snapshot_date)),"月") year_month,
FROM
    LatestActivity
WHERE
    row_num = 1 OR row_num IS NULL
ORDER BY
    customer_id,
    snapshot_date DESC;
