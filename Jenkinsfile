node {
    def IMAGE = 'saiganesh1415/grocery_website'
    def CONTAINER = 'grocery_site'

    stage('Clone Repository') {
        git branch: 'main', url: 'https://github.com/saiganesh1415/grocery_website'
    }

    stage('Build Docker Image') {
        sh "docker build -t ${IMAGE} ."
    }

    stage('Push to Docker Hub') {
        withDockerRegistry(credentialsId: 'saiganesh1415', url: '') {
            sh "docker push ${IMAGE}"
        }
    }

    stage('Deploy Container') {
        sh "docker rm -f ${CONTAINER} || true"
        sh "docker run -d --name ${CONTAINER} -p 8081:80 ${IMAGE}"
    }
}





