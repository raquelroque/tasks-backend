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
            enviroment{
                scannerHome = tool 'SONAR_SCANNER'
            }
            steps{
                withSonarQubeEnv('SONAL_LOCAL')
                bat "${scannerHome}/bin/sonar-scanner  -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://localhost:9000 -Dsonar.login=bde9e88ef3c5644f616944c4dd20471b9050b5b8 -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"
            }
        }
    }
}



