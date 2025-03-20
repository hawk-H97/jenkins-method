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

        stage('Verify SonarQube Results') {
            steps {
                script {
                    echo "Pipeline paused for manual verification of SonarQube results."
                    echo "Check SonarQube dashboard at: http://65.0.74.158:9000/dashboard?id=barber"

                    def userChoice = input message: 'SonarQube analysis complete. Review vulnerabilities and approve to continue.',
                                    ok: 'Approve',
                                    parameters: [
                                        choice(name: 'ACTION', choices: ['Continue', 'Abort'], description: 'Select an action')
                                    ]

                    if (userChoice == 'Abort') {
                        error "Pipeline aborted by user after SonarQube review."
                    } else {
                        echo "Pipeline approved. Continuing..."
                    }
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
                withDockerRegistry(credentialsId:'Docker',toolName: 'docker-latest'){
                    sh "docker build -t barber1.0 ."
                    sh "docker tag barber1.0 pragadesh007/barber1.0:latest"
                    sh "docker push pragadesh007/barber1.0:latest"
                }
               }
            }
        }

        stage("TRIVY Image Scan"){
            steps{
                sh "trivy image pragadesh007/barber1.0:latest>trivy.txt"
            }
        }

        stage("Deploy to docker container"){
            steps{
                sh 'docker run -d --name barber1.0 -p 3000:80 pragadesh007/barber1.0:latest'
            }
        }
    }
}