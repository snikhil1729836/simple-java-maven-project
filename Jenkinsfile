pipeline {
    agent any

    tools {
        maven 'Maven-3.9.9'
        jdk 'JDK_21'
    }

    environment {
        IMAGE_NAME = "simple-java-app"
        DOCKER_HUB_USERNAME = "snikhil1729"
    }

    stages {

        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        ✅ stage('Validate Environment') {
            steps {
                sh '''
                    echo "===== VALIDATING BUILD ENVIRONMENT ====="
                    echo "Java Version:"
                    java -version
                    echo "Maven Version:"
                    mvn -version
                    echo "JAVA_HOME=$JAVA_HOME"
                    echo "===== VALIDATION COMPLETE ====="
                '''
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DH_USER',
                    passwordVariable: 'DH_TOKEN'
                )]) {
                    sh '''
                        echo $DH_TOKEN | docker login -u $DH_USER --password-stdin
                        docker build -t $DH_USER/$IMAGE_NAME:latest .
                        docker push $DH_USER/$IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes (k3s)') {
            steps {
                sh 'kubectl apply -f k8s-deploy.yml'
            }
        }
    }
}
