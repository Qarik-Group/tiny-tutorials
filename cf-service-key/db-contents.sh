#!/bin/bash

service_instance_name=$1

if [[ ! -f ~/.cf/config.json ]]; then
  >&2 echo "Run 'cf login' to target & login to a Cloud Foundry"
  exit 1
fi

space_guid=$(cat ~/.cf/config.json | jq -r .SpaceFields.GUID)
if [[ "${space_guid}" == "null" ]]; then
  >&2 echo "Run 'cf target -s <space>' to target a space"
  exit 1
fi

if [[ -z $service_instance_name ]]; then
  >&2 echo "USAGE: ./db-contents.sh <service_instance_name>"
  cf services
  exit 1
fi

shift


service_instance=$(cf curl /v2/spaces/${space_guid}/service_instances\?q=name:$service_instance_name)
if [[ "$(echo $service_instance | jq -r .total_results)" == "0" ]]; then
  >&2 echo "No service instance named '$service_instance'"
  >&2 echo "USAGE: ./db-contents.sh <service_instance_name>"
  exit 1
fi

service_instance_keys_url=$(echo $service_instance | jq -r ".resources[0].entity.service_keys_url")
service_instance_keys=$(cf curl $service_instance_keys_url)
if [[ "$(echo $service_instance_keys | jq -r .total_results)" == "0" ]]; then
  >&2 echo "No existing service key for '$service_instance_name'. Creating..."
  service_instance_guid=$(echo $service_instance | jq -r ".resources[0].metadata.guid")
  service_key=$(cf curl -X POST /v2/service_keys -d "{\"service_instance_guid\":\"${service_instance_guid}\",\"name\":\"${service_instance_name}-key\"}")
else
  service_key=$(echo $service_instance_keys | jq -r ".resources[0]")
fi

uri=$(echo $service_instance_keys | jq -r ".resources[0].entity.credentials.uri")
if [[ "${url:-X}" == "null" ]]; then
  >&2 echo "Service '${service_instance_name}' has no 'uri' credential"
  exit 1
fi

uri=postgres://postgres:Tof2gNVZMz6Dun@52.202.142.106:33007/postgres
if [[ "${1:-X}" == "X" ]]; then
  psql $uri -c '\dt;'
  >&2 echo "Arguments provided will be passed to 'psql'. Defaulting to \"-c '\dt;'"
else
  psql $uri "$@"
fi
