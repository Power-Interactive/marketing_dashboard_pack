CACHE [Task] SELECT CAST([Id] AS STRING) AS [Id],
CAST([SystemModstamp] AS TIMESTAMP) AS [SystemModstamp],
CAST([AccountId] AS STRING) AS [AccountId],
CAST([ActivityDate] AS DATE) AS [ActivityDate],
CAST([CallDisposition] AS STRING) AS [CallDisposition],
CAST([CallDurationInSeconds] AS INTEGER) AS [CallDurationInSeconds],
CAST([CallObject] AS STRING) AS [CallObject],
CAST([CallType] AS STRING) AS [CallType],
CAST([CompletedDateTime] AS TIMESTAMP) AS [CompletedDateTime],
CAST([CreatedById] AS STRING) AS [CreatedById],
CAST([CreatedDate] AS TIMESTAMP) AS [CreatedDate],
CAST([Description] AS STRING) AS [Description],
CAST([IsArchived] AS BOOLEAN) AS [IsArchived],
CAST([IsClosed] AS BOOLEAN) AS [IsClosed],
CAST([IsDeleted] AS BOOLEAN) AS [IsDeleted],
CAST([IsHighPriority] AS BOOLEAN) AS [IsHighPriority],
CAST([IsRecurrence] AS BOOLEAN) AS [IsRecurrence],
CAST([IsReminderSet] AS BOOLEAN) AS [IsReminderSet],
CAST([LastModifiedById] AS STRING) AS [LastModifiedById],
CAST([LastModifiedDate] AS TIMESTAMP) AS [LastModifiedDate],
CAST([MSE_Call_Local_Presence_ID__c] AS STRING) AS [MSE_Call_Local_Presence_ID__c],
CAST([MSE_Call_Recording__c] AS STRING) AS [MSE_Call_Recording__c],
CAST([MSE_Campaign_Details_Link__c] AS STRING) AS [MSE_Campaign_Details_Link__c],
CAST([MSE_Campaign__c] AS STRING) AS [MSE_Campaign__c],
CAST([MSE_Clicked__c] AS BOOLEAN) AS [MSE_Clicked__c],
CAST([MSE_Current_Campaign_Step__c] AS STRING) AS [MSE_Current_Campaign_Step__c],
CAST([MSE_Details__c] AS STRING) AS [MSE_Details__c],
CAST([MSE_Email_Status__c] AS STRING) AS [MSE_Email_Status__c],
CAST([MSE_Presentation_Viewed__c] AS BOOLEAN) AS [MSE_Presentation_Viewed__c],
CAST([MSE_Replied__c] AS BOOLEAN) AS [MSE_Replied__c],
CAST([MSE_Template_Details__c] AS STRING) AS [MSE_Template_Details__c],
CAST([MSE_Template__c] AS STRING) AS [MSE_Template__c],
CAST([MSE_Viewed__c] AS BOOLEAN) AS [MSE_Viewed__c],
CAST([OwnerId] AS STRING) AS [OwnerId],
CAST([Priority] AS STRING) AS [Priority],
CAST([RecurrenceActivityId] AS STRING) AS [RecurrenceActivityId],
CAST([RecurrenceDayOfMonth] AS INTEGER) AS [RecurrenceDayOfMonth],
CAST([RecurrenceDayOfWeekMask] AS INTEGER) AS [RecurrenceDayOfWeekMask],
CAST([RecurrenceEndDateOnly] AS DATE) AS [RecurrenceEndDateOnly],
CAST([RecurrenceInstance] AS STRING) AS [RecurrenceInstance],
CAST([RecurrenceInterval] AS INTEGER) AS [RecurrenceInterval],
CAST([RecurrenceMonthOfYear] AS STRING) AS [RecurrenceMonthOfYear],
CAST([RecurrenceRegeneratedType] AS STRING) AS [RecurrenceRegeneratedType],
CAST([RecurrenceStartDateOnly] AS DATE) AS [RecurrenceStartDateOnly],
CAST([RecurrenceTimeZoneSidKey] AS STRING) AS [RecurrenceTimeZoneSidKey],
CAST([RecurrenceType] AS STRING) AS [RecurrenceType],
CAST([ReminderDateTime] AS TIMESTAMP) AS [ReminderDateTime],
CAST([Status] AS STRING) AS [Status],
CAST([Subject] AS STRING) AS [Subject],
CAST([TaskSubtype] AS STRING) AS [TaskSubtype],
CAST([Type] AS STRING) AS [Type],
CAST([WhatCount] AS INTEGER) AS [WhatCount],
CAST([WhatId] AS STRING) AS [WhatId],
CAST([WhoCount] AS INTEGER) AS [WhoCount],
CAST([WhoId] AS STRING) AS [WhoId] FROM [Task] WHERE [SystemModstamp] >= CONCAT(SUBSTRING(DATEADD('d', -1, CURRENT_DATE()), 0, 10), ' 15:00:00') AND [SystemModstamp] < CONCAT(SUBSTRING(CURRENT_DATE(), 0, 10), ' 15:00:00')
