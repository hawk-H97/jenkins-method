pipeline {
    agent {
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

        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube-custom') {
                    sh '''
                        $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=barber \
                        -Dsonar.projectKey=barber
                    '''
                }
            }
        }

        stage('TRIVY FS Scan') {
            steps {
                    sh "trivy fs .>trivyfs.txt"
                  }
        }

        stage('Docker Build & Push') {
            steps {
               script{
                withDockerRegistry(credentialsId:'docker',toolName: 'docker'){
                    sh "docker build -t barber1.0 ."
                    sh "docker tag barber1.0 pragadesh007/barber1.0:latest"
                    sh "dokcer push pragadesh007/barber1.0:latest"
                }
               }
            }
        }

        stage("TRIVY"){
            steps{
                sh "trivy image pragadesh007/barber1.0:latest>trivy.txt"
            }
        }

        stage("Deploy to container"){
            steps{
                sh 'docker run -d --name barber1.0 -p 3000:3000 pragadesh007/barber1.0:latest'
            }
        }
    }
}