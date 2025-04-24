pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/yourusername/Grocerywebsite.github.io.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('grocery_website')
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}
