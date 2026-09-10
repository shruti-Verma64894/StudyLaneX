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
               withCredentials([
    usernamePassword(
        credentialsId: 'dockerhub-creds',
        passwordVariable: 'DOCKER_PASS',
        usernameVariable: 'DOCKER_USER'
    )
]) {
    sh '''
        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
    '''

    echo "Pushing Frontend..."
    sh "docker push ${FRONTEND_IMAGE}:latest"

    echo "Pushing Backend..."
    sh "docker push ${BACKEND_IMAGE}:latest"
}
