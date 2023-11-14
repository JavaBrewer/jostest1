pipeline {
    agent any

    environment {
        GRADLE_HOME = tool 'Gradle' // Jenkins에 등록된 Gradle 도구 사용
        PATH = "$GRADLE_HOME/bin:$PATH"
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
