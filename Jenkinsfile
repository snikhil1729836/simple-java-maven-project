
pipeline {
    agent any
    tools { maven 'Maven-3.9.9' }
    environment {
        ACR_NAME = "myacr"
        IMAGE_NAME = "simple-java-app"
    }
    stages {
        stage('Clone') { steps { checkout scm } }
        stage('Build') { steps { sh 'mvn clean package' } }
        stage('Docker Build & Push') {
            steps {
                sh 'az acr login --name $ACR_NAME'
                sh 'docker build -t $ACR_NAME.azurecr.io/$IMAGE_NAME:latest .'
                sh 'docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:latest'
            }
        }
        stage('Deploy to AKS') { steps { sh 'kubectl apply -f k8s-deploy.yml' } }
    }
}
