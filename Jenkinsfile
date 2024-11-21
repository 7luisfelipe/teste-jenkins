pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-api-image"
        DOCKER_CONTAINER = "my-api-container"
        DOCKER_TAG = "latest"
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

        stage('Build Docker Image') {
            steps {
                script {
                    // Remover container em execução previamente
                    sh '''
                        if [ $(docker ps -q -f name=${DOCKER_CONTAINER}) ]; then
                            docker stop ${DOCKER_CONTAINER}
                            docker rm ${DOCKER_CONTAINER}
                        fi
                    '''

                    // Construindo a imagem Docker a partir do Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }

        //stage('Push Docker Image') {
            //steps {
                //script {
                    // Este passo é opcional. Caso queira enviar a imagem para um repositório (ex: Docker Hub)
                    // sh 'docker push ${DOCKER_IMAGE}:${DOCKER_TAG}'
                //}
            //}
        //}

        stage('Run Docker Compose') {
            steps {
                script {
                    // Inicia os containers usando Docker Compose
                    sh "docker-compose -f ${DOCKER_COMPOSE_FILE} up -d"

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
        //failure {
            // Enviar um e-mail ou realizar outra ação em caso de falha
            //mail to: 'you@example.com',
                //subject: "Pipeline failed",
                //body: "The pipeline failed during the test stage."
        //}
    }
}
