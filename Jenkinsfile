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
                    sh 'npm run build'
                }
            }
        }
