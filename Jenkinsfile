pipeline {
  environment {
    registry = "https://hub.docker.com/repositories/ezzops"
    registryCredential = 'ezzops-dockerhub'
}
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: node
                    image: node:18
                    tty: true
                  containers:
                  - name: docker
                    image: docker:1.11
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
        stage('Checkout') {
            steps {
                git 'https://github.com/ezz444/nodeapp.git'
            }
        }
        stage('CI') {
            parallel {
                stage('npm intall') {
                    steps {
                        container('node') {
                            sh 'npm install'
                        }
                    }
                }
                stage('npm test') {
                    steps {
                        container('node') {
                            sh 'npm run test:unit'
                        }
                    }
                }
            }
        }
                stage('npm build') {
                    steps {
                        container('node') {
                            sh 'npm run build'
                        }
                    }
                }
    //             stage('docker push&build') {
    //                 steps {
    //                     container('docker') {
    //                       dockerImage = docker.build registry + ":$BUILD_NUMBER"
    //                       docker.withRegistry( '', registryCredential ) {
    //                       dockerImage.push()                          
    //                     }
    //                 }
    //             }      
    // }
    }    
    // stages {
    //     stage('Run node') {
    //         steps {
    //             container('node') {
    //                 // sh 'npm install'
    //                 // sh 'npm run test:unit'
    //                 // sh 'npm run build'
    //                 sh 'echo hello'                  
    //             }
    //         }
    //     }
    // stage('Building image') {
    //   steps{
    //     container('docker') {
    //     script {
    //       dockerImage = docker.build registry + ":$BUILD_NUMBER"
    //     }
    //   }=
    // }
    // stage('Deploy Image') {
    //   steps{
    //     script {
    //       docker.withRegistry( '', registryCredential ) {
    //         dockerImage.push()
    //       }
    //     }
    //   }
    // }
    // }
    // }
  
  
  
}
// podTemplate(containers: [
//     containerTemplate(
//         name: 'docker', 
//         image: 'docker', 
//         command: 'sleep', 
//         args: '30d'
//       )
//     containerTemplate(
//         name: 'nodejs', 
//         image: 'node:18', 
//         command: 'sleep', 
//         args: '30d'
//     )    
  
  
// ]) {
//     node(POD_LABEL) {
//         stage('docker build&push') {
//             container('docker') {
//                 stage('docker build') {
//         script {
//           dockerImage = docker.build registry + ":$BUILD_NUMBER"
//         }                  

//                 }
//             }
//         }
//     }
//     node(POD_LABEL) {
//         stage('Sonarqube Scan') {
//             container('nodejs') {
//                 stage('Sonarqube Scan') {
//                     script {
//                         checkout scm
//                     }
//                     catchError() {
//                         sh '''
//                         npm install -g sonarqube-scanner
//                         sonar-scanner \
//                             -Dsonar.projectKey=api.identity.ciba \
//                             -Dsonar.host.url=http://3.82.121.111:9000 \
//                             -Dsonar.login=sqp_8da16ea24b2268e8e64d25cb3569c4a3dd2ed17f
//                         '''
//                     }
//                 }
//             }
//         }
//     }  
// }
// pipeline {
//     agent {
//         kubernetes {
//             label 'jx-maven-lib'
//             yaml """
// apiVersion: v1
// kind: Pod
// spec:
//   containers:
//   - name: maven11
//     image: maven:3-jdk-11
//     command: ['cat']
//     tty: true
//   - name: maven13
//     image: maven:3-jdk-13
//     command: ['cat']
//     tty: true
// ---

// """
//         }
//     }
//     stages {
//         stage('Checkout') {
//             steps {
//                 git 'https://github.com/joostvdg/jx-maven-lib.git'
//             }
//         }
//         stage('Run Tests') {
//             parallel {
//                 stage('Java 11') {
//                     steps {
//                         container('maven11') {
//                             sh 'mvn -V -e -C verify'
//                         }
//                     }
//                 }
//                 stage('Java 13') {
//                     steps {
//                         container('maven13') {
//                             sh 'mvn -V -e -C -Pjava13 verify'
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }
