pipeline {
    agent any
    environment {
        GRADLE_USER_HOME = "${workspace}/.gradle"
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
                        // Gradle 빌드 및 SonarQube 분석 수행
                        sh './gradlew clean build sonarqube'
                    }
                }
            }
        }
    }
}
