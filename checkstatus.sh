#!/bin/sh

#resultfrom=`aws cloudformation describe-stacks --stack-name awscodestar-nodejs-serverle-lambda  | grep StackStatus |sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`

resultfrom=`curl -l http://54.227.32.163:8080/job/AzureShell-ARM%20Deployment/lastBuild/api/json | sed 's/\,/\,\n/g' | grep result | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'
echo "STATUS of JENKINS BUILD JOB - " $resultfrom
echo "SYSID= " $1
restapiurl="https://<kgv>:<pass>@cognizantclouddemo.service-now.com/api/now/table/incident/"$1

echo "url = " $restapiurl

if [ $resultfrom == CREATE_COMPLETE ]
then
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB success","incident_state":"6" }' $restapiurl
else
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB  is progress" }' $restapiurl
fi
