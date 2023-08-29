podTemplate(containers: [
    containerTemplate(name: 'maven', image: 'maven:3.8.1-jdk-8', command: 'sleep', args: '99d'),
    containerTemplate(name: 'node', image: 'node', command: 'sleep', args: '99d'),
    containerTemplate(name: 'sonarqube', image: 'sonarqube', command: 'sleep', args: '99d')
  
  ]) {
    stages {
        stage('Run node') {
            steps {
                container('node') {
                    sh 'npm install'
                    sh 'npm run test:unit'
                    sh 'npm run build'
                }
            }
        }
        stage('Run sonarqube') {
            steps {
                container('sonarqube') {
                    sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                }
            }
        }
    }
}
