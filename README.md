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

## Create a Jenkins job

Please install `ansible` and `terraform` plugins in Jenkins page.

Create a pipeline job and configure Jenkinsfile.
