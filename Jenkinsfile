pipeline {
  environment {
        DOCKERHUB_CREDENTIALS = credentials('ezzops-dockerhub')
  }
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: docker
                    image: docker
                    command:
                    - cat
                    tty: true
                    volumeMounts:
                    - name: dockersock
                      mountPath: /var/run/docker.sock
                  volumes:
                  - name: dockersock
                    hostPath:
                      path: /var/run/docker.sock
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
            sh 'apk add git'
            sh 'git clone https://github.com/ezz444/nodeapp.git'
            sh 'docker build -t ezzops/test:$BUILD_NUMBER nodeapp/.'
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            sh 'docker push ezzops/test:$BUILD_NUMBER'
            
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
                            -Dsonar.login=sqp_e05fac7df977b94dacbe2ced62d23ae72b425708
                        '''
                    }
                }
            }
        }
    }
}
