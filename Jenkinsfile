projectName = "devops-example"
repositoryName = "jenkinsfile"
dockerRepository = "artifactory.dev.eficode.io"

dockerImage = "${dockerRepository}/${projectName}/${repositoryName}"

pipeline {
  agent {
    label 'docker'
  }
  
  environment {
    BUILD_TAG = "${env.BUILD_TAG}"
  }

  options {
    timeout(time: 20, unit: 'MINUTES')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
  
    stage('Build') {
      steps {
        sh "docker build -t ${repositoryName}:latest ."
        sh "docker tag ${repositoryName}:latest ${dockerImage}:latest"
      }
    }

    stage('Push to Artifactory') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'project-templates-bot',
          usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {

          sh "docker login ${dockerRepository} -u $USERNAME -p $PASSWORD"

          sh "docker push ${dockerImage}:latest || (echo 'Looks like the push failed. Did you remember to bump the package version number?' && false)"
        }
      }
    }
  }
}