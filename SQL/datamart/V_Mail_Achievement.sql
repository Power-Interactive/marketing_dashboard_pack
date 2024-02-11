WITH
tmp1
AS
(
SELECT
PG.channel, --Channel名（メール）
PG.name, --メール名
CAST(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', PG.created_datetime, 'Asia/Tokyo') AS DATETIME) AS created_datetime, --メール作成日作成日
AC.*
FROM
  `dejimapro.datawarehouse.Programs` AS PG
LEFT JOIN
  `dejimapro.datawarehouse.Activities_ChangeStatusinProgression` AS AC
ON
  CAST(AC.program_id AS STRING) = CAST(PG.id AS STRING)
WHERE
  PG.channel IN ('メール','メールマガジン','ニュースレター')
)

SELECT
  Channel AS channel,
  Name AS name, --資料名
  CAST(FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS DATETIME) AS activity_datetime,
  lead_id, --メンバー総数
  if(success IS true,lead_id,NULL) AS success_id, --成功数（率はLS側で集計）
  if(new_status = '配信',lead_id,NULL) AS delivered_id, --配信数
  if(new_status = '開封',lead_id,NULL) AS open_id, --開封数
  if(new_status = 'クリック',lead_id,NULL) AS click_id, --クリック数
  if(new_status = '資料DL',lead_id,NULL) AS documentdl_id, --資料DL数
  if(new_status LIKE '%CV%',lead_id,NULL) AS cv_id, --CV数
FROM
  tmp1
WHERE
  CAST(lead_id AS STRING) IS NOT NULL
