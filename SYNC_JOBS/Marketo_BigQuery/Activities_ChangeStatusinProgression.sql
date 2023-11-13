CACHE [Activities_ChangeStatusinProgression] SELECT [ActivityId], [ActivityDate], [LeadId], [NewStatus], [OldStatus], [ProgramID], [ProgramIDValue], [ProgramMemberID], [Reason], [StatusReason], [Success] FROM [Activities_ChangeStatusinProgression] WHERE [ActivityDate] >= CONCAT(SUBSTRING(DATEADD('d', -1, CURRENT_DATE()), 0, 10), ' 15:00:00') AND [ActivityDate] < CONCAT(SUBSTRING(CURRENT_DATE(), 0, 10), ' 15:00:00')
