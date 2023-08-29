pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: sonarqube
                    image: sonarqube
                    command:
                    - cat
                    tty: true
                ---
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: node
                    image: node:alpine
                    command:
                    - cat
                    tty: true
            '''
        }
    }
    stages {
        stage('Run node') {
            steps {
                container('node') {
                    sh 'npm install'
                    sh 'npm run test:unit'
                    sh 'npm build'
                }
            }
        }
        stage('Run sonarqube') {
            agent {
                tools {
                    maven 'MavenInstallationName' // Specify the actual Maven installation name
                }
            }
            steps {
                container('sonarqube') {
                    sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                }
            }
        }
    }
}
