#!/bin/bash

# Variables

resourceGroupName="rg_my"
location="USEast"
vnetName="vnet_my"
subnetName="subnet"
acrName="acr_my"
vmName="vm_my"
nsgName="nsg_my"
publicIpName="my_ip"

# Create a resource group
az group create --name $resourceGroupName --location $location

# Create a virtual network
az network vnet create --resource-group $resourceGroupName --name $vnetName --location $location --address-prefixes 10.0.0.0/16

# Create a subnet
az network vnet subnet create --resource-group $resourceGroupName --vnet-name $vnetName --name $subnetName --address-prefixes 10.0.0.0/24

# Create an Azure Container Registry
az acr create --resource-group $resourceGroupName --name $acrName --sku Basic

# Create a public IP address
az network public-ip create --resource-group $resourceGroupName --name $publicIpName --sku Basic

# Create a Network Security Group
az network nsg create --resource-group $resourceGroupName --name $nsgName

# Define security rules for NSG (HTTP, HTTPS, SSH)
az network nsg rule create --resource-group $resourceGroupName --nsg-name $nsgName --name AllowHTTP --priority 100 --protocol Tcp --direction Inbound --source-address-prefix '*' --source-port-range '*' --destination-address-prefix '*' --destination-port-range 80 --access Allow
az network nsg rule create --resource-group $resourceGroupName --nsg-name $nsgName --name AllowHTTPS --priority 110 --protocol Tcp --direction Inbound --source-address-prefix '*' --source-port-range '*' --destination-address-prefix '*' --destination-port-range 443 --access Allow
az network nsg rule create --resource-group $resourceGroupName --nsg-name $nsgName --name AllowSSH --priority 120 --protocol Tcp --direction Inbound --source-address-prefix '*' --source-port-range '*' --destination-address-prefix '*' --destination-port-range 22 --access Allow

# Create a virtual machine
az vm create --resource-group $resourceGroupName --name $vmName --image UbuntuLTS --admin-username aaa --admin-password aaa --nsg $nsgName --subnet $subnetName --public-ip-address $publicIpName

# Output information
echo "Resource Group: $resourceGroupName"
echo "VNet Name: $vnetName"
echo "Subnet Name: $subnetName"
echo "ACR Name: $acrName"
echo "VM Name: $vmName"
echo "Public IP Name: $publicIpName"
echo "NSG Name: $nsgName"






