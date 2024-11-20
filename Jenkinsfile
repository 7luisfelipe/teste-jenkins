pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-api-image"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                //checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                script {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Aqui você pode configurar para enviar a imagem para um repositório como Docker Hub ou AWS ECR
                    // Exemplo:
                    // sh 'docker push ${DOCKER_IMAGE}:${DOCKER_TAG}'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Rodar o container
                    sh 'docker run -d -p 8080:8080 ${DOCKER_IMAGE}:${DOCKER_TAG}'
                }
            }
        }

        stage('Test API') {
            steps {
                script {
                    // Teste simples para verificar se o endpoint está funcionando
                    sh 'curl -f http://localhost:8080/hello'
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Limpar arquivos de trabalho
        }
    }
}
