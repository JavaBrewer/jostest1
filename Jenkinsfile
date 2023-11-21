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
                script {
                    sh './gradlew clean build'
                }
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
                script {
                    // 'sh'를 통해 노드 내에서 실행
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    // 'sh'를 통해 노드 내에서 실행
                    sh 'docker push $repository:$BUILD_NUMBER'
                }
            }
        }
    }
    post {
        always {
            script {
                // 'sh'를 통해 노드 내에서 실행
                sh 'docker logout'
            }
        }
    }
}
