#!/usr/bin/python3

import subprocess
import sys
import re
import os
import datetime
from zoneinfo import ZoneInfo

dt_NOW = datetime.datetime.now(ZoneInfo("Asia/Tokyo"))




baseCmd = "python3 run_dashboard.py start=1 count=1 > logs/RD_{:%Y%m%d-%H%M%S}.log 2> logs/RD_{:%Y%m%d-%H%M%S}.err"

executeCmd = baseCmd.format(dt_NOW, dt_NOW)



result = subprocess.run(executeCmd, shell=True)


baseCmd = "cp sample/{} /opt/sync/tmp/sample/{}"
list_FN = ["Activities_ChangeDataValue_New.csv",
           "Activities_ChangeDataValue.csv",
           "Activities_ClickEmail_New.csv",
           "Activities_ClickEmail.csv",
           "Activities_ClickLink_New.csv",
           "Activities_ClickLink.csv",
           "Activities_FillOutForm_New.csv",
           "Activities_FillOutForm.csv",
           "Activities_OpenEmail_New.csv",
           "Activities_OpenEmail.csv",
           "Activities_VisitWebpage_New.csv",
           "Activities_VisitWebpage.csv",
           "Leads.csv",
           "Opportunity.csv",
           "OpportunityHistory.csv",
           "OpportunityHistory_New.csv"]

for fn in list_FN:
    executeCmd = baseCmd.format(fn, fn)
    result = subprocess.run(executeCmd, shell=True)


