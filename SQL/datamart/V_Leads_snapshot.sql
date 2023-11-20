WITH LatestActivity AS (
    SELECT 
        L.snapshot_date,
        L.customer_id,
        L.createdAt,
        L.LeadSource1 AS LeadSource1,
        L.lifecycle_status AS OriginalLifecycleStatus,
        AC.NewValue,
        ROW_NUMBER() OVER(PARTITION BY L.customer_id, L.snapshot_date ORDER BY AC.ActivityDate DESC) AS row_num
    FROM
        `pi-dev-dashboard.dev_.Leads_snapdate` AS L
    LEFT JOIN
        `pi-dev-dashboard.sample_ma.Activities_ChangeDataValue` AS AC ON L.customer_id = AC.LeadId AND DATE(AC.ActivityDate, "Asia/Tokyo") <= L.snapshot_date
    WHERE
        L.snapshot_date >= L.createdAt
)

SELECT
    snapshot_date,
    customer_id,
    createdAt,
    LeadSource1,   
    COALESCE(NewValue, OriginalLifecycleStatus) AS lifecycle_status
FROM
    LatestActivity
WHERE
    row_num = 1 OR row_num IS NULL
ORDER BY
    customer_id,
    snapshot_date DESC;
