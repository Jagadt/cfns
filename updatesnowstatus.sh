#!/bin/sh

sysid=`curl  -H "Content-Type: application/json" -X POST -d '{"short_description":"Jenkins pipeline triggered to execute service catalog item","assignment_group":"d625dccec0a8016700a222a0f7900d06"}' https://kgv06:password-1@cognizantclouddemo.service-now.com/api/now/table/incident | sed 's/\,/\,\n/g' | grep sys_id | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
echo "SYSID=" $sysid
az group deployment create --name testdrupal1 --resource-group testdrupal1  --template-file C:\jags\arm\drupalonlinux.json --parameters "{\"newStorageAccountName\": {\"value\": \"coedrupalsg34\"}, \"vmDnsName\": {\"value\": \"coedrupal99\"}, \"adminUsername\": {\"value\": \"demouser\"}, \"adminPassword\": {\"value\": \"YUVanika!234\"}, \"mySqlPassword\": {\"value\": \"YUVanika!234\"}, \"vmSize\": {\"value\": \"Standard_D2\"}}"
#curl -l http://54.165.238.50:8888/job/PC-PipelineJob2/build?delay=0sec

sleep 10


resultfrom=`curl -l http://54.227.32.163:8080/job/AzureShell-ARM%20Deployment/lastBuild/api/json | sed 's/\,/\,\n/g' | grep result | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'
echo "STATUS of JENKINS BUILD JOB - " $resultfrom

sleep 10

restapiurl="https://cognizantclouddemo.service-now.com/api/now/table/incident/"$sysid

if [ $resultfrom == CREATE_COMPLETE ]
then
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB success","incident_state":"6" }' $restapiurl
else
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB  is progress" }' $restapiurl
fi
