/* JST 8:45に実行するように調整 */

--Activities_ChangeDataValue
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_ChangeDataValue`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(AttributeName AS INTEGER) AS attribute_name,
  cast(AttributeNameValue AS STRING) AS attribute_name_value,
  cast(CampaignId AS STRING) AS campaign_id,
  cast(LeadId AS STRING) AS lead_id,
  cast(NewValue AS STRING) AS new_value,
  cast(OldValue AS STRING) AS old_value,
  cast(Reason AS STRING) AS reason
FROM
  `pi-dashboard-398109.dl_ma.Activities_ChangeDataValue`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ClickEmail
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_ClickEmail`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(LeadId AS STRING) AS lead_id,
  cast(MailingID AS STRING) AS mailing_id,
  cast(MailingIDValue AS STRING) AS mailing_id_value,
  cast(Link AS STRING) AS link
FROM
  `pi-dashboard-398109.dl_ma.Activities_ClickEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_ClickLink
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_ClickLink`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(LeadId AS STRING) AS lead_id,
  cast(LinkID AS INTEGER) AS link_id,
  cast(LinkIDValue AS STRING) AS link_id_value,
  cast(QueryParameters AS STRING) AS query_parameters,
  cast(ReferrerURL AS STRING) AS referrer_url
FROM
  `pi-dashboard-398109.dl_ma.Activities_ClickLink`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_FillOutForm
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_FillOutForm`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(LeadId AS STRING) AS lead_id,
  cast(null AS STRING) AS program_name,
  cast(null AS STRING) AS program_type,
  cast(WebpageID AS INTEGER) AS webform_id,
  cast(WebpageID AS STRING) AS webform_id_value
FROM
  `pi-dashboard-398109.dl_ma.Activities_FillOutForm`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_OpenEmail
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_OpenEmail`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(LeadId AS STRING) AS lead_id,
  cast(MailingID AS STRING) AS mailing_id,
  cast(MailingIDValue AS STRING) AS mailing_id_value
FROM
  `pi-dashboard-398109.dl_ma.Activities_OpenEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;


--Activities_SendEmail
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_SendEmail`
SELECT
  ActivityId,
  ActivityDate,
  LeadId,
  MailingID,
  MailingIDValue
FROM
  `pi-dashboard-398109.dl_ma.Activities_SendEmail`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Activities_VisitWebpage
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_VisitWebpage`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(LeadId AS STRING) AS lead_id,
  cast(WebpageIDValue AS STRING) AS webpage_id_value,
  cast(WebpageURL AS STRING) AS webpage_url
FROM
  `pi-dashboard-398109.dl_ma.Activities_VisitWebpage`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Activities_ChangeStatusinProgression
INSERT INTO
  `pi-dashboard-398109.datawarehouse.Activities_ChangeStatusinProgression`
SELECT
  cast(ActivityId AS STRING) AS activity_id,
  cast(ActivityDate AS TIMESTAMP) AS activity_datetime,
  cast(LeadId AS STRING) AS lead_id,
  cast(NewStatus AS STRING) AS new_status,
  cast(OldStatus AS STRING) AS old_status,
  cast(ProgramID AS STRING) AS program_id,
  cast(ProgramMemberID AS STRING) AS program_member_id,
  cast(Success AS BOOLEAN) AS success
FROM
  `pi-dashboard-398109.dl_ma.Activities_ChangeStatusinProgression`
WHERE
  CAST(ActivityDate AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--Leads
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.datawarehouse.Leads`
AS
SELECT
  cast(id AS STRING) AS id,
  cast(CreatedAt AS TIMESTAMP) AS created_datetime,
  cast(LeadSource AS STRING) AS lead_source,
  cast(null AS STRING) AS detailded_lead_source,
  cast(Lifecycle_Status_2018__c AS STRING) AS lifecycle_status,
  cast(Company AS STRING) AS company,
  cast(null AS STRING) AS office,
  cast(department AS STRING) AS department,
  cast(Title AS STRING) AS title,
  cast(Title AS STRING) AS title_class,
  cast(CONCAT(LastName," ",FirstName) AS STRING) AS name,
  cast(FirstName AS STRING) AS first_name,
  cast(LastName AS STRING) AS last_name,
  cast(null AS STRING) AS sfa_accountid,
  cast(SfdcContactId AS STRING) AS sfa_contactid,
  cast(SfdcLeadId AS STRING) AS sfa_leadid,
  cast(SfdcType AS STRING) AS sfa_type,
  cast(null AS STRING) AS rank,
  cast(Email AS STRING) AS mail_address,
  cast(LeadScore AS INTEGER) AS score,
  cast(BehaviorScore AS INTEGER) AS behavior_score,
  cast(DemographicScore AS INTEGER) AS demographic_score,
  cast(null AS INTEGER) AS amount,
  cast(Lbc2_office_id__c AS STRING) AS company_code,
  cast(Lbc2_corporate_number__c AS INTEGER) AS corporate_number,
  cast(null AS INTEGER) AS company_score,
  cast(null AS STRING) AS company_description,
  cast(Lbc2_listed_name__c AS STRING) AS listed_status,
  cast(Lbc2_setup_date__c AS STRING) AS established_date,
  cast(Lbc2_emp_range_ver02_name__c AS STRING) AS number_of_employee,
  cast(null AS INTEGER) AS end_of_period,
  cast(Lbc2_industry_name_l_3__c AS STRING) AS sectors,
  cast(Lbc2_industry_name_m_3__c AS STRING) AS subsectors,
  cast(Lbc2_industry_name_s_3__c AS STRING) AS industries,
  cast(Lbc2_story__c AS STRING) AS scenarios,
  cast(null AS STRING) AS similar_companies,
  cast(null AS STRING) AS customer_status,
  cast(UpdatedAt AS TIMESTAMP) AS updated_datetime
