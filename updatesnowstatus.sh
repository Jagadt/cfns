#!/bin/sh

sysid=`curl  -H "Content-Type: application/json" -X POST -d '{"short_description":"Jenkins pipeline triggered to execute service catalog item","assignment_group":"d625dccec0a8016700a222a0f7900d06"}' https://kgv06:password-1@cognizantclouddemo.service-now.com/api/now/table/incident | sed 's/\,/\,\n/g' | grep sys_id | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
echo "SYSID=" $sysid
aws cloudformation  create-stack --stack-name drupalstack --region us-east-1 --template-body file://drupal.json --parameters ParameterKey=InstanceType,ParameterValue=t2.micro

#curl -l http://54.165.238.50:8888/job/PC-PipelineJob2/build?delay=0sec

resultfrom=`curl -l http://18.233.157.155:8888/job/PC-PipelineJob2/lastBuild/api/json | sed 's/\,/\,\n/g' | grep result | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
echo "STATUS of JENKINS BUILD JOB - " $resultfrom

restapiurl="https://kgv06:password-1@cognizantclouddemo.service-now.com/api/now/table/incident/"$sysid
if [ $resultfrom == SUCCESS ]
then
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB success","incident_state":"6" }' $restapiurl
else
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB  failed" }' $restapiurl
fi
