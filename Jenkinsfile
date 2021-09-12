pipeline {
    agent any
    stages {
        stage ('Build Backend'){
            steps{
                bat 'mvn clean package -DskipTests=true'
            }
            
        }
        stage ('Unit Tests'){
            steps{
                bat 'mvn test'
            }
        }
        stage ('Sonar Analysis'){
            environment{
                scannerHome = tool 'SONAR_SCANNER'
            }
            steps{
                withSonarQubeEnv('SONAR_LOCAL'){
                 bat "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://localhost:9000 -Dsonar.login=f8432011ce73aae9e820ad344ec72d9dde140a02 -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"
                }
            }
        }

        stage ('Quality Gate'){
            steps{
                sleep(30)
                timeout(time: 1, unit: 'MINUTES'){
                    waitForQualityGate abortPipeline: true
                }
                
            }
        }

        stage ('Deploy Backend'){
            steps{
                deploy adapters: [tomcat8(credentialsId: 'LoginTomCat', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks-backend', war: 'target/tasks-backend.war'
                }
                
            }
        stage ('API Test'){
            steps{
                dir('api-test'){
                git 'https://github.com/raquelroque/tasks-api-test-integacao'
                bat 'mvn test'
                }
            }
        }
         stage ('Deploy Frontend'){
            steps{
                dir('frontend'){
                    git 'https://github.com/raquelroque/tasks-frontend'
                    bat 'mvn clean package'
                    deploy adapters: [tomcat8(credentialsId: 'LoginTomCat', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks', war: 'target/tasks.war'
                }
            }         
        }
        stage ('Functional Test'){
            steps{
                dir('functional-test'){
                git credentialsId: 'GitLogin', url: 'https://github.com/raquelroque/tasks-functional-tests'
                bat 'mvn test'
                }
            }
        }
        stage ('Deploy Prod'){
            steps{
                bat 'docker-compose build'
                //-d libera o terminal
                bat 'docker-compose up -d'
                }
            }
    }
}




