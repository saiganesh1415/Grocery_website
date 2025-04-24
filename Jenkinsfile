pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/saiganesh1415/grocery_website.git'
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


