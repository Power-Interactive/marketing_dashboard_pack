#!/usr/bin/python3

import subprocess
import datetime
from zoneinfo import ZoneInfo

list_FN_backup =   ["Activities_ChangeDataValue_New.csv",
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
                    "Leads_SQL.csv",
                    "Opportunity.csv",
                    "OpportunityHistory.csv",
                    "OpportunityHistory_New.csv"]


dt_NOW = datetime.datetime.now(ZoneInfo("Asia/Tokyo"))

baseCmd = "cp sample/_2/{} sample/_3/{}"
for fn in list_FN_backup:
    executeCmd = baseCmd.format(fn, fn)
    result = subprocess.run(executeCmd, shell=True)

baseCmd = "cp sample/_1/{} sample/_2/{}"
for fn in list_FN_backup:
    executeCmd = baseCmd.format(fn, fn)
    result = subprocess.run(executeCmd, shell=True)

baseCmd = "cp sample/{} sample/_1/{}"
for fn in list_FN_backup:
    executeCmd = baseCmd.format(fn, fn)
    result = subprocess.run(executeCmd, shell=True)

result = subprocess.run("cp sample/_2/conf_dashboard.json sample/_3", shell=True)
result = subprocess.run("cp sample/_1/conf_dashboard.json sample/_2", shell=True)
result = subprocess.run("cp conf_dashboard.json sample/_1", shell=True)

baseCmd = "python3 run_dashboard.py start=1 count=1 > logs/RD_{:%Y%m%d-%H%M%S}.log 2> logs/RD_{:%Y%m%d-%H%M%S}.err"

executeCmd = baseCmd.format(dt_NOW, dt_NOW)



result = subprocess.run(executeCmd, shell=True)


baseCmd = "cp sample/{} /opt/sync/tmp/sample/{}"
list_FN_sync = [s for s in list_FN_backup if s != 'Leads_SQL.csv']

for fn in list_FN_sync:
    executeCmd = baseCmd.format(fn, fn)
    result = subprocess.run(executeCmd, shell=True)


