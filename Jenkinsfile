pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                script {
                    // Rodando o Maven para compilar o projeto e criar o JAR
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    // Inicia os containers e constrói a imagem se necessário
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up --build -d"

                    // Espera o container iniciar (adicionar uma pausa, se necessário)
                    sleep(time: 30, unit: 'SECONDS')
                }
            }
        }

        stage('Test API') {
            steps {
                script {
                    try {
                        // Teste simples para verificar se o endpoint está funcionando
                        sh 'curl -v -f http://localhost:8081/hello'
                        echo 'API test passed'
                    } catch (Exception e) {
                        echo "Falha ao se conectar ao servidor. Buscando logs do container..."
                        sh "docker logs ${DOCKER_CONTAINER}"
                        error "Teste de API falhou"
                    }
                }
            }
        }
    }

    post {
        always {
            // Limpa os arquivos de trabalho após a execução
            cleanWs()

            // Parar e remover o container usando Docker Compose
            sh "docker-compose -f ${DOCKER_COMPOSE_FILE} down"
        }
    }
}
