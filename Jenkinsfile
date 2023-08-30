pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: node
                    image: node:alpine
                    command:
                    - cat
                    tty: true
                  container:
                  - name: docker
                    image: docker
                    tty: true
            '''
        }
    }
    stages {
        // stage('Run node') {
        //     steps {
        //         container('node') {
        //             // sh 'npm install'
        //             sh 'npm run test:unit'
        //             // sh 'npm run build'
        //         }
        //     }
        // }
      stage('docker build'){
        steps{
          container('docker'){
            sh 'docker build -t test .'
            
          }
        }
      }
    
    }
}
podTemplate(containers: [
    containerTemplate(
        name: 'nodejs', 
        image: 'node:18', 
        command: 'sleep', 
        args: '30d'
    )
]) {
    node(POD_LABEL) {
        stage('Sonarqube Scan') {
            container('nodejs') {
                stage('Sonarqube Scan') {
                    script {
                        checkout scm
                    }
                    catchError() {
                        sh '''
                        npm install -g sonarqube-scanner
                        sonar-scanner \
                            -Dsonar.projectKey=api.identity.ciba \
                            -Dsonar.host.url=http://3.82.121.111:9000 \
                            -Dsonar.login=sqp_8da16ea24b2268e8e64d25cb3569c4a3dd2ed17f
                        '''
                    }
                }
            }
        }
    }
}
