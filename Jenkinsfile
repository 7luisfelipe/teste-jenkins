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

        stage('Run Docker Container') {
            steps {
                script {
                    // Rodando o container
                    sh 'docker run -d --name ${DOCKER_CONTAINER} -p 8081:8081 ${DOCKER_IMAGE}:${DOCKER_TAG}'

                    // Esperar o container iniciar (adicionar uma pausa se necessário)
                    //sleep 10
                }
            }
        }

        stage('Test API') {
            steps {
                script {
                    //Teste simples para verificar se o endpoint está funcionando
                    //sh 'curl -f http://localhost:8081/hello'

                    // Aguardando um tempo maior para garantir que o container iniciou
                    //sleep 20
                    // Teste simples para verificar se o endpoint está funcionando
                    //sh '''
                        //if ! curl -f http://localhost:8081/hello; then
                            //echo "Failed to connect to service. Checking container logs..."
                            //docker logs ${DOCKER_CONTAINER}
                            //exit 1
                        //fi
                    //'''

                    // Aumentar o tempo de espera para garantir que o Spring Boot tenha tempo suficiente para iniciar
                    sleep(time: 30, unit: 'SECONDS')
                    try {
                        sh 'curl -f http://localhost:8081/hello'
                    } catch (Exception e) {
                        echo "Falha ao se conectar o sever. buscando logs do container..."
                        sh "docker logs ${DOCKER_CONTAINER}"
                        error "Teste de API falhou"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Limpa os arquivos de trabalho após a execução
        }
    }
}
