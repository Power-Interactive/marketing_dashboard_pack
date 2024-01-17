#!/usr/bin/python3

import subprocess
import sys
import re
import os
import datetime

dt_start = datetime.datetime.now()
print("                         ==================== start {:%Y-%m-%d %H:%M:%S} ====================".format(dt_start))

args                = sys.argv
dict_param          = {}


for arg in args:
    print(arg)
    if arg == 'run_dashboard.py':
        continue
    elif re.match(r'start=', arg, re.IGNORECASE):
        elements = re.split('=', arg)
        dict_param['start'] = int(elements[1])
        print(type(dict_param['start']))
    elif re.match(r'count=', arg, re.IGNORECASE):
        elements = re.split('=', arg)
        dict_param['count'] = int(elements[1])
        print(type(dict_param['count']))
    elif re.match(r'end=', arg, re.IGNORECASE):
        elements = re.split('=', arg)
        dict_param['end'] = int(elements[1])
        print(type(dict_param['end']))
    else:
        print("Unknown argument : "+arg, file=sys.stderr)
        sys.exit()

if not 'start' in dict_param:
    print("start parameter not specified", file=sys.stderr)
    sys.exit()
if 'count' in dict_param:
    int_End = dict_param['start'] + dict_param['count']
    if 'end' in dict_param:
        print("'count' and 'end' are  both specified. 'count' will be adopted.")
else:
    if 'end' in dict_param:
        int_End = dict_param['end']
    else:
        print("Please specified 'count' or 'end'"+arg, file=sys.stderr)
        sys.exit()

if dict_param['start'] > int_End:
    print("'start' is larger than 'end'"+arg, file=sys.stderr)
    sys.exit()


baseCom_Lead_New = "python3 Leads_New.py conf=conf_dashboard.json file_New=sample/LN_{:%Y%m%d-%H%M%S}.csv > logs/LN_{:%Y%m%d-%H%M%S}.log 2> logs/LN_{:%Y%m%d-%H%M%S}.err"

baseCom_Lead_Renew = "python3 Leads_Renew.py conf=conf_dashboard.json file_Renew=sample/LR_{:%Y%m%d-%H%M%S}.csv > logs/LR_{:%Y%m%d-%H%M%S}.log 2> logs/LR_{:%Y%m%d-%H%M%S}.err"

baseCom_Opportunity_New = "python3 Opportunity_New.py conf=conf_dashboard.json file_New=sample/ON_{:%Y%m%d-%H%M%S}.csv > logs/ON_{:%Y%m%d-%H%M%S}.log 2> logs/ON_{:%Y%m%d-%H%M%S}.err"

baseCom_Opportunity_Renew = "python3 Opportunity_Renew.py conf=conf_dashboard.json file_Renew=sample/OR_{:%Y%m%d-%H%M%S}.csv > logs/OR_{:%Y%m%d-%H%M%S}.log 2> logs/OR_{:%Y%m%d-%H%M%S}.err"



for ii in range(dict_param['start'], int_End):
    dt_now  = datetime.datetime.now()
    print("                    ==================== {:03} - {:%Y%m%d-%H%M%S} ====================".format(ii, dt_now))
    if os.path.isfile("logs/LN_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        os.remove("logs/LN_{:%Y%m%d-%H%M%S}.err".format(dt_now))
    if os.path.isfile("logs/LR_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        os.remove("logs/LR_{:%Y%m%d-%H%M%S}.err".format(dt_now))
    if os.path.isfile("logs/ON_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        os.remove("logs/ON_{:%Y%m%d-%H%M%S}.err".format(dt_now))
    if os.path.isfile("logs/OR_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        os.remove("logs/OR_{:%Y%m%d-%H%M%S}.err".format(dt_now))
    executeCmd = baseCom_Lead_New.format(dt_now, dt_now, dt_now)
    print("1) " + executeCmd)
    result = subprocess.run(executeCmd, shell=True)
    if os.path.isfile("logs/LN_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        if os.path.getsize("logs/LN_{:%Y%m%d-%H%M%S}.err".format(dt_now)) > 0:
            print("====== Erroro log found. Process was stopped. => logs/LN_{:%Y%m%d-%H%M%S}.err".format(dt_now), file=sys.stderr)
            break
    executeCmd = baseCom_Lead_Renew.format(dt_now, dt_now, dt_now)
    print("2) " + executeCmd)
    result = subprocess.run(executeCmd, shell=True)
    if os.path.isfile("logs/LR_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        if os.path.getsize("logs/LR_{:%Y%m%d-%H%M%S}.err".format(dt_now)) > 0:
            print("====== Erroro log found. Process was stopped. => logs/LR_{:%Y%m%d-%H%M%S}.err".format(dt_now), file=sys.stderr)
            break
    executeCmd = baseCom_Opportunity_New.format(dt_now, dt_now, dt_now)
    print("3) " + executeCmd)
    result = subprocess.run(executeCmd, shell=True)
    if os.path.isfile("logs/ON_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        if os.path.getsize("logs/ON_{:%Y%m%d-%H%M%S}.err".format(dt_now)) > 0:
            print("====== Erroro log found. Process was stopped. => logs/ON_{:%Y%m%d-%H%M%S}.err".format(dt_now), file=sys.stderr)
            break
    executeCmd = baseCom_Opportunity_Renew.format(dt_now, dt_now, dt_now)
    print("4) " + executeCmd)
    result = subprocess.run(executeCmd, shell=True)
    if os.path.isfile("logs/OR_{:%Y%m%d-%H%M%S}.err".format(dt_now)):
        if os.path.getsize("logs/OR_{:%Y%m%d-%H%M%S}.err".format(dt_now)) > 0:
            print("====== Erroro log found. Process was stopped. => logs/OR_{:%Y%m%d-%H%M%S}.err".format(dt_now), file=sys.stderr)
            break
    executeCmd = "python3 dateCorrection.py conf=conf_dashboard.json"
    print("5) " + executeCmd)
    result = subprocess.run(executeCmd, shell=True)



dt_now = datetime.datetime.now()
print("                         ==================== start {:%Y-%m-%d %H:%M:%S} ====================".format(dt_start))
print("                         ====================  end  {:%Y-%m-%d %H:%M:%S} ====================".format(dt_now))
