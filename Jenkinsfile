stage('Build Docker Image') {
  steps {
    sh 'docker build -t saiganesh1415/grocery_website .'
  }
}

stage('Push Image to Docker Hub') {
  steps {
    script {
      withDockerRegistry(credentialsId: 'saiganesh1415', url: '') {
        sh 'docker push saiganesh1415/grocery_website'
      }
    }
  }
}

stage('Deploy Container') {
  steps {
    script {
      sh 'docker rm -f grocery_site || true'
      sh 'docker run -d --name grocery_site -p 8081:80 saiganesh1415/grocery_website'
    }
  }
}




