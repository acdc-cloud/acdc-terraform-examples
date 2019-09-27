# Terraform examples for the Arctic Cloud

## Introduction
This repository will contain examples meant as a start help to get up and running with your account at the Arctic Cloud as quickly as possible.

## Repository Layout
The layout of the repository is centered around practices that have been used around terraform for some time. This means that there are a lot of subfolders to keep the execution space of a terraform run smaller and allow for more precise deployments. Apart from that it is divided like this:
- terraform  
  - global # Module for global resources, like SSH keypairs  
  - global-vars # Variables that need to be reused by every execution context  
  - arcticcloud # Our cloud service  
    - network # Module to set up a private network and subnet  
    - region-vars # Variables that are common for all modules in the arcticcloud folder  
    - serviceA # A service example  
    - serviceB # Another service example  
    - object-storage # An example that shows how to create object storage containers/buckets  
    - rancher-master # An example that sets up a rancher master  
    - loadbalancer # An example that shows how to set up a load balancer to load balance between web servers  

## Terraform
Terraform is a Infrastructure-as-Code (IaC) tool that supports multiple clouds. In recent versions this entails that before running, terraform needs to obtain all necessary plugins, which is why one needs to run "terraform init" at least once for each module.
In addition to this please export your Openstack Password in the OS_PASSWORD environment variable.
All examples in this repo can be run by issuing the following commands in order:  
terraform init  
terraform plan  
terraform apply  

Please note that the examples have been upgraded to the 0.12 version of terraform.

## User specific changes
Before using the examples in this repository, there are some values that need to be filled in. These are:
* terraform/global-vars/main.tf
** domain: Please fill in the domain name you got with your credentials, usually the e-mail address
* terraform/global/main.tf
** my_keypair: Please fill in your public SSH key in the field that says YOURKEYPAIR as it will be used to access your instances

## Example Service A
Service A is a simple instance with an attached root volume booting from an Ubuntu Image. It is reachable from the internet on port 22 and 80.

Please note that you will have to run terraform in the global and network modules before running this module.

## Example Service B
Service B is a simple instance with an attached root volume booting from an Ubuntu Image. In addition it executes a shell Script through Userdata, which in turn installs an Nginx server. It is reachable from the internet on port 22 and 80.

Please note that you will have to run terraform in the global and network modules before running this module.

## Example Object Storage
This example creates two object storage containers. One private container called demo, and one public container called demo-public.

## Example Rancher Master
This example sets up a rancher master host.

Please note that you will have to run terraform in the global and network modules before running this module.

## Example Load Balancer
This example sets up a load balancer to load balance two nginx web servers in round robin.

Please note that you will have to run terraform in the global and network modules before running this module.

## Links
Our Website: https://www.arcticcloud.com/  
Terraform: https://www.terraform.io/  
Terraform OpenStack Provider: https://www.terraform.io/docs/providers/openstack/index.html  
