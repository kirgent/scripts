#!/bin/bash
app_host_url="http://10.0.6.14:8080"
soap_api_url="unidata-backend/api"
soap_api_state="public"
soap_api_protover="v5"
#APP_HOST_URL + "/" + SOAP_API_URL + "/" + SOAP_API_STATE + "/" + SOAP_API_PROTOVER + "/" + SOAP_API_BINDING
soap_api_ns_api="http://api.mdm.unidata.com"
soap_api_ns_data="http://data.mdm.unidata.com"
soap_api_storageid="1"
soap_api_operationid="1"
###############################

username="admin"
password="1q2w3e4r"

soapAction="apiCall"
#soap_api_binding="UnidataService"
token=$(curl -s -S -X POST \
-H "Content-Type: application/soap+xml; charset=UTF-8; action=${soapAction}" \
-H "Connection: Keep-Alive" \
-H "SOAPAction: \"${soapAction}\"" \
-d "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"
xmlns:api=\"${soap_api_ns_api}/${soap_api_protover}/\"
xmlns:data=\"${soap_api_ns_data}/${soap_api_protover}/\">
<soapenv:Header/>
<soapenv:Body>
	<api:apiRequestBody>
		<api:common storageId=\"${soap_api_storageid}\" operationId=\"${soap_api_operationid}\">
			<api:security>
				<api:credentials username=\"${username}\" password=\"${password}\"/>
			</api:security>
		</api:common>
	<api:requestAuthenticate doLogin=\"true\"/>
</api:apiRequestBody>
</soapenv:Body>
</soapenv:Envelope>" \
"${app_host_url}/${soap_api_url}/${soap_api_state}/${soap_api_protover}"|tee -a log.log|awk -F "<" '{print $7}'|awk -F "\"" '{print $2}')
echo -e "\ntoken=${token}\n"|tee -a log.log



soapAction="getModel"
soap_api_protover="v5"
#soap_api_binding=""
curl -s -S -X POST \
-H "Content-Type: application/soap+xml; charset=utf-8; action=${soapAction}" \
-H "Connection: Keep-Alive" \
-H "SOAPAction: \"${soapAction}\"" \
-d "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" 
xmlns:api=\"${soap_api_ns_api}/${soap_api_protover}/\" 
xmlns:data=\"${soap_api_ns_data}/${soap_api_protover}/\">
           <soapenv:Header/>
           <soapenv:Body>
              <api:apiRequestBody>
                 <api:common storageId=\"${soap_api_storageid}\" operationId=\"${soap_api_operationid}\">
                    <api:security>
                       <api:sessionToken token=\"${token}\"/>
                    </api:security>
                 </api:common>
                 ${requestdata}
              </api:apiRequestBody>
           </soapenv:Body>
        </soapenv:Envelope>" \
"${app_host_url}/${soap_api_url}/${soap_api_state}/${soap_api_protover}"
