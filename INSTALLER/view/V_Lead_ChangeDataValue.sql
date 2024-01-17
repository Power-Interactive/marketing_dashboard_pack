WITH
Lead
AS
(
SELECT
  id,--リードID
  created_datetime,--リード作成日
  updated_datetime, --リード更新日
  lifecycle_status,--ステージ
  company,--企業名
  concat(last_name , first_name) AS name,--氏名
  lead_source,--リードソース
  detailded_lead_source, --リードソース詳細
  concat("https://powerweb.lightning.force.com/lightning/r/Contact/",sfa_contactid,"/view") AS url --SFDCのURL。クライアントに合わせて修正が必要。
FROM
  `#Project-id#.#data-Ware-house#.Leads`
),

tmp
AS
(
SELECT
  t1.activity_datetime
  ,t1.lead_id
  ,t2.created_datetime
  ,t2.updated_datetime
  ,t2.company
  ,t2.name
  ,t2.lead_source
  ,t2.detailded_lead_source
  ,url

  ,#Datamart#.lifecycle_status(t1.new_value) AS new_value
  ,#Datamart#.lifecycle_status(t1.old_value) AS old_value

  ,LEAD(activity_datetime) OVER (PARTITION BY lead_id ORDER BY activity_datetime desc) as prev_activity_date
FROM
  `#Project-id#.#data-Ware-house#.Activities_ChangeDataValue` AS t1
LEFT JOIN
  Lead AS t2
ON
  t1.lead_id = t2.id
WHERE
  attribute_name_value IN ('Lifecycle Status','Lifecycle Status 2018')
)

SELECT
  FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', activity_datetime, 'Asia/Tokyo') AS activity_date
  ,lead_id
  ,FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', created_datetime, 'Asia/Tokyo') AS created_datetime
  ,FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', updated_datetime, 'Asia/Tokyo') AS updated_datetime
  ,company
  ,name
  ,lead_source
  ,detailded_lead_source
  ,url
  ,new_value
  ,old_value
  ,FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', prev_activity_date, 'Asia/Tokyo') AS prev_activity_date
  ,CONCAT(EXTRACT(YEAR FROM  DATE (activity_datetime)),"年",EXTRACT(month FROM  DATE (activity_datetime)),"月") year_month
  ,TIMESTAMP_diff(activity_datetime, prev_activity_date, DAY) AS diff_days
FROM
  tmp
