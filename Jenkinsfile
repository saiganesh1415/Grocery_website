stage('Build Docker Image') {
  steps {
    script {
      dockerImage = docker.build("${DOCKER_IMAGE}")
    }
  }
}

stage('Push to Docker Hub') {
  steps {
    script {
      docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
        dockerImage.push("latest")
      }
    }
  }
}

stage('Deploy Container') {
  steps {
    script {
      // Remove old container if exists and start new one
      sh '''
        docker rm -f grocery_site || true
        docker run -d -p 8080:80 --name grocery_site ${DOCKER_IMAGE}:latest
      '''
    }
  }
}



