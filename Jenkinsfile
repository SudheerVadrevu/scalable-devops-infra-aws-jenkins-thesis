pipeline {
        agent {
                        ecs {
                inheritFrom 'ecs'
            }
            
        }
  environment {
    BUILD_TAG = "${env.BUILD_TAG}"
  }

  options {
    timeout(time: 20, unit: 'MINUTES')
    skipDefaultCheckout true
  }

  stages {  
    stage('Checkout') {

      steps {
        checkout scm
      }
    }
  
    stage('Build') {
      steps {
        sh '''
        ./scripts/gradle_build.sh
        '''
        stash includes: 'app/build/libs/**/*.jar', name: 'jar' 
        stash includes: 'docker-images/spring-boot-web-app/Dockerfile', name: 'docker'
      }
    }

    stage('Build docker image') {
            agent {
                label 'master'
            
        }
      steps {
      unstash 'jar'
      unstash 'docker'
      sh '''
        cp docker-images/spring-boot-web-app/Dockerfile app/build/libs
        cd app/build/libs
        docker build -t webapp:$BUILD_TAG .
      '''
      }
    }
    
    stage('Push to Artifactory') {
                    agent {
                label 'master'
            
        }
      steps{
        script{
              docker.withRegistry('http://585466297447.dkr.ecr.eu-north-1.amazonaws.com/webapp', 'ecr:eu-north-1:aws') {
              docker.image("webapp:${BUILD_TAG}").push("${BUILD_ID}")
              }
            }
            sh "docker rmi webapp:${BUILD_TAG}"
    }

    }

  stage('Deploy to K8S') {
                  agent {
                label 'master'
            
        }
        // when {
        //         branch 'master'
        //     }
      steps {
        withCredentials([usernamePassword(credentialsId: 'awspwd', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
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
