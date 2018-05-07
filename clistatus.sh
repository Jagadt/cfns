#!/bin/bash
aws cloudformation describe-stacks --stack-name drupalstack > temp.txt
status=`cat temp.txt | grep StackStatus |sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'`
if [ status = "CREATE_COMPLETE" ]
