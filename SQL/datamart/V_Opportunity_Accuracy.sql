--商談一覧('Pipeline','Best Case','Upside','Commit')
WITH
Opportunity
AS
(
SELECT
  CAST(T1.close_date AS DATE) AS close_date,
  T1.name AS opportunity_name,
  T1.id AS opportunity_id,
  Concat(T2.last_name, T2.first_name) AS User,
  T2.department AS department,
  T2.Office AS office,

  datamart.forecast_category(OH.new_value) AS new_value, --new_value
  datamart.forecast_category(OH.old_value) AS old_value, --old_value

  --T1.probability --受注確度はデータポータルで出す
FROM
  `pi-dev-dashboard.datawarehouse.Opportunity`  AS T1
LEFT JOIN
  `pi-dev-dashboard.re_datamart.V_Opportunity_History` AS OH --商談の変更履歴
ON
  T1.id = OH.opportunity_id
LEFT JOIN
    `pi-dev-dashboard.datawarehouse.User` AS T2
ON
  T1.owner_id = T2.Id
)


SELECT
  *,
  
  CASE WHEN new_value IN ('4.Closed Won','5.Closed Lost') AND old_value IN ("1.Pipeline","2.BestCase","3.Commit") THEN old_value ELSE NULL END stage_name,
  CASE WHEN new_value IN ('4.Closed Won') AND old_value IN ("1.Pipeline","2.BestCase","3.Commit") THEN opportunity_id ELSE NULL END closewon_op_id, --各フェーズから受注に至った件数

  CASE WHEN new_value IN ('4.Closed Won') AND old_value IN ('1.Pipeline') THEN opportunity_id ELSE NULL END p_closewon_op_id, --Pipelineから受注の件数
  CASE WHEN new_value IN ('4.Closed Won') AND old_value IN ('2.BestCase') THEN opportunity_id ELSE NULL END b_closewon_op_id, --Best Caseから受注の件数
  CASE WHEN new_value IN ('4.Closed Won') AND old_value IN ('3.Commit') THEN opportunity_id ELSE NULL END c_closewon_op_id, --Commitから受注の件数 
  
  CASE WHEN new_value IN ('5.Closed Lost') AND old_value IN ('1.Pipeline') THEN opportunity_id ELSE NULL END p_closelost_op_id, --Pipelineから失注の件数
  CASE WHEN new_value IN ('5.Closed Lost') AND old_value IN ('2.BestCase') THEN opportunity_id ELSE NULL END b_closelost_op_id, --Best Caseから失注の件数
  CASE WHEN new_value IN ('5.Closed Lost') AND old_value IN ('3.Commit') THEN opportunity_id ELSE NULL END c_closelost_op_id, --Commitから失注の件数

FROM
  Opportunity
