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
                        sh 'chmod +x gradlew' // Gradle Wrapper에 실행 권한 추가
                        sh './gradlew clean build sonarqube'
                    }
                }
            }
        }
    }
}
