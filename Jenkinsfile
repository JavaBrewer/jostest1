pipeline {
    agent any

    environment {
        GRADLE_USER_HOME = "${workspace}/.gradle"
        DOCKER_IMAGE_TAG = "latest" // 가상의 태그
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github_access_token',
                    url: 'https://github.com/JavaBrewer/jostest1.git'
            }
        }
        stage("Build & SonarQube Analysis") {
            steps {
                withSonarQubeEnv('SonarQube_server') {
                    script {
                        sh 'chmod +x gradlew'
                        sh './gradlew clean build sonarqube'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Docker 이미지 빌드
                    docker.build("java-brewer/jostest1:${DOCKER_IMAGE_TAG}")
                }
            }
        }
    }
}
