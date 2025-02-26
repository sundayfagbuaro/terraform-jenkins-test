pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'main', credentialsId: 'git_cred', url: 'https://github.com/sundayfagbuaro/terraform-jenkins-test.git'
                
                }
            }
        }

        stage('Run Terraform init'){
            steps{
                
                sh "terraform init"
            }
        }

        stage('Terraform action'){
            steps {
                withCredentials([
                    aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    credentialsId: 'Jenkins-cicd-user', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    
                        sh "terraform ${Actions} --auto-approve"
                    }
            }             
        }

    }
}
