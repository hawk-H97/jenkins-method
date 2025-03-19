pipeline {
    agent{
        node {
            label 'test_node'
        }
    }
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
                script {
                    echo "Scanning Docker image ${barber:1.0} for vulnerabilities..."
                    sh """
                        trivy image --severity CRITICAL,HIGH ${barber:1.0}
                    """
                }
            }
            post {
               always {
                   echo "Trivy image scanning completed."
        }
        }
    }
}
