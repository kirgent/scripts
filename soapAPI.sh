#!/bin/bash
app_host_url="http://10.0.6.14:8080"
soap_api_url="unidata-backend/api"
soap_api_state="public"
soap_api_protover="v5"
soap_api_binding="UnidataService"
#soap.api.binding="MetaModelServiceBinding"
#APP_HOST_URL + "/" + SOAP_API_URL + "/" + SOAP_API_STATE + "/" + SOAP_API_PROTOVER + "/" + SOAP_API_BINDING
protoVer="v5"
storageId="1"
operationId="1"
username="admin"
password="1q2w3e4r"

token=$(curl -s -X POST \
-H "Content-Type: text/xml; charset=UTF-8" \
-H "SOAPAction: \"apiCall\"" \
-d "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" \
xmlns:api=\"http://api.mdm.unidata.com/${protoVer}/\" \
xmlns:data=\"http://data.mdm.unidata.com/${protoVer}/\"> \
<soapenv:Header/>
<soapenv:Body>
<api:apiRequestBody>
<api:common storageId=\"${storageId}\" operationId=\"${operation}\">
<api:security>
<api:credentials username=\"${username}\" password=\"${password}\"/>
</api:security>
</api:common>
<api:requestAuthenticate doLogin=\"true\"/>
</api:apiRequestBody>
</soapenv:Body>
</soapenv:Envelope>" \
"${app_host_url}/${soap_api_url}/${soap_api_state}/${soap_api_protover}/${soap_api_binding}"|awk -F "<" '{print $7}'|awk -F "\"" '{print $2}'| tee -a log.log)
echo "token=$token"


exit

curl -X POST \
-H "Content-Type: text/xml; charset=utf-8" \
-H "SOAPAction: \"http://www.example.com/contractor/dtaservice/v7/contractorservice/GetProductCatalog\"" \
-d @$3 \
"http://10.0.6.14:8080/unidata-backend/api/public/meta/v5?wsdl"
