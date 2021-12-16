# CI-CD flow using Jenkins/Terraform/Ansible/Docker

This is a demo project for provisiong server, configuring server and deploying a backend app using Jenkins + Terraform + Ansible.

## Prerequisites

### 1. Install Jenkins server

Guide : https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-20-04

### 2. Install Ansible and Terraform

#### Install Ansible

```sh
apt-get update && apt-get install -y ansible
```

#### Install Terraform

```sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

### 3. Create a key for AWS Key Pair

This is a key used for connecting to AWS EC2 Instance provisioned using Terraform.

```sh
sudo su jenkins
ssh-keygen -f ~/.ssh/aws_key
```

### 4. Configure AWS credential file

This is a credential file for connecting to AWS services. This credential file is used by Terraform.

```sh
sudo su jenkins
mkdir ~/.aws
nano ~/.aws/credentials
```

And add the content below with the approriate values.

```
[default]
aws_access_key_id = <access_key>
aws_secret_access_key = <secret_key>
```

## Configure Jenkins

### Setup Ansible and Terraform tools

Install `ansible` and `terraform` plugins in `Jenkins -> Manage Plugins -> Available`.

Confirm the installation directory for ansible/terraform binaries inside Jenkins server. Then set the tool name and the installation directory under Ansible/Terraform  in `Jenkins -> Global Tool Configuration -> Available`.

### Create a pipeline 

Create a Pipeline job (`New Item -> Pipeline`) and set [Jenkinsfile](Jenkinsfile) under `Pipeline script from SCM`.

![image](https://user-images.githubusercontent.com/26896535/146295221-cdfe3c8b-b3dd-42c6-b8c4-21344468fc19.png)

Once a Pipeline job created, please build it. It will provision an AWS EC2 server and install everything, finally deploy the backend service.

## Check Backend endpoint.

The final stage `Backend Url` of the pipeline should show the backend url. Then open it on web browser.
