pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'Node23'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'local', credentialsId: 'github', url: 'https://github.com/hawk-H97/jenkins-method'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh "npm -v"
            }
        }
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage("Sonarqube Analysis ") {
            steps{
                withSonarQubeEnv('sonarqube-custom') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=barber \
                    -Dsonar.projectKey=barber '''
                }
            }
        }
        stage("Build Docker image") {
            steps {
                sh 'docker build -t barber:1.0 .'
            }
        }
        stage('TRIVY Scan') {
            steps {
                sh "trivy --no-progress --exit-code 1 --severity HIGH,CRITICAL barber:1.0"
            }
        }
    }
    post {
        always {
            cleanWs()  // Optional: Clean workspace after build
        }
    }
}
