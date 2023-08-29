podTemplate(containers: [
    containerTemplate(name: 'maven', image: 'maven:3.8.1-jdk-8', command: 'sleep', args: '99d'),
    containerTemplate(name: 'node', image: 'node:18', command: 'sleep', args: '99d'),
   containerTemplate(name: 'sonaqube', image: 'sonarqube', command: 'sleep', args: '99d')

  ]) {

    node(POD_LABEL) {
        stage('Get a node project') {
            container('node') {
                stage('Build a node project') {
                    sh 'npm install'
                    sh 'npm run test:unit'
                    sh 'npm run build'
                }
            }
        }

        stage('Get a Golang project') {
            container('sonaqube') {
                stage('Build a sonarqube project') {
                    sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                }
            }
        }

    }
}
