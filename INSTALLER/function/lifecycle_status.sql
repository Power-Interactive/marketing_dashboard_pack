CREATE OR REPLACE FUNCTION `#Project-id#.#Datamart#.lifecycle_status`(lifecycle_status STRING) RETURNS STRING AS (
(
    SELECT
      CASE
        WHEN lifecycle_status IN ('MCL') THEN 'MCL'
        WHEN lifecycle_status IN ('MEL','MEL1','MEL2') THEN 'MEL'
        WHEN lifecycle_status IN ('MQL') THEN 'MQL'
        WHEN lifecycle_status IN ('SAL') THEN 'SAL'
        WHEN lifecycle_status IN ('SQL','SQL1','SQL2') THEN 'SQL'
        ELSE lifecycle_status
      END
  )
);