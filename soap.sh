#!/bin/bash


#app.host.url="http://10.0.6.14:8080"
#soap.api.url="unidata-backend/api"
#soap.api.state="public"
#soap.api.state="v4"
#soap.api.protover="v5"
#soap.api.binding="UnidataService"
#soap.api.binding="MetaModelServiceBinding"
#APP_HOST_URL + "/" + SOAP_API_URL + "/" + SOAP_API_STATE + "/" + SOAP_API_PROTOVER + "/" + SOAP_API_BINDING


#action="SOAPAction:\"apiCall\""

protoVer="v5"
username="admin"
password="1q2w3e4r"

curl -X POST \
-H "Content-Type: text/xml; charset=utf-8" \
-H "SOAPAction: http://10.0.6.14:8080/unidata-backend/api/public/v5/UnidataService" \
-d "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:api=\"http://api.mdm.unidata.com/${protoVer}/\" xmlns:data=\"http://data.mdm.unidata.com/${protoVer}/\"> \
<soapenv:Header/> \
<soapenv:Body> \
<api:apiRequestBody> \
<api:common storageId="1" operationId="1"> \
<api:security> \
<api:credentials username=\"${username}\" password=\"${password}\"/> \
</api:security> \
</api:common> \
<api:requestAuthenticate doLogin=\"true\"/> \
</api:apiRequestBody> \
</soapenv:Body> \
</soapenv:Envelope>" \
"http://10.0.6.14:8080/unidata-backend/api/public/meta/v5"


exit

curl -X POST \
-H "Content-Type: text/xml; charset=utf-8" \
-H "SOAPAction: \"http://www.example.com/contractor/dtaservice/v7/contractorservice/GetProductCatalog\"" \
-d @$3 \
"http://10.0.6.14:8080/unidata-backend/api/public/meta/v5?wsdl"
