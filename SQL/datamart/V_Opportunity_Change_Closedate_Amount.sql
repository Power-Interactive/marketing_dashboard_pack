WITH
--商談情報と所有者情報
UserOpp
AS
(
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
),

--bfの値を付与する処理1
RankedOpportunities AS (
    SELECT
        *,
        LEAD(CloseDate) OVER (PARTITION BY OpportunityId ORDER BY Id) AS NextCloseDate,
        LEAD(Amount) OVER (PARTITION BY OpportunityId ORDER BY Id) AS NextAmount
    FROM
        `pi-marketingdataplatform.Salesforce.OpportunityHistory`
    /* 検証用
    WHERE
        OpportunityId = '0060I00000gXbJlQAK'
    */
),

--bfの値を付与する処理2
Changes
AS
(
SELECT 
    Id,
    OpportunityId,
    SystemModstamp,
    Amount,
    CloseDate
FROM 
    RankedOpportunities
WHERE 
    CloseDate != NextCloseDate OR Amount != NextAmount OR
    (NextCloseDate IS NULL AND NextAmount IS NULL)
ORDER BY
    3 desc
)

--bfの値を付与する処理3
--商談情報と所有者情報を付与
SELECT 
    CH.Id, --商談変更ID
    CH.OpportunityId AS opportunity_id, --商談ID（商談固有のID）
    OU.opportunity_name, --商談名
    OU.forecast_category, --フェーズ
    OU.created_date, --商談作成日
    OU.owner_id, --所有者ID
    OU.owner_name, --所有者名
    CH.SystemModstamp AS system_mod_stamp, --システム変更日（経過日数で利用）
    CH.Amount AS amount, --金額
    CH.CloseDate AS close_date, --完了予定日
    LAG(CH.Amount) OVER (PARTITION BY CH.OpportunityId ORDER BY CH.Id ASC) AS amount_bf, --金額の1つ前のレコード
    LAG(CH.CloseDate) OVER (PARTITION BY CH.OpportunityId ORDER BY CH.Id ASC) AS close_date_bf, --完了予定日の1つ前のレコード
    CASE 
           WHEN ROW_NUMBER() OVER(PARTITION BY CH.OpportunityId ORDER BY CH.Id DESC) = 1 THEN '1'
           ELSE null
       END as new_flg --最新の商談にフラグを付ける
    --経過日数（elapsed_days）は、SystemModstamp-created_dateで計算
FROM 
    Changes AS CH
LEFT JOIN
    UserOpp AS OU
ON
    CH.OpportunityId = OU.opportunity_id
ORDER BY 
    OpportunityId,
    id DESC
