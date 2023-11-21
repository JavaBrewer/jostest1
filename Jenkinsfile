pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        repository = "latte04/testjog"
        dockerImage = ''
    }
    stages {
        stage('Gradle Build') {
            steps {
                sh './gradlew clean build'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build repository + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push') {
            steps {
                sh 'docker push $repository:$BUILD_NUMBER'
            }
        }
    }
    post {
        always {
            script {
                // 'docker logout'를 노드 내에서 실행
                sh 'docker logout'
            }
        }
    }
}
