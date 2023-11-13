--Activities_ChangeDataValue
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_ChangeDataValue`
SELECT
  ActivityId,
  ActivityDate,
  AttributeName,
  AttributeNameValue,
  CampaignId,
  LeadId,
  NewValue,
  OldValue,
  Reason
FROM
  `pi-marketingdataplatform.Marketo.Activities_ChangeDataValue`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ClickEmail
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_ClickEmail`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  MailingID,
  MailingIDValue,
  Link
FROM
  `pi-marketingdataplatform.Marketo.Activities_ClickEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ClickLink
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_ClickLink`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  LinkID,
  LinkIDValue,
  QueryParameters,
  ReferrerURL
FROM
  `pi-marketingdataplatform.Marketo.Activities_ClickLink`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_FillOutForm
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_FillOutForm`
SELECT
  *
FROM
  `pi-marketingdataplatform.Marketo.Activities_FillOutForm`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_OpenEmail
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_OpenEmail`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_OpenEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_SendEmail
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_SendEmail`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_SendEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_VisitWebpage
INSERT INTO
  `pi-dashboard-398109.dl_ma.Activities_VisitWebpage`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  WebpageIDValue,
  WebpageURL
FROM
  `pi-marketingdataplatform.Marketo.Activities_VisitWebpage`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Leads
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.dl_ma.Leads`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Marketo.Leads`
;

--Account
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.dl_sfa.Account`
AS
SELECT
  ID,
  SystemModstamp,
  Name,
  Type,
  Industry,
  BillingCountry AS Country,
  BillingPostalCode AS PostalCode,
  BillingState AS State,
  BillingCity AS City,
  BillingStreet AS Street,
  Website AS Website,
  null Closing_month, --該当データがない
  null Rank, --該当データがない
  null Amount --該当データがない
FROM
  `pi-marketingdataplatform.Salesforce.Account`
;


--Contact
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.dl_sfa.Contact`
AS
SELECT
  id,
  CreatedDate AS createdate,
  AccountId AS accountid,
  email,
  name,
  lastname,
  firstname,
  MailingState,
  MailingStreet,
  MailingCity,
  Department,
  Title,
  CAST(total_score__c AS NUMERIC) AS score,
  LeadSource,
  OwnerId,
  LastCUUpdateDate AS UpdatedAt
FROM
  `pi-marketingdataplatform.Salesforce.Contact`
;

--Opportunity
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.dl_sfa.Opportunity`
AS
SELECT
  Id AS opportunity_id,
  LastModifiedDate,
  AccountId AS account_id,
  Amount AS amount,
  CloseDate,
  CreatedDate,
  FiscalYear,
  FiscalQuarter,
  LeadSource,
  null SourceDetail1,
  null SourceDetail2,
  null SourceDetail3,
  Name,
  OwnerId,
  StageName,
  Type,
  ForecastCategory,
  pi_opp_category__c AS pi_opp_category,
  PI_lostreason__c AS loss_reason,
  PI_lostreasontext__c AS loss_reason_txt,
  ContactId,
  null CommitCategory
FROM
  `pi-marketingdataplatform.Salesforce.Opportunity`
;

--OpportunityHistory
INSERT INTO
  `pi-dashboard-398109.dl_sfa.OpportunityHistory`
SELECT
  Id,
  SystemModstamp,
  Amount,
  CloseDate,
  CreatedById,
  CreatedDate,
  ExpectedRevenue,
  ForecastCategory,
  IsDeleted,
  OpportunityId,
  Probability,
  StageName
FROM
  `pi-marketingdataplatform.Salesforce.OpportunityHistory`
WHERE
  CAST(SystemModstamp AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--User
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.dl_sfa.User`
AS
SELECT
  id,
  username,
  lastname,
  firstname,
  department,
  null office,
  managerid,
  CAST(CreatedDate AS STRING) AS createdad,
  CAST(LastModifiedDate AS STRING) AS updatedad
FROM
  `pi-marketingdataplatform.Salesforce.User`
;
