WITH
tmp1
AS
(
SELECT
PG.channel, --Channel名（資料ダウンロードフォーム）
PG.name, --資料名
CAST(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', PG.created_datetime, 'Asia/Tokyo') AS DATETIME) AS created_datetime, --フォーム作成日
AC.*
FROM
  `dejimapro.datawarehouse.Programs` AS PG
LEFT JOIN
  `dejimapro.datawarehouse.Activities_ChangeStatusinProgression` AS AC
ON
  CAST(AC.program_id AS STRING) = CAST(PG.id AS STRING)
WHERE
  PG.channel IN ('資料ダウンロードフォーム')
)

SELECT
  channel AS channel,
  name AS name, --資料名
  CAST(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS DATETIME) AS activity_datetime,
  lead_id, --メンバー総数
  if(success IS true,lead_id,NULL) AS success_id, --成功数（率はLS側で集計）
  if(new_status = 'MQL',lead_id,NULL) AS mql_id, --MQL数
  if(new_status = 'セミナー申込み',lead_id,NULL) AS seminar_id --セミナー数
FROM
  tmp1
WHERE
  CAST(lead_id AS STRING) IS NOT NULL
