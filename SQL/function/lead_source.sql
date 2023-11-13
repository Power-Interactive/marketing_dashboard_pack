CREATE OR REPLACE FUNCTION `pi-dashboard-398109.datamart.lead_source`(lead_source STRING) RETURNS STRING AS (
(
    SELECT
      CASE
        WHEN lead_source IN ('セミナー') THEN '1.セミナー'
        WHEN lead_source IN ('Web問い合わせ') THEN '2.Web問い合わせ'
        WHEN lead_source IN ('メディア') THEN '3.メディア'
        WHEN lead_source IN ('資料DL') THEN '4.資料DL'
        WHEN lead_source IN ('その他（広告, 紹介, etc.）') THEN '5.その他（広告, 紹介, etc.）'
        --ELSE '5.Other'
  END lead_source,
  )
);