FROM
  `pi-dashboard-398109.dl_ma.Leads`
;

--Programs
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.datawarehouse.Programs`
AS
SELECT
  Id AS id,
  CreatedAt AS created_datetime,
  Channel AS channel,
  Name AS name,
  Type AS type
FROM
  `pi-dashboard-398109.dl_ma.Programs`
;

--Account
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.datawarehouse.Account`
AS
SELECT
  cast(ID AS STRING) AS id,
  cast(null AS TIMESTAMP) AS created_datetime,
  cast(Name AS STRING) AS name,
  cast(null AS STRING) AS office,
  cast(null AS STRING) AS department,
  cast(Type AS STRING) AS type,
  cast(Industry AS STRING) AS industry,
  cast(Country AS STRING) AS country,
  cast(PostalCode AS STRING) AS postal_code,
  cast(State AS STRING) AS state,
  cast(City AS STRING) AS city,
  cast(Street AS STRING) AS street,
  cast(Website AS STRING) AS website,
  cast(Closing_month AS STRING) AS fiscal_year,
  cast(Rank AS STRING) AS rank,
  cast(Amount AS INTEGER) AS amount,
  cast(null AS STRING) AS company_code,
  cast(null AS INTEGER) AS corporate_number,
  cast(null AS INTEGER) AS company_score,
  cast(null AS STRING) AS company_description,
  cast(null AS STRING) AS listed_status,
  cast(null AS DATE) AS established_date,
  cast(null AS INTEGER) AS number_of_employee,
  cast(null AS INTEGER) AS end_of_period,
  cast(null AS STRING) AS sectors,
  cast(null AS STRING) AS subsectors,
  cast(null AS STRING) AS industries,
  cast(null AS STRING) AS scenarios,
  cast(null AS STRING) AS similar_companies,
  cast(null AS STRING) AS customer_status,
  cast(SystemModstamp AS TIMESTAMP) AS updated_datetime
FROM
  `pi-dashboard-398109.dl_sfa.Account`
;


