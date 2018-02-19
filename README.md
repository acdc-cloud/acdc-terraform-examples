# Terraform Examples for Arctic Circle Cloud Services

## Introduction
This repository is meant as a start help to get up and running with your account at Arctic Circle Cloud Services as quick as possible. Our Services are created around OpenStack and all constraints that apply there, also apply here.

## Repository Layout
The Layout of the repository is centered around practices that have been used around terraform for some time. This means that there are a lot of subfolders to keep the execution space of a terraform run smaller and allow for more precise deployments. Apart from that it is divided like this:
- terraform  
  - global # Global Settings like SSH keypairs  
  - global-vars # Variables that need to be reused by every execution context  
  - Mo # Our Datacenter  
    - network # Networking in the Mo Datacenter  
    - region-vars # Variables that are valid for all services in the Datacenter  
    - serviceA # A service example  
    - serviceB # Another service example  

## Terraform
Terraform is a IaC tool that supports multiple clouds. In recent versions that means that before running terraform it needs to obtain all necessary plugins, which is why one needs to run "terraform init" at least once in each folder.
In addition to this please export your Openstack Password in the OS_PASSWORD environment variable.
All examples in this repo can be run by issuing the following commands in order:  
terraform init  
terraform plan  
terraform apply  

## User specific changes
Before using the examples in this repository, there are some values that need to be filled in. Theser are the following ones:
* terraform/global-vars/main.tf
** domain: Please fill in the domain name you got with your credentials
* terraform/global/main.tf
** my_keypair: Please fill in your public SSH key in the field that says YOURKEYPAIR as it will be used to access your instances

## Example Service A
Service A is a simple instance with an attached root volume booting from an Ubuntu Image. It is reachable from the internet on port 22 and 80.

## Example Service B
Service B is a simple instance with an attached root volume booting from an Ubuntu Image. In addition it executes a shell Script through Userdata, which in turn installs an Nginx server. It is reachable from the internet on port 22 and 80.

## Links
Our Website: https://www.arcticcircledc.com/  
Terraform: https://www.terraform.io/  
Terraform OpenStack Provider: https://www.terraform.io/docs/providers/openstack/index.html  
