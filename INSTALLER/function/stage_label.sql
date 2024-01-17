CREATE OR REPLACE FUNCTION `#Project-id#.#Datamart#.stage_label`(ForecastCategory STRING) RETURNS STRING AS (
(
    SELECT
      CASE
        WHEN ForecastCategory = "Won" THEN '1.実績'
        WHEN ForecastCategory = "Closed" THEN '1.実績'
        WHEN ForecastCategory = "Commit" THEN '2.確実'
        WHEN ForecastCategory = "Forecast" THEN '2.確実'
        WHEN ForecastCategory = "Best Case" THEN '3.見込'
        WHEN ForecastCategory = "BestCase" THEN '3.見込'
        WHEN ForecastCategory = "Pipeline" THEN '3.見込'
        WHEN ForecastCategory = "Pileline" THEN '3.見込'
        WHEN ForecastCategory = "Upside" THEN '3.見込'
        ELSE 'その他'
      END
  )
);