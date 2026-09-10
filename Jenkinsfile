pipeline {
    agent any
 
    environment {
        // REPLACE 'your_dockerhub_username' with your actual Docker Hub username
        DOCKER_HUB_USER = 'adi1310'
        FRONTEND_IMAGE  = "${DOCKER_HUB_USER}/mern-frontend"
        BACKEND_IMAGE   = "${DOCKER_HUB_USER}/mern-backend"
    }
 
    stages {
        stage('Build Images') {
            steps {
                echo "Building Frontend Image..."
                sh "docker build -t ${FRONTEND_IMAGE}:latest ."
 
                echo "Building Backend Image..."
                sh "docker build -t ${BACKEND_IMAGE}:latest ./backend"
            }
        }
 
        stage('Push to Docker Hub') {
            steps {
                echo "Logging into Docker Hub..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASS', usernameVariabl>
                    // Using --password-stdin is the secure way to log in via CLI
                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
