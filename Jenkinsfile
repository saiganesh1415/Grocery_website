pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/saiganesh1415/grocery_website.git'
        DEPLOY_DIR = '/var/www/html'  // Change this to your web server directory
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "${env.REPO_URL}"
                echo 'Code checkout completed'
            }
        }

        stage('Verify Structure') {
            steps {
                script {
                    // Verify essential files exist
                    if (!fileExists('index.html')) {
                        error('index.html not found!')
                    }
                    if (!fileExists('css/style.css')) {
                        error('CSS file not found!')
                    }
                    echo 'Basic structure verification passed'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Simple deployment using rsync (requires SSH access to server)
                    // Make sure Jenkins has SSH keys configured for the target server
                    sh """
                        rsync -avz --delete \
                        --exclude='.git' \
                        --exclude='Jenkinsfile' \
                        . ${env.DEPLOY_DIR}/
                    """
                    echo 'Website deployed successfully'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
            // Add notification here (email, Slack, etc.)
        }
        failure {
            echo 'Pipeline failed!'
            // Add failure notification here
        }
    }
}
