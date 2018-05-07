#!/bin/bash
aws cloudformation describe-stacks --stack-name drupalstack > temp.txt
status=`cat temp.txt | grep StackStatus |sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
if [ status = "CREATE_COMPLETE" ]

resultfrom=`aws cloudformation describe-stacks --stack-name drupalstack  | grep StackStatus |sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
echo "STATUS of JENKINS BUILD JOB - " $resultfrom

if [ $resultfrom == CREATE_COMPLETE ]
then
echo "http:"`cat temp.txt | grep OutputValue |sed 's/"//g'| cut -d : -f 3 | sed 's/\,//g'`
else
echo "yet to handle"
fi
