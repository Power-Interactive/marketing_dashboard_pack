WITH ACT AS (
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id
        ,'Visit Webpage' category 
        ,webpage_id_value activity_name
    FROM `#Project-id#.#data-Ware-house#.Activities_VisitWebpage`
    UNION ALL 
    SELECT
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id
        ,'Open Email' category 
        ,mailing_id_value activity_name
    FROM `#Project-id#.#data-Ware-house#.Activities_OpenEmail` 
    UNION ALL 
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id
        ,'Click Email' category 
        ,link activity_name
    FROM `#Project-id#.#data-Ware-house#.Activities_ClickEmail` 
    UNION ALL 
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id
        ,'Click Link' category 
        ,link_id_value activity_name
    FROM `#Project-id#.#data-Ware-house#.Activities_ClickLink` 
    UNION ALL 
    SELECT 
        FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_datetime
        ,lead_id
        ,'Fill Out Form' category 
        ,webform_id_value activity_name
    FROM `#Project-id#.#data-Ware-house#.Activities_FillOutForm` 

),
LC AS (
    SELECT
    L.sfa_contactid
    ,L.id
    ,C.last_name
    ,C.first_name
    ,C.department
    ,C.title
    ,C.account
    ,C.industry
    ,C.state
    ,C.amount
    ,L.number_of_employee
    ,C.rank
    FROM `#Project-id#.#data-Ware-house#.Leads` L 
    LEFT JOIN (
        SELECT
            T1.id,
            T1.last_name,
            T1.first_name,
            T1.department,
            T1.title,
            T2.name AS account,
            T2.industry,
            T2.state,
            T2.amount,
            T2.rank
        FROM `#Project-id#.#data-Ware-house#.Contact`  AS T1
        LEFT JOIN
            `#Project-id#.#data-Ware-house#.Account` AS T2
        ON
            T1.id = T2.id
    ) C
    ON L.sfa_contactid = C.id
)
SELECT
 *
FROM ACT act  
LEFT JOIN LC lc 
    ON ACT.lead_id = LC.id
WHERE
    Concat(lc.last_name,lc.first_name) IS NOT NULL

