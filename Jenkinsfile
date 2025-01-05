repositoryName = "master-thesis-rest-api"
dockerRepository = "270131684808.dkr.ecr.eu-north-1.amazonaws.com"

dockerImage = "${repositoryName}"

pipeline {
  agent any
  
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
        sh "docker build -t ${repositoryName}:latest app"
        sh "docker tag ${repositoryName}:latest ${dockerImage}:${BUILD_ID}"
      }
    }

    stage('Push to Artifactory') {
      steps{
        script{
          docker.withRegistry('http://270131684808.dkr.ecr.eu-north-1.amazonaws.com/master-thesis--api', 'ecr:eu-north-1:aws') {
          docker.image("${dockerImage}").push("${BUILD_ID}")
          }
        }
      }
    }

    stage('Deploy to K8S') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws_pwd', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          withEnv(['KUBECONFIG=/home/ubuntu/.kube/config', 'AWS_CONFIG_FILE=/home/ubuntu/.aws/config']){
            sh '''
            #!/bin/bash
            echo "The location of kubeconfig is $KUBECONFIG"
            # Update kube config
            aws eks --region eu-north-1 update-kubeconfig --name ruiyang_master_thesis --kubeconfig $KUBECONFIG
            kubectl apply -f k8s/yaml/deployment.yaml
          '''
          }
        }
      }
    }
  }
}
