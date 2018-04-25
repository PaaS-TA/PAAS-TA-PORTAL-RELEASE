#!/usr/bin/env bash


function get_id () {
    echo `"$@" | grep ' id ' | awk '{print $4}'`
}

if [[ -z $1 ]];
then
    echo "Please Enter your Swift PROXY IP/Hostname:"
    read SWIFT_IP
else
    SWIFT_IP=$1
fi
echo
echo
###### Inject Sample Data ######
CONTROLLER_PUBLIC_ADDRESS=${CONTROLLER_PUBLIC_ADDRESS:-localhost}
CONTROLLER_ADMIN_ADDRESS=${CONTROLLER_ADMIN_ADDRESS:-localhost}
CONTROLLER_INTERNAL_ADDRESS=${CONTROLLER_INTERNAL_ADDRESS:-localhost}
export SERVICE_TOKEN=`./config_service_token`
export SERVICE_ENDPOINT=`./service_endpoint`
CONFIG_ADMIN_PORT=`./config_admin_port`
CONFIG_PUBLIC_PORT=`./config_public_port`

#
# Swift service
#
SWIFT_SERVICE=$(get_id \
keystone service-create --name=swift \
                        --type="object-store" \
                        --description="Swift Service")
if [[ -z "$DISABLE_ENDPOINTS" ]]; then
    keystone endpoint-create --region RegionOne --service-id $SWIFT_SERVICE \
        --publicurl   "http://$SWIFT_IP/v1/KEY_\$(tenant_id)s" \
        --adminurl    "http://$CONTROLLER_ADMIN_ADDRESS/v1" \
        --internalurl "http://$CONTROLLER_INTERNAL_ADDRESS/v1/KEY_\$(tenant_id)s"
fi

echo "==================Sample data Inject Finished=========================="
echo
sleep 2
echo
echo "==================Create User/Password/Tenant : swiftstack/password/SS===================="

SS_TENANT=$(get_id \
keystone tenant-create --name SS --enabled true --description "SwiftStack-DEV Tenant")
keystone user-create --name swiftstack --pass password --tenant-id $SS_TENANT --email support@swiftstack.com --enabled true

echo
echo "================= Test v2.0 API to get TOKEN/Service Catalog of user swiftstack =================="
sleep 2

curl -d '{"auth":{"passwordCredentials":{"username": "swiftstack", "password": "password"},"tenantName":"SS"}}' -H "Content-type: application/json" http://localhost:5000/v2.0/tokens | python -mjson.tool

sleep 2
echo
echo "================== Test Keystone V3 API to get TOKEN/Service Catalog of user swiftstack ====================="

curl -d '{"auth":{"identity":{"methods":["password"],"password":{"user":{"domain":{"name":"default"},"name":"swiftstack","password":"password"}}},"scope":{"project":{"domain":{"name":"default"},"name":"SS"}}}}' -H "Content-type: application/json" http://localhost:5000/v3/auth/tokens | python -mjson.tool

