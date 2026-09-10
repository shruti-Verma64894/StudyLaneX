pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USER = '<YOUR_ACTUAL_DOCKERHUB_USERNAME>'
        KUBECONFIG_CRED_ID = 'kubeconfig-file'
    }
    
    stages {
        stage('Build Images') {
            steps {
                script {
                    // Frontend uses Dockerfile in current directory (.)
                    sh 'docker build -t ${DOCKER_HUB_USER}/artify-frontend:latest .'
                    // Backend uses Dockerfile inside ./backend
                    sh 'docker build -t ${DOCKER_HUB_USER}/artify-backend:latest ./backend'
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push ${DOCKER_HUB_USER}/artify-frontend:latest'
                    sh 'docker push ${DOCKER_HUB_USER}/artify-backend:latest'
                }
            }
        }
        
        stage('Deploy to Kubernetes VM') {
            steps {
                withCredentials([file(credentialsId: "${KUBECONFIG_CRED_ID}", variable: 'KUBECONFIG_PATH')]) {
                    script {
                        sh 'export KUBECONFIG=$KUBECONFIG_PATH && kubectl rollout restart deployment artify-frontend'
                        sh 'export KUBECONFIG=$KUBECONFIG_PATH && kubectl rollout restart deployment artify-backend'
                    }
                }
            }
        }
    }
}
