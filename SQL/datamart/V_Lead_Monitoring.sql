WITH
--新規リードの件数
L 
AS 
(SELECT 
    FORMAT_DATE("%F", date_trunc(created_datetime,Month) ) month
    ,COUNT(distinct id) cnt
FROM `pi-dashboard-398109.datawarehouse.Leads` 
GROUP BY FORMAT_DATE("%F", date_trunc(created_datetime,Month) )
),

--商談作成の件数
OPP
AS
(
SELECT 
    FORMAT_DATE("%F", date_trunc(created_datetime,Month) ) month
    ,COUNT(distinct id)  cnt
FROM `pi-dashboard-398109.datawarehouse.Opportunity` --SFA.OppotunitySnapshot_*から変更
GROUP BY FORMAT_DATE("%F", date_trunc(created_datetime,Month) )
),


OPP_LOST_WON
AS (
    SELECT month,closedwon,closedlost
    FROM (
        SELECT 
        FORMAT_DATE("%F", date_trunc(created_datetime,Month) ) Month
        ,CASE forecast_phase
                WHEN 'Closed' THEN 'ClosedWon'
                WHEN 'Won' THEN 'ClosedWon' --サンプルデータ修正用
                WHEN 'Omitted' THEN 'ClosedLost'
                WHEN 'Lost' THEN 'ClosedLost' --サンプルデータ修正用
                ELSE '-'
            END AS stage_name
        ,count(distinct id) cnt_order
        FROM  `pi-dashboard-398109.datawarehouse.Opportunity`  t2   --SFA.OppotunitySnapshot_*から変更
        WHERE forecast_phase in ('Closed','Omitted','Won','Lost') --Closed:受注, Omitted:ロスト
        GROUP BY FORMAT_DATE("%F", date_trunc(created_datetime,Month) ),stage_name
    )
    PIVOT(
        SUM(Cnt_Order)
        FOR stage_name in ('ClosedWon','ClosedLost')
    )

)
SELECT  
    CAST(cal.month AS date) month
    ,datamart.fiscal_year(cal.month) AS fiscal_year --永続関数を参照
    ,L.cnt new_lead
    ,OPP.cnt new_opportunity
    ,OPP_LOST_WON.closedwon
    ,OPP_LOST_WON.closedlost
FROM `pi-dashboard-398109.dl_master.Calender_Master` cal
LEFT JOIN L ON L.month = CAST(cal.month AS string)
LEFT JOIN OPP ON OPP.month = CAST(cal.month AS string)
LEFT JOIN OPP_LOST_WON ON OPP_LOST_WON.month = CAST(cal.month AS string)
