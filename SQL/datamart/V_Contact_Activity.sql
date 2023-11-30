WITH ACT AS (
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id AS lead_id
        ,'Visit Webpage' category 
        ,webpage_id_value AS activity_name
    FROM `pi-dev-dashboard.datawarehouse.Activities_VisitWebpage`
    UNION ALL 
    SELECT
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id AS lead_id
        ,'Open Email' category 
        ,mailing_id_value AS activity_name
    FROM `pi-dev-dashboard.datawarehouse.Activities_OpenEmail` 
    UNION ALL 
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id AS lead_id
        ,'Click Email' category 
        ,link AS activity_name
    FROM `pi-dev-dashboard.datawarehouse.Activities_ClickEmail` 
    UNION ALL 
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id AS lead_id
        ,'Click Link' category 
        ,link_id_value AS activity_name
    FROM `pi-dev-dashboard.datawarehouse.Activities_ClickLink` 
    UNION ALL 
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id AS lead_id
        ,'Fill Out Form' category 
        ,webform_id_value AS activity_name
    FROM `pi-dev-dashboard.datawarehouse.Activities_FillOutForm` 

),
LC AS (
    SELECT
    L.sfa_contact_id
    ,L.customer_id AS id
    ,C.lastname AS last_name
    ,C.firstname AS first_name
    ,C.department AS department
    ,C.title AS title
    ,C.account AS account
    ,C.industry AS industry
    ,C.State AS state
    ,C.Amount AS amount
    ,L.number_of_employee
    ,C.Rank AS rank
    FROM `pi-dev-dashboard.dl_ma.Leads` L 
    LEFT JOIN (
        SELECT
            T1.id,
            T1.lastname,
            T1.firstname,
            T1.department,
            T1.title,
            T2.name AS account,
            T2.industry,
            T2.State,
            T2.Amount,
            T2.Rank
        FROM `pi-dev-dashboard.dl_sfa.Contact`  AS T1
        LEFT JOIN
            `pi-dev-dashboard.dl_sfa.Account` AS T2
        ON
            T1.accountid = T2.ID
    ) C
    ON L.sfa_contact_id = C.id
)
SELECT
 *
FROM ACT act  
LEFT JOIN LC lc 
    ON ACT.lead_id = LC.id
WHERE
    Concat(lc.last_name,lc.first_name) IS NOT NULL
