/*
DECLARE START_DATE DATE DEFAULT DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY); -- 昨日の日付
DECLARE END_DATE DATE DEFAULT DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY);   -- 昨日の日付
*/

--スナップショットの事前準備
--Leadsにスナップショット期間の日付をつける
DECLARE START_DATE DATE DEFAULT "2023-04-01";  -- Change to your desired start date
DECLARE END_DATE DATE DEFAULT "2023-10-05";    -- Change to your desired end date

--格納先のテーブルを指定
--既にある場合はINSERTで対応
--INSERT INTO `pi-dev-dashboard.re_datamart.W_Leads_Snapdate`

CREATE OR REPLACE TABLE
  `pi-dev-dashboard.re_datamart.W_Leads_Snapdate`
AS

-- 指定された範囲の一連の日付を生成(Generate a series of dates for the specified range)
WITH
DateRange
AS
(
  SELECT
    id AS id, --リードID
    DATE_ADD(DATE_SUB(START_DATE, INTERVAL 1 DAY), INTERVAL x DAY) AS snapshot_date
  FROM
    `pi-dev-dashboard.datawarehouse.Leads`,
  UNNEST(GENERATE_ARRAY(0, DATE_DIFF(END_DATE, START_DATE, DAY))) AS x
  WHERE
    DATE_ADD(DATE_SUB(START_DATE, INTERVAL 1 DAY), INTERVAL x DAY) BETWEEN START_DATE AND END_DATE
)


--生成した範囲の日付をLeadsに付与
SELECT
    DR.snapshot_date,
    L.id AS customer_id,
    L.created_datetime AS created_datetime,
    L.lead_source AS lead_source,
    L.lifecycle_status AS lifecycle_status
FROM
    DateRange DR
JOIN
    `pi-dev-dashboard.datawarehouse.Leads` L 
ON
  DR.id = L.id
ORDER BY
  L.id, DR.snapshot_date;
