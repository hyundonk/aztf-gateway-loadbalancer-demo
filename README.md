# Azure Gateway Load Balancer Test

This repo contains terraform files for deploying azure gateway load balancer with fortigate firewall VMs.

In this demo environment, Azure Gateway Load Balancer is deployed at the security service provider virtual network and has 2 fortigate VMs in the backend pool.

A Azure Standard load balancer (Public Preview as of Feb 2022) at the client side virtual network can configure its frontend to be connected to a Azure Gateway Load Balancer creating VXLAN tunnel to the fortigate VMs. 

This demo configuration support the following use cases.
 - Internet inbound filtering and SSL offloads before sending inbound session to web servers in the client VNET
 - Internet outbound filtering.


Fortigate VMs are configured to perform the following services.
 - firewall 
 - IDS/IPS
 - SSL offload 
 - Add X-Forwarded-Proto header


You can deploy demo environment using terraform as follow
```
# First check terraform.tfvars file and change any variable as needed. 

# Then login using Azure CLI
$ az login 

# Run terraform init
$ terraform init

# Run terraform apply
# terraform apply
```

Then the following resources will be deployed. 
 - A virtual network with 2 subnets (One for backend subnet and the other for management subnet)
 - Azure Gateway Load Balancer in backend subnet
 - 2 Fortigate VMs with 2 network interfaces each. (One interface for tunneling with client side azure load balancer and the other for management web ui access.)
 - 2 Public IP addresses for Fortigate Management UI access


