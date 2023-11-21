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
        stage('Gradle Build') {
            steps {
                script {
                    // Change to the directory where your gradlew script is located
                    dir('path/to/your/project') {
                        sh './gradlew clean build'
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build("${repository}:${BUILD_NUMBER}")
                }
            }
        }
        stage('Login') {
            steps {
                script {
                    sh "echo \${DOCKERHUB_CREDENTIALS_PSW} | docker login -u \${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    sh "docker push ${repository}:${BUILD_NUMBER}"
                }
            }
        }
    }
    post {
        always {
            script {
                sh 'docker logout'
            }
        }
    }
}
