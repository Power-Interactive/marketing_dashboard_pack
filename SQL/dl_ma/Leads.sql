CREATE TABLE
	dl_ma.Leads
(
	Id						STRING,
	CreatedAt				TIMESTAMP,
	LeadSource				STRING,
	Detailded_Lead_Source	STRING,
	LifecycleStatus			STRING,
	Company					STRING,
	Office					STRING,
	Department				STRING,
	Title					STRING,
	Title_Class				STRING,
	Name					STRING,
	First_Name				STRING,
	Last_Name				STRING,
	Sfa_AccountId			STRING,
	Sfa_ContactId			STRING,
	Sfa_LeadId				STRING,
	Sfa_Type				STRING,
	Rank					STRING,
	Mail_Address			STRING,
	Score					NUMERIC,
	BehaviorScore			NUMERIC,
	DemographicScore		NUMERIC,
	UpdatedAt				TIMESTAMP
)
