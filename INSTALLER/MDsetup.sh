#!/usr/bin/bash

CMDNAME=`basename $0`

if [ $# -ne 12 ]; then
  echo "Usage: $CMDNAME -a datalake(ma) -d datamart -m master -p project-ID -s datalake(sfa) -w datawarehouse" 1>&2
  exit 1
fi

while getopts a:d:m:p:s:w: OPT
do
  case $OPT in
    "a" ) FLG_A="TRUE" ; VALUE_A="$OPTARG" ;;
    "d" ) FLG_D="TRUE" ; VALUE_D="$OPTARG" ;;
    "m" ) FLG_M="TRUE" ; VALUE_M="$OPTARG" ;;
    "p" ) FLG_P="TRUE" ; VALUE_P="$OPTARG" ;;
    "s" ) FLG_S="TRUE" ; VALUE_S="$OPTARG" ;;
    "w" ) FLG_W="TRUE" ; VALUE_W="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME -a datalake(ma) -d datamart -m master -p project-ID -s datalake(sfa) -w datawarehouse" 1>&2
          exit 1 ;;
  esac
done

#   データセットの作成
bq mk --location=asia-northeast1 --dataset $VALUE_P:$VALUE_D
bq mk --location=asia-northeast1 --dataset $VALUE_P:$VALUE_W
bq mk --location=asia-northeast1 --dataset $VALUE_P:$VALUE_A
bq mk --location=asia-northeast1 --dataset $VALUE_P:$VALUE_M
bq mk --location=asia-northeast1 --dataset $VALUE_P:$VALUE_S

#   テーブルの作成（datawarehouse）
while read -r P; do

  F=${P##*/}
  T=${F%.*}
  bq mk --location=asia-northeast1 --table --schema=$P \
                  $VALUE_P:$VALUE_W.$T

done < <(find ./schema/datawarehouse  -mindepth 1 -maxdepth 1 -type f -name "*.json")

#   テーブルの作成（dl_master）
while read -r P; do

  F=${P##*/}
  T=${F%.*}
  bq mk --location=asia-northeast1 --table --schema=$P \
                  $VALUE_P:$VALUE_M.$T

done < <(find ./schema/dl_master  -mindepth 1 -maxdepth 1 -type f -name "*.json")

#   functionのプロジェクトIDおよびデータセットの置き換え
while read -r P; do

    cp $P ${P%.*}.bak
    sed -e "s/#Project-id#/$VALUE_P/" $P > ${P%.*}.tmp
    sed -e "s/#data-Ware-house#/$VALUE_W/" ${P%.*}.tmp > ${P%.*}.tmp2
    sed -e "s/#Master#/$VALUE_M/" ${P%.*}.tmp2 > ${P%.*}.tmp
    rm ${P%.*}.tmp2
    sed -e "s/#Datamart#/$VALUE_D/" ${P%.*}.tmp > $P
    rm ${P%.*}.tmp

done < <(find ./function  -mindepth 1 -maxdepth 1 -type f -name "*.sql")

#   functionの作成（datamart）
while read -r P; do

  bq query --use_legacy_sql=false < $P

done < <(find ./function  -mindepth 1 -maxdepth 1 -type f -name "*.sql")

#   viewのプロジェクトIDおよびデータセットの置き換え
while read -r P; do

    cp $P ${P%.*}.bak
    sed -e "s/#Project-id#/$VALUE_P/" $P > ${P%.*}.tmp
    sed -e "s/#data-Ware-house#/$VALUE_W/" ${P%.*}.tmp > ${P%.*}.tmp2
    sed -e "s/#Master#/$VALUE_M/" ${P%.*}.tmp2 > ${P%.*}.tmp
    rm ${P%.*}.tmp2
    sed -e "s/#Datamart#/$VALUE_D/" ${P%.*}.tmp > $P
    rm ${P%.*}.tmp

done < <(find ./view  -mindepth 1 -maxdepth 1 -type f -name "*.sql")

#   viewの作成（datamart）
Fs=(
  "V_Account_Contact.sql"
  "V_Account_Order.sql"
  "V_Channel_KPI.sql"
  "V_Contact_Activity.sql"
  "V_Forecast_Management.sql"
  "V_Forecast_Management_Team.sql"
  "V_Forecast_Management_User.sql"
  "V_Lead_ChangeDataValue.sql"
  "V_Opportunity_History.sql"
  "V_LeadStage_Achievement.sql"
  "V_Lead_Acquired_Achievement.sql"
  "V_Lead_Monitoring.sql"
  "V_Leads.sql"
  "V_Marketing_ROI.sql"
  "V_Opportunity_Accuracy.sql"
  "V_Opportunity_Achievement_User.sql"
  "V_Opportunity_ChangeDataValue.sql"
  "V_Opportunity_Last_Year.sql"
  "V_Opportunity_Phase_Progress.sql"
  "V_Opportunity_Phase_Progress_Team.sql"
  "V_Opportunity_Phase_Progress_User.sql"
  "V_Opportunity_Stage.sql"
  "V_Opportunity_Stage_Team.sql"
  "V_Opportunity_Stage_User.sql"
  "V_Sales_Management_User.sql"
  "V_Target_Account.sql"
)
for F in "${Fs[@]}" ; do
  echo "[ ${F} ]"
  V=${F%.*}
  bq mk --use_legacy_sql=false --project_id $VALUE_P \
        --view  "`cat view/$F`" \
                  $VALUE_D.$V
done

