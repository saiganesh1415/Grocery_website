pipeline {
    agent any

    environment {
        // Define environment variables
        REPO_URL = 'https://github.com/saiganesh1415/grocery_website.git'
        BRANCH = 'main'
        DOCKER_IMAGE = 'grocery-website'
        DOCKER_REGISTRY = 'your-docker-registry' // Replace with your registry
        DEPLOY_ENV = 'production'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub
                git branch: "${env.BRANCH}", url: "${env.REPO_URL}"
                echo 'Code checkout completed'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Since this is a static HTML site, we might not need build tools
                // But you can add any necessary steps here
                echo 'No dependencies to install for static HTML site'
            }
        }

        stage('Linting') {
            steps {
                // HTML validation (optional)
                script {
                    try {
                        sh 'npm install -g html-validator' // If you want HTML validation
                        sh 'html-validator --file index.html'
                    } catch (e) {
                        echo 'HTML validation failed, continuing...'
                        // You might want to make this non-fatal for simple projects
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Create a simple Dockerfile if it doesn't exist
                    if (!fileExists('Dockerfile')) {
                        writeFile file: 'Dockerfile', text: '''
                        FROM nginx:alpine
                        COPY . /usr/share/nginx/html
                        EXPOSE 80
                        '''
                    }
                    
                    // Build Docker image
                    docker.build("${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Test') {
            steps {
                // Simple test to verify the HTML loads
                script {
                    // You could add more sophisticated tests here
                    def htmlContent = readFile('index.html')
                    if (!htmlContent.contains('groco')) {
                        error('Basic content check failed!')
                    }
                    echo 'Basic content validation passed'
                }
            }
        }

        stage('Push to Registry') {
            when {
                expression { env.DEPLOY_ENV == 'production' }
            }
            steps {
                script {
                    // Login to Docker registry (configure credentials in Jenkins)
                    docker.withRegistry('https://' + env.DOCKER_REGISTRY, 'docker-hub-credentials') {
                        docker.image("${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { env.DEPLOY_ENV == 'production' }
            }
            steps {
                script {
                    // Simple deployment - in a real scenario you'd use Kubernetes, ECS, etc.
                    // This is just an example - adjust for your infrastructure
                    sh "docker run -d -p 8080:80 --name grocery-website ${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                    echo 'Deployed to test environment'
                    
                    // For production, you might do a blue-green deployment
                    // or update a Kubernetes deployment, etc.
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
            // Optional: Send success notification
        }
        failure {
            echo 'Pipeline failed!'
            // Optional: Send failure notification
        }
    }
}





