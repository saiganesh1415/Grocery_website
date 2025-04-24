pipeline {
    agent {
        docker {
            image 'docker:24.0.2-dind'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t grocery_website .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}

