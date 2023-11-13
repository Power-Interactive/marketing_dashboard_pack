CREATE TABLE							
	dl_sfa.OpportunityHistory						
(							
	Id					STRING,
	SystemModstamp		TIMESTAMP,
	Amount				NUMERIC,
	CloseDate			DATE,
	CreatedById			STRING,
	CreatedDate			TIMESTAMP,
	ExpectedRevenue		NUMERIC,
	ForecastCategory	STRING,
	IsDeleted			BOOLEAN,
	OpportunityId		STRING,
	Probability			STRING,
	StageName			STRING
)
