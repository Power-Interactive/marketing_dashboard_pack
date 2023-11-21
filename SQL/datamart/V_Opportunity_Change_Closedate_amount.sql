SELECT
  OP.id AS opportunity_id, --商談ID
  OP.Name AS opportunity_name, --商談名
  OP.ForecastCategory AS forecast_category, --フェーズ
  OP.CreatedDate AS created_date, --商談作成日
  OP.OwnerId AS owner_id, --所有者ID
  US.Name AS owner_name --所有者名
FROM
  `pi-marketingdataplatform.Salesforce.Opportunity` AS OP
LEFT JOIN
  `pi-marketingdataplatform.Salesforce.User` AS US
ON
  OP.OwnerId = US.Id
;

SELECT distinct
  id, --商談変更ID（固有ID）
  OpportunityId, --商談ID（商談固有のID）
  SystemModstamp, --商談変更日
  CloseDate, --完了予定日
  Amount, --金額
FROM
  `pi-marketingdataplatform.Salesforce.OpportunityHistory`
WHERE
  OpportunityId = '0060I00000gXbJlQAK'
