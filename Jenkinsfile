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
    
    stage('Push to ECR') {
                    agent {
                label 'master'
            
        }
      steps{
        script{
              docker.withRegistry('http://585466297447.dkr.ecr.eu-north-1.amazonaws.com/webapp', 'ecr:eu-north-1:aws') {
              docker.image("webapp:${BUILD_TAG}").push("latest")
              }
            }
            sh "docker rmi webapp:${BUILD_TAG}"
    }

    }

  stage('Deploy') {
                  agent {
                label 'master'
            
        }
        when {
                branch 'master'
            }
      steps {
        withCredentials([usernamePassword(credentialsId: 'awspwd', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
           ecs-deploy -k $AWS_ACCESS_KEY_ID -s $AWS_SECRET_ACCESS_KEY -r eu-north-1 -c ruiyang_test -d spring-farget -i 585466297447.dkr.ecr.eu-north-1.amazonaws.com/webapp
          '''
        }
      }
    }
      stage('Intergration test') {
        agent {
                label 'master'
            
        }
      steps {
        withCredentials([usernamePassword(credentialsId: 'awspwd', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh '''
            aws lambda invoke --function-name post-deploy-test out --log-type Tail \
            --payload fileb://jenkins-utils/post-deploy-test-payload.json \
            --query 'LogResult' --output text |  base64
          '''
        }
      }
    }
    }

  }
