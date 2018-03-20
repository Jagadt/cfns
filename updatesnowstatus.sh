#!/bin/sh
curl -l http://54.165.238.50:8888/job/updatesnow/lastBuild/api/json > jenkin_status

result = sed 's/\,/\,\n/g' jenkin_status | grep result | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'
sysid = sed 's/\,/\,\n/g' create_incident.txt | grep sys_id | sed 's/"//g'| cut -d : -f 2 | sed 's/\,//g'

echo $result
echo $sysid
echo $restapiurl

restapiurl="https://kgv06:password-1@cognizantclouddemo.service-now.com/api/now/table/incident/"$sysid

if [ $result == "SUCCESS" ]
then
echo "on success"
        curl -H "Content-Type: application/json" -X PUT -d '{"work_notes_list":"SUCCESS AGAIN", "incident_state":"6"}' $restapiurl
else
echo "on failure"
        curl -H "Content-Type: application/json" -X PUT -d '{"short_description":"FAILED"}' $restapiurl
fi
