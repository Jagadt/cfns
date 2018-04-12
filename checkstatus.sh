#!/bin/sh

resultfrom=`aws cloudformation describe-stacks --stack-name drupalstack | grep StackStatus |sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
echo "STATUS of JENKINS BUILD JOB - " $resultfrom

restapiurl="https://kgv06:password-1@cognizantclouddemo.service-now.com/api/now/table/incident/"$1

if [ $resultfrom == CREATE_COMPLETE ]
then
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB success","incident_state":"6" }' $restapiurl
else
curl  -H "Content-Type: application/json" -X PUT -d '{"work_notes":"Jenkins JOB  is progress" }' $restapiurl
fi
