CREATE OR REPLACE FUNCTION `pi-dev-dashboard.datamart.forecast_category`(ForecastCategory STRING) RETURNS STRING AS (
(
    SELECT
      CASE
        WHEN ForecastCategory = "Lost" THEN '5.Closed Lost'
        WHEN ForecastCategory = "Omitted" THEN '5.Closed Lost'
        WHEN ForecastCategory = "Closed" THEN '4.Closed Won'
        WHEN ForecastCategory = "Won" THEN '4.Closed Won'
        WHEN ForecastCategory = "Closed" THEN '4.Closed Won'
        WHEN ForecastCategory = "Commit" THEN '3.Commit'
        WHEN ForecastCategory = "Forecast" THEN '3.Commit'
        WHEN ForecastCategory = "Best Case" THEN '2.BestCase'
        WHEN ForecastCategory = "BestCase" THEN '2.BestCase'
        WHEN ForecastCategory = "Pipeline" THEN '1.Pipeline'
        WHEN ForecastCategory = "Pileline" THEN '1.Pipeline' --サンプルデータ用
        WHEN ForecastCategory = "Upside" THEN '1.Pipeline' --サンプルデータ用
      ELSE 'その他'
    END
  )
);
