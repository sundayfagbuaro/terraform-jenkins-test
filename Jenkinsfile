pipeline {
    agent any
    
    stages {
        stage('Cleanup Workspace'){
            steps{
                cleanWs()
            }
        }

        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'main', credentialsId: 'git_cred', url: 'https://github.com/sundayfagbuaro/terraform-jenkins-test.git'
                
                }
            }
        }

        stage('Run Terraform init'){
            steps{
                sh """
                    terraform init
                """
            }
        }

        stage('Apply Terraform Plan'){
            steps{
                sh """ 
                   terraform apply --auto-approve
 
                """
                
            }                   
        }
        
    }   
} 