--Contact
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.datawarehouse.Contact`
AS
SELECT
  cast(id AS STRING) AS id,
  cast(createdate AS TIMESTAMP) AS created_datetime,
  cast(accountid AS STRING) AS account_id,
  cast(email AS STRING) AS mail_address,
  cast(name AS STRING) AS name,
  cast(firstname AS STRING) AS first_name,
  cast(lastname AS STRING) AS last_name,
  cast(null AS STRING) AS company,
  cast(null AS STRING) AS office,
  cast(Department AS STRING) AS department,
  cast(Title AS STRING) AS title,
  cast(null AS STRING) AS title_class,
  cast(null AS STRING) AS role,
  cast(LeadSource AS STRING) AS lead_source,
  cast(null AS STRING) AS detailded_lead_source,
  cast(OwnerId AS STRING) AS owner_id,
  cast(null AS STRING) AS manager_id,
  cast(UpdatedAt AS TIMESTAMP) AS updated_datetime
FROM
  `pi-dashboard-398109.dl_sfa.Contact`
;

--Opportunity
/* 全件洗い替えで対応 */
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.datawarehouse.Opportunity`
AS
SELECT
  cast(opportunity_id AS STRING) AS id,
  cast(null AS TIMESTAMP) AS system_modified_datetime,
  cast(account_id AS STRING) AS account_id,
  cast(amount AS NUMERIC) AS amount,
  cast(CloseDate AS DATE) AS close_date,
  cast(CreatedDate AS TIMESTAMP) AS created_datetime,
  cast(LastModifiedDate AS TIMESTAMP) AS last_modified_datetime,
  cast(FiscalYear AS INTEGER) AS fiscal_year,
  cast(LeadSource AS STRING) AS opportunity_source,
  cast(Name AS STRING) AS name,
  cast(OwnerId AS STRING) AS owner_id,
  cast(Type AS STRING) AS type,
  cast(null AS STRING) AS probability,
  cast(null AS STRING) AS license,
  cast(null AS NUMERIC) AS last_amount,
  cast(LeadSource AS STRING) AS channel_type,
  cast(null AS STRING) AS distributor,
  cast(null AS DATE) AS end_date,
  cast(null AS STRING) AS contact_status,
  cast(loss_reason_txt AS STRING) AS loss_reason,
  cast(ContactId AS STRING) AS contct_id,
  cast(ForecastCategory AS STRING) AS forecast_phase,
  cast(SourceDetail1 AS STRING) AS detailded_opportunity_source,
  cast(null AS DATE) AS opportunity_closed_date
FROM
  `pi-dashboard-398109.dl_sfa.Opportunity`
;

--OpportunityHistory
INSERT INTO
  `pi-dashboard-398109.datawarehouse.OpportunityHistory`
SELECT
  cast(Id AS STRING) AS id,
  cast(OpportunityId AS STRING) AS opportunity_id,
  cast(CreatedDate AS TIMESTAMP) AS created_datetime,
  cast(ForecastCategory	 AS STRING) AS forecast_phase,
  cast(StageName AS STRING) AS new_value,
  cast(SystemModstamp AS TIMESTAMP) AS new_value_datetime,
  cast(null AS STRING) AS old_value,
  cast(null AS TIMESTAMP) AS old_value_datetime,
  cast(null AS INTEGER) AS difference_days,
  cast(SystemModstamp AS TIMESTAMP) AS system_modified_datetime,
FROM
  `pi-dashboard-398109.dl_sfa.OpportunityHistory`
WHERE
  CAST(SystemModstamp AS DATE) >= DATE_SUB(CURRENT_DATE('Etc/UTC'), INTERVAL 1 DAY)
;

--User
CREATE OR REPLACE TABLE
  `pi-dashboard-398109.datawarehouse.User`
AS
SELECT
  cast(id AS STRING) AS id,
  cast(CONCAT(lastname," ",firstname) AS STRING) AS name,
  cast(firstname AS STRING) AS first_name,
  cast(lastname AS STRING) AS last_name,
  cast(username AS STRING) AS email_address,
  cast(department AS STRING) AS department,
  cast(office AS STRING) AS office,
  cast(managerid AS STRING) AS manager_id,
  FORMAT_DATE('%Y%m%d', PARSE_DATE('%Y-%m-%d', SUBSTR(createdad, 1, 10))) AS created_date,
  FORMAT_DATE('%Y%m%d', PARSE_DATE('%Y-%m-%d', SUBSTR(updatedad, 1, 10))) AS updated_date
FROM
  `pi-dashboard-398109.dl_sfa.User`
;
