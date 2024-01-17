CREATE OR REPLACE FUNCTION `#Project-id#.#Datamart#.phase_label`(lead_source STRING) RETURNS STRING AS (
(
    SELECT
      CASE
        WHEN lead_source IN ('MCL') THEN '1.リード獲得'
        WHEN lead_source IN ('MEL') THEN '2.セミナー参加'
        WHEN lead_source IN ('MQL') THEN '3.有望リード'
        WHEN lead_source IN ('SAL') THEN '4.商談精査'
        WHEN lead_source IN ('SQL') THEN '5.商談化'
        WHEN lead_source IN ('受注件数') THEN '6.受注件数'
        WHEN lead_source IN ('受注金額') THEN '7.受注金額'
      END
  )
);