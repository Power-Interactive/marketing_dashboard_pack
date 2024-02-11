WITH
tmp1
AS
(
SELECT
PG.channel, --Channel名（セミナー）
PG.name, --資料名
CAST(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', PG.created_datetime, 'Asia/Tokyo') AS DATETIME) AS created_datetime, --セミナー作成日
AC.*
FROM
  `dejimapro.datawarehouse.Programs` AS PG
LEFT JOIN
  `dejimapro.datawarehouse.Activities_ChangeStatusinProgression` AS AC
ON
  CAST(AC.program_id AS STRING) = CAST(PG.Id AS STRING)
WHERE
  PG.channel IN ('セミナー')
)

SELECT
  channel AS channel,
  name AS name, --資料名
  CAST(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS DATETIME) AS activity_datetime,
  lead_id, --メンバー総数
  if(Success IS true,lead_id,NULL) AS success_id, --成功数（率はLS側で集計）
  if(new_status = '申込',lead_id,NULL) AS request_id, --申込数
  if(new_status = '欠席',lead_id,NULL) AS absence_id, --欠席数
  if(new_status = '出席',lead_id,NULL) AS attendance_id, --出席数
  if(new_status = 'アンケート回答',lead_id,NULL) AS question_id, --アンケート回答
  if(new_status = 'スライドDL',lead_id,NULL) AS slidedl_id, --スライドDL
FROM
  tmp1
WHERE
  CAST(lead_id AS STRING) IS NOT NULL
