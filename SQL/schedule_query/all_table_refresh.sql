--Activities_ChangeDataValue
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ChangeDataValue`
  AS
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
;

--Activities_ChangeProgramMemberData
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ChangeProgramMemberData`
  AS
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
;

--Activities_ChangeScore
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ChangeScore`
  AS
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
;


--Activities_ChangeSegment
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ChangeSegment`
  AS
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
;

--Activities_ChangeStatusinProgression
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ChangeStatusinProgression`
  AS
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
;


--Activities_ClickEmail
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ClickEmail`
  AS
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
;


--Activities_ClickLink
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_ClickLink`
  AS
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
;

--Activities_EmailDelivered
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_EmailDelivered`
  AS
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_EmailDelivered`
;



--Activities_FillOutForm
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_FillOutForm`
  AS
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
;



--Activities_NewLead
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_NewLead`
  AS
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
;


--Activities_OpenEmail
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_OpenEmail`
  AS
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_OpenEmail`
;


--Activities_SendEmail
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_SendEmail`
  AS
SELECT
  ActivityId,
  ActivityDate,
  CampaignId,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-marketingdataplatform.Marketo.Activities_SendEmail`
;


--Activities_VisitWebpage
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_ma.Activities_VisitWebpage`
  AS
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  UserAgent,
  WebpageIDValue,
  WebpageURL
FROM
  `pi-marketingdataplatform.Marketo.Activities_VisitWebpage`
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
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.OpportunityContactRole`
  AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.OpportunityContactRole`
;


--OpportunityHistory
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.OpportunityHistory`
  AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.OpportunityHistory`
;

--Task
CREATE OR REPLACE TABLE
  `pi-porting-dashboard.dl_sfa.Task`
  AS
SELECT
  *
FROM
  `pi-marketingdataplatform.Salesforce.Task`
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
