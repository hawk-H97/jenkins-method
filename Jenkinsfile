pipeline {
    agent any
    tools {
        jdk 'jdk17'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'  // Correctly set SCANNER_HOME
    }
    stages {
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/hawk-H97/jenkins-method'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool name: 'sonar-scanner'  // Ensure 'sonar-scanner' is configured in Jenkins Global Tool Configuration
                    withSonarQubeEnv('sonarqube-custom') {  // Ensure 'sonarqube-custom' is configured in Jenkins
                        sh """
                        $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=barber \
                        -Dsonar.projectKey=barber
                        """
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()  // Optional: Clean workspace after build
        }
    }
}
