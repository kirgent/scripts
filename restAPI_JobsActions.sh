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

curl -v -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://${host}:${port}/unidata-backend/api/internal/jobs/5" > /dev/null && echo "---> deleteJob with jobId=5 is done"


#echo "---> createJob: reindexMappingsJob"
#jobId=$(curl -s -X PUT \
#-H "Accept: application/json" \
#-H "Content-Type: application/json" \
#-H "Authorization: ${token}" \
#-d "{\"name\":\"reindexMappingsJob\",\"description\":\"reindexMappingsJob\",\"cronExpression\":\"\",\"jobNameReference\":\"reindexMappingsJob\",\"enabled\":true,\"parameters\":[
#{\"name\":\"reindexTypes\",\"multi_select\":false,\"value\":\"ALL\",\"type\":\"STRING\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.EnumMetaParameter-18\"},
#{\"name\":\"usersSelector\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"deepDirty\":false,\"modelDirty\":false,\"id\":\"job.parameter.meta.UserSelectorMetaParameter-10\"},
#{\"name\":\"updateMappings\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.DefaultMetaParameter-84\"},
#{\"name\":\"cleanIndexes\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.DefaultMetaParameter-85\"},
#{\"name\":\"recreateAudit\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"deepDirty\":false,\"modelDirty\":true,\"id\":\"job.parameter.meta.DefaultMetaParameter-86\"}]
#}" \
#"http://${host}:${port}/unidata-backend/api/internal/jobs" | awk -F "," '{print $1}'|awk -F ":" '{print $2}')
#echo "jobId=${jobId}"

jobId=$(curl -v -X PUT \
-H "Accept: */*" \
-H "Content-Type: application/json" \
-H "Connection: keep-alive" \
-H "Authorization: ${token}" \
-d "{\"name\":\"reindexDataJob\",\"description\":\"reindexDataJob\",\"cronExpression\":\"\",\"jobNameReference\":\"reindexDataJob\",\"enabled\":true,\"parameters\":[
{\"name\":\"jobUser\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.DefaultMetaParameter-77\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexTypes\",\"multi_select\":false,\"value\":\"ALL\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.EnumMetaParameter-15\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"usersSelector\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.UserSelectorMetaParameter-9\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"updateMappings\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-78\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"cleanIndexes\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-79\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"blockSize\",\"multi_select\":false,\"value\":\"1000\",\"type\":\"LONG\",\"id\":\"job.parameter.meta.DefaultMetaParameter-80\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexRecords\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-81\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexRelations\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-82\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexClassifiers\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-83\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexMatching\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-84\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"skipDq\",\"multi_select\":false,\"value\":\"false\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-85\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"skipConsistencyCheck\",\"multi_select\":false,\"value\":\"false\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-86\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"skipNotifications\",\"multi_select\":false,\"value\":\"false\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-87\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"filters\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.DefaultMetaParameter-88\",\"deepDirty\":false,\"modelDirty\":false}]}" \
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
