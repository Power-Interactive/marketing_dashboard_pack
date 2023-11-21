WITH RankedOpportunities AS (
    SELECT 
        *,
        LEAD(CloseDate) OVER (PARTITION BY Id ORDER BY SystemModstamp) AS NextCloseDate,
        LEAD(Amount) OVER (PARTITION BY Id ORDER BY SystemModstamp) AS NextAmount
    FROM 
       `pi-marketingdataplatform.Salesforce.OpportunityHistory`
    WHERE
        OpportunityId = '0060I00000gXbJlQAK'
),

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

SELECT 
    Id,
    OpportunityId,
    SystemModstamp,
    Amount,
    CloseDate,
    LAG(Amount) OVER (PARTITION BY OpportunityId ORDER BY Id ASC) AS Amount_bf,
    LAG(CloseDate) OVER (PARTITION BY OpportunityId ORDER BY Id ASC) AS CloseDate_bf
FROM 
    Changes
ORDER BY 
    OpportunityId,
    id DESC
