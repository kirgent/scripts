#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

token=$(curl -s -X POST \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-d "{\"password\":\"1q2w3e4r\", \"userName\":\"admin\"}" \
"http://10.0.6.14:8080/unidata-backend/api/internal/authentication/login" |awk -F "{" '{print $3}'|awk -F "\"" '{print $4}')
echo "token=${token}"


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
#"http://10.0.6.14:8080/unidata-backend/api/internal/jobs" | awk -F "," '{print $1}'|awk -F ":" '{print $2}')
#echo "jobId=${jobId}"

echo "---> createJob: reindexDataJob"
jobId=$(curl -s -X PUT \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
-d "{\"name\":\"reindexDataJob\",\"description\":\"reindexDataJob\",\"cronExpression\":\"\",\"jobNameReference\":\"reindexDataJob\",\"enabled\":true,\"parameters\":[
{\"name\":\"jobUser\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.DefaultMetaParameter-77\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexTypes\",\"multi_select\":false,\"value\":\"ALL\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.EnumMetaParameter-20\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"usersSelector\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.UserSelectorMetaParameter-12\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"updateMappings\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-114\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"cleanIndexes\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-115\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"blockSize\",\"multi_select\":false,\"value\":\"1000\",\"type\":\"LONG\",\"id\":\"job.parameter.meta.DefaultMetaParameter-80\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexRecords\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-81\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexRelations\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-82\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexClassifiers\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-83\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"reindexMatching\",\"multi_select\":false,\"value\":\"true\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-84\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"skipDq\",\"multi_select\":false,\"value\":\"false\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-85\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"skipConsistencyCheck\",\"multi_select\":false,\"value\":\"false\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-86\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"skipNotifications\",\"multi_select\":false,\"value\":\"false\",\"type\":\"BOOLEAN\",\"id\":\"job.parameter.meta.DefaultMetaParameter-87\",\"deepDirty\":false,\"modelDirty\":false},
{\"name\":\"filters\",\"multi_select\":false,\"value\":\"\",\"type\":\"STRING\",\"id\":\"job.parameter.meta.DefaultMetaParameter-88\",\"deepDirty\":false,\"modelDirty\":false}]}" \
"http://10.0.6.14:8080/unidata-backend/api/internal/jobs" | awk -F "," '{print $1}'|awk -F ":" '{print $2}')
echo "jobId=${jobId}"


echo "---> startJob:"
jobExecutionId=$(curl -s -X POST \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://10.0.6.14:8080/unidata-backend/api/internal/jobs/start/${jobId}")
echo "jobExecutionId=${jobExecutionId}"

echo "sleep 60sec..."
sleep 60

status=$(curl -s -X GET \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://10.0.6.14:8080/unidata-backend/api/internal/jobs/executions/${jobId}/0/1000"| awk -F "," '{print $5}'|awk -F "\"" '{print $4}')
echo "status=${status}"

while [ ${status} != "COMPLETED" ]
do
status=$(curl -s -X GET \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://10.0.6.14:8080/unidata-backend/api/internal/jobs/executions/${jobId}/0/1000"| awk -F "," '{print $5}'|awk -F "\"" '{print $4}')
echo "status=${status}"
sleep 1
done




echo "---> deleteJob:"
curl -s -X DELETE \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: ${token}" \
"http://10.0.6.14:8080/unidata-backend/api/internal/jobs/${jobId}"
