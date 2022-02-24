#!/bin/bash

namespace=consul
BACKUP_SNAP_FILE="consul-snap-$( date +"%d-%m-%y").snap"
BACKUP_KV_FILE="consul-kv-$( date +"%d-%m-%y").json"
BACKUP_KEY_VALUE_FILE="consul-key-value-$( date +"%d-%m-%y").json"
BACKUP_KEY_VALUE_JQ_FILE="consul-key-value-jq-$( date +"%d-%m-%y").json"
BACKUP_TOKEN_FILE="consul-token-$( date +"%d-%m-%y").json"
BACKUP_PATH="consul-backup-$(date +"%d-%m-%y")"
BACKUP_POLC_FILE="consul-POLC-$( date +"%d-%m-%y")"

#/*Create Backup Folder*/

echo $BACKUP_PATH

`mkdir -p /data/consul_backup/$BACKUP_PATH`

#/*Get Namespace Service Ip*/

cluster_ip=$(kubectl get svc consul-ui -ojsonpath='{.spec.clusterIP}' -n $namespace)


#/*Get Namespace Secret Token*/

cluster_token=$(kubectl -n consul get secret consul-bootstrap-acl-token -o jsonpath='{.data.token}' | base64 --decode)

#url="http://"$cluster_ip"/v1/kv/keys?token="$cluster_token"  -o /data/consul_backup/$BACKUP_FILE"

#/*Export Snapshot*/
`curl  http://"$cluster_ip"/v1/snapshot?token="""$cluster_token"""  -o /data/consul_backup/$BACKUP_PATH/$BACKUP_SNAP_FILE`

#/*Export Kv Keys For JSON/
`curl --header "Authorization: Bearer $cluster_token" http://"$cluster_ip"/v1/kv/?keys > /data/consul_backup/$BACKUP_PATH/$BACKUP_KV_FILE`

#/*Export Key values for jq/
`curl --header "Authorization: Bearer $cluster_token" http://"$cluster_ip"/v1/kv/\?recurse=true | jq -r > /data/consul_backup/$BACKUP_PATH/$BACKUP_KEY_VALUE_JQ_FILE`

#/*Export Key values for json/
`curl --header "Authorization: Bearer $cluster_token" http://"$cluster_ip"/v1/kv/\?recurse=true | jq -r > /data/consul_backup/$BACKUP_PATH/$BACKUP_KEY_VALUE_FILE`


#/*Export Kv Token For JSON/
`curl --header "Authorization: Bearer $cluster_token" http://"$cluster_ip"/v1/acl/tokens >  /data/consul_backup/$BACKUP_PATH/$BACKUP_TOKEN_FILE`


#/*Export Kv Policy For JSON/
`curl --header "Authorization: Bearer $cluster_token" http://"$cluster_ip"/v1/acl/policies >  /data/consul_backup/$BACKUP_PATH/$BACKUP_POLC_FILE`
