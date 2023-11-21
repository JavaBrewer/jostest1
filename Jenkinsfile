pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        repository = "latte04/testjog"
        dockerImage = ''
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

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
                    dockerImage = docker.build(repository + ":$BUILD_NUMBER")
                }
            }
        }

        stage('Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                        sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    }
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    sh "docker push $repository:$BUILD_NUMBER"
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
