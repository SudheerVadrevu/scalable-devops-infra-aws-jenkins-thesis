repositoryName = "master-thesis-rest-api"
dockerRepository = "585466297447.dkr.ecr.eu-north-1.amazonaws.com"

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
        sh 'printenv'
        checkout scm
        stash(excludes: '.git', name: 'code')
      }
    }
  
    stage('Build') {
        agent {
            ecs {
                inheritFrom 'ecs'
                label 'test'
            }
        }
      steps {
      // Build, TODO: change Docker to something else
      unstash 'code'
        sh "docker build -t ${repositoryName}:latest app"
        sh "docker tag ${repositoryName}:latest ${dockerImage}:${BUILD_ID}"
        sh "docker image prune -f"
      }
    }

    stage('Push to Artifactory') {
      steps{
        sh 'echo push'
        // script{
        //   docker.withRegistry("http://${dockerRepository}/${repositoryName}", 'ecr:eu-north-1:aws_cred') {
        //   docker.image("${dockerImage}").push("${BUILD_ID}")
        //   }
        }
      }
    }

    stage('Deploy to K8S') {
        when {
                branch 'production'
            }
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
