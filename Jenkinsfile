pipeline {
  agent any
  tools {
    terraform 'terraform'
  }
  parameters {
    string(name: 'EC2_INSTANCE_NAME', defaultValue: 'backend', description: 'Name for AWS EC2 Instance')
    string(name: 'NAME_PREFIX', defaultValue: 'demo', description: 'The prefix for the name of AWS resources such as VPC, Subnet, Security Group, etc.')
  }
  stages {
    // Git Checkout
    // stage('SCM') {
    //   steps {
    //     git branch: 'main', url: 'https://github.com/anaxdev/microsvc.git'
    //   }
    // }
    // Run Terraform scripts
    stage('Server Provision') {
      steps {
        // Run within terraform directory!
        dir('terraform') {
          sh 'terraform init'
          sh "terraform apply -auto-approve \
            -var 'name_prefix=${params.NAME_PREFIX}' \
            -var 'ec2_instance_name=${params.EC2_INSTANCE_NAME}'"
        }
      }
    }
    // Run Ansible playbooks
    stage('Server Configuration') {
      steps {
        ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: 'ansible/inventory.yml', playbook: 'ansible/install-docker.yml'
      }
    }
    stage('Deploy Backend') {
      steps {
        ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: 'ansible/inventory.yml', playbook: 'ansible/deploy-backend.yml'
      }
    }
    stage('Backend Url') {
      steps {
        dir('terraform') {
          sh 'echo Backend Url = http://$(terraform output --raw server_ip)'
        }
      }
    }
  }
}