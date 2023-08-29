pipeline {	
	agent any
      environment {
        HOME = '.'
        // npm_config_cache = 'npm-cache'
        // DOCKERHUB_CREDENTIALS = credentials('omarelzahar-dockerhub')
        // registry = "omarelzahar/gold"
        // registryCredential = 'omarelzahar-dockerhub'
        // dockerImage = ''
    }
    stages {	
        stage("install dependencies") {	
            steps {	
                sh 'npm remove node_modules'
                sh 'npm remove package-lock.json'
                sh 'npm -v' // sanity check
                sh 'npm install'
            }	
        }	
        stage(" "){
          parallel {
            stage("Test") {
              steps {
                sh 'npm run  test:unit'
              }
            }
            
        stage("Build") {
              steps {
                sh 'npm run build'
              }
            }
        }
      }	
        //stage('Scan') {
        //  steps {
        //    withSonarQubeEnv(installationName: 'SonarServer1') { 
        //      sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
        //    }
        //  }
        // }
      stage('Login to Docker Hub') {         
        steps{                            
        	sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                 
        	echo 'Login Completed'                
          }           
        }  
      stage('Building image') {
        steps{
          script {
            dockerImage = docker.build registry + ":$BUILD_NUMBER"
              }
            }
          }
      stage('Deploy Image') {
        steps{
           script {
              docker.withRegistry( '', registryCredential ) {
              dockerImage.push()
            }
          }
        }
      }
    }	
}
