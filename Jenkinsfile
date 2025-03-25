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
        cd ../../../monitoring
        docker build -t grafana grafana
        docker build -t prometheus prometheus
        '''
      }
    }

    stage('Push to ECR') {
      agent {
        label 'master'
      }
      steps {
        script {
          docker.withRegistry('http://585466297447.dkr.ecr.eu-north-1.amazonaws.com/webapp', 'ecr:eu-north-1:aws') {
            docker.image("webapp:${BUILD_TAG}").push("latest")
          }
        }
        sh "docker rmi webapp:${BUILD_TAG}"
      }
    }

    stage('Deploy') {
      parallel {
        stage('Software Project') {
          agent {
            label "master"
          }
          steps {
            withCredentials([usernamePassword(credentialsId: 'awspwd', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
              sh '''
             ecs-deploy -k $AWS_ACCESS_KEY_ID -s $AWS_SECRET_ACCESS_KEY -r eu-north-1 -c ruiyang_test -d spring-farget -i 585466297447.dkr.ecr.eu-north-1.amazonaws.com/webapp
              '''
            }
          }
        }
        stage('Monitoring System') {
          options {
            skipDefaultCheckout false
          }
          agent {
            label "master"
          }
          steps {
            sh '''
              docker stop $(docker ps -a -q) || true
              docker rm $(docker ps -a -q) || true
              docker network create monitoring || true
              docker run -d -p 3000:3000 --network=monitoring --name=grafana grafana
              docker run -d -p 9090:9090 --network=monitoring --name=prometheus prometheus
              '''
          }
        }
      }

    }
    stage('API Test') {
      agent {
        label 'master'
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'awspwd', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            aws lambda invoke --function-name post-deploy-test out --log-type Tail \
            --payload fileb://jenkins-utils/post-deploy-test-payload.json \
            --query 'LogResult' --output text |  base64 -d
          '''
        }
      }
    }
  }
}