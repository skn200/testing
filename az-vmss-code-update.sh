#!/usr/bin/env bash

## AZ cli for querying LB backened nat pool for ssh and do docker code update

_AZ_RG='dailylearn-prod-app-rg'
_AZ_LB_NAME='dtest-vmss-lb-n1'
_CONTAINER_NAME='mycontainer'
_IMAGE_NAME='dailylearnbackend.azurecr.io/dlapp:latest'

public_ip_id=$(az network lb show -g $_AZ_RG --name $_AZ_LB_NAME --query "frontendIpConfigurations[].publicIpAddress.id" -o tsv)

PublicIP=$(az network public-ip show --ids $public_ip_id --query ipAddress -o tsv)


function update_code {
    ssh -o StrictHostKeyChecking=no -l azureuser -p $1 $PublicIP "sudo docker stop \$(sudo docker ps -q) ; sudo docker pull $_IMAGE_NAME ;sudo docker rm $_CONTAINER_NAME; sudo docker run -d --name $_CONTAINER_NAME -p 8080:8080 $_IMAGE_NAME"
}


for port in $(az network lb inbound-nat-rule list -g $_AZ_RG --lb-name $_AZ_LB_NAME --query '[].{IP:frontendPort}' -o tsv)
do
   update_code  $port
done
