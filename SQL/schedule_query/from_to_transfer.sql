--Activities_ChangeDataValue
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ChangeDataValue`
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

--Activities_ChangeProgramMemberData
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ChangeProgramMemberData`
SELECT
  ActivityId,
  ActivityDate,
  AttributeDisplayName,
  AttributeName,
  CampaignId,
  LeadId,
  NewValue,
  ProgramID,
  ProgramIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_ChangeProgramMemberData`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Activities_ChangeScore
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ChangeScore`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  ChangeValue,
  LeadId,
  NewValue,
  OldValue,
  Reason,
  ScoreName,
  ScoreNameValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_ChangeScore`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ChangeSegment
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ChangeSegment`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  LeadId,
  ListId,
  NewSegmentID,
  SegmentationID,
  SegmentationIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_ChangeSegment`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Activities_ChangeStatusinProgression
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ChangeStatusinProgression`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  NewStatus,
  OldStatus,
  ProgramID,
  ProgramIDValue,
  ProgramMemberID	,
  Reason,
  StatusReason
FROM
  `pi-marketingdataplatform.Marketo.Activities_ChangeStatusinProgression`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ClickEmail
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ClickEmail`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  LeadId,
  Link,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_ClickEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ClickLink
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_ClickLink`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  ClientIPAddress,
  LeadId,
  LinkID,
  LinkIDValue,
  ListId,
  QueryParameters,
  ReferrerURL
FROM
  `pi-marketingdataplatform.Marketo.Activities_ClickLink`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Activities_EmailDelivered
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_EmailDelivered`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_EmailDelivered`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;



--Activities_FillOutForm
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_FillOutForm`
SELECT
  ActivityId,
  LeadId,
  ActivityDate,
  CampaignId,
  WebformID,
  WebformIDValue,
  WebpageID,
  ListId
FROM
  `pi-marketingdataplatform.Marketo.Activities_FillOutForm`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;



--Activities_NewLead
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_NewLead`
SELECT
  ActivityId,
  LeadId,
  ActivityDate,
  CampaignId,
  CreatedDate,
  FormName,
  LeadSource,
  ListName,
  SFDCType,
  SourceType,
  APIMethodName,
  ModifyingUser,
  RequestId,
  ListId
FROM
  `pi-marketingdataplatform.Marketo.Activities_NewLead`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_OpenEmail
INSERT INTO
  `pi-porting-dashboard.dl_ma.Activities_OpenEmail`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
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
  `pi-porting-dashboard.dl_ma.Activities_SendEmail`
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
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
  `pi-porting-dashboard.dl_ma.Activities_VisitWebpage`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  UserAgent,
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
  `pi-porting-dashboard.dl_ma.Leads`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Marketo.Leads`
;


--Programs
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Programs`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Marketo.Programs`
;

--Segmentations
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Segmentations`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Marketo.Segmentations`
;

--SmartCampaigns
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.SmartCampaigns`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Marketo.SmartCampaigns`
;


/* ==================================================================== */

--Account
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.Account`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Account`
;

--Campaign
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.Campaign`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Campaign`
;


--CampaignMember
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.CampaignMember`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.CampaignMember`
;

--CampaignMemberStatus
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.CampaignMemberStatus`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.CampaignMemberStatus`
;


--Contact
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.Contact`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Contact`
;

--Lead
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.Lead`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Lead`
;

--Opportunity
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.Opportunity`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Opportunity`
;

--OpportunityContactRole
INSERT INTO
  `pi-porting-dashboard.dl_sfa.OpportunityContactRole`
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.OpportunityContactRole`
WHERE
  CAST(SystemModstamp AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--OpportunityHistory
INSERT INTO
  `pi-porting-dashboard.dl_sfa.OpportunityHistory`
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.OpportunityHistory`
WHERE
  CAST(SystemModstamp AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Task
INSERT INTO
  `pi-porting-dashboard.dl_sfa.Task`
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Task`
WHERE
  CAST(SystemModstamp AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--User
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.User`
AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.User`
;
