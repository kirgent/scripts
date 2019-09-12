#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

host=localhost
port=8080

token=$(curl -s -X POST \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-d "{\"password\":\"1q2w3e4r\", \"userName\":\"admin\"}" \
"http://${host}:${port}/unidata-backend/api/internal/authentication/login" |awk -F "{" '{print $3}'|awk -F "\"" '{print $4}')
echo "---> login request gave token=${token}"


curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/1" > /dev/null && echo "---> deleteJob with jobId=1 is done"

curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/2" > /dev/null && echo "---> deleteJob with jobId=2 is done"

curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/3" > /dev/null && echo "---> deleteJob with jobId=3 is done"

curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/4" > /dev/null && echo "---> deleteJob with jobId=4 is done"

curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/5" > /dev/null && echo "---> deleteJob with jobId=5 is done"



jobId=$(curl -s -X PUT \
-H "Accept: */*" \
-H "Content-Type: application/json" \
-H "Connection: keep-alive" \
-H "Authorization: ${token}" \
-d "{\"name\":\"reindexMappingsJob\",\"description\":\"reindexMappingsJob\",\"cronExpression\":\"\",\"jobNameReference\":\"reindexMappingsJob\",\"enabled\":true,\"parameters\":[
{\"name\":\"reindexTypes\",\"multi_select\":false,\"value\":\"ALL\",\"type\":\"STRING\",\"deepDirty\":false,\"modelDirty\":false,\"id\":\"job.parameter.meta.DefaultMetaParameter-123\"},
{\"name\":\"usersSelector\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"deepDirty\":false,\"modelDirty\":false,\"id\":\"job.parameter.meta.UserSelectorMetaParameter-12\"},
{\"name\":\"updateMappings\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.DefaultMetaParameter-124\"},
{\"name\":\"cleanIndexes\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.DefaultMetaParameter-125\"},
{\"name\":\"recreateAudit\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.DefaultMetaParameter-126\"}]}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs" | awk -F "," '{print $1}'|awk -F ":" '{print $2}')
echo "---> createJob with jobId=${jobId} is done"


jobExecutionId=$(curl -s -X POST \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/start/${jobId}")
echo "---> startJob with jobExecutionId=${jobExecutionId} is done"


fromInd=0
itemCount=1000
status=null
while [[ ${status} != "COMPLETED" ]]
do
status=$(curl -s -X GET \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/executions/${jobId}/${fromInd}/${itemCount}"| awk -F "," '{print $5}'|awk -F "\"" '{print $4}')
echo "sleeping for 1sec, status=${status} ..."
sleep 1
done
echo "---> jobExecutionId=${jobExecutionId} is completed"


curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/${jobId}" > /dev/null && echo "---> deleteJob with jobId=${jobId} is done"


echo "---> reindexDataJob is done"
