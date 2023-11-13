CREATE TABLE							
	dl_sfa.Opportunity						
(							
	Id						STRING,
	SystemModStamp			TIMESTAMP,		
	AccountId				STRING,		
	Amount					NUMERIC,					
	CloseDate				DATE,			
	CreatedDate				TIMESTAMP,			
	LastModifiedDate		TIMESTAMP,	
	FiscalYear				INT64,	
	OpportunitySource		STRING,		
	Detailded_Opp_Source	STRING,	
	Name					STRING,		
	OwnerId					STRING,	
	Stage					STRING,		
	Type					STRING,		
	Probability				STRING,			
	License					STRING,			
	LastAmount				NUMERIC,		
	ChannelType				STRING,		
	Distributor				STRING,	
	EndDate					DATE,			
	Contact_Status			STRING,	
	Loss_Reason				STRING,			
	Opp_ClosedDate			DATE,				
	ContctId				STRING		
)
