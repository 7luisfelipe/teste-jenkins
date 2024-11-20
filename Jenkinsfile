pipeline {
    agent any

    environment {
        // Nome da imagem Docker para identificar o contêiner
        IMAGE_NAME = "hello-jenkins-api"
    }

    stages {
        stage('Checkout') {
            steps {
                //auth
                git branch: 'main',
                    url: 'https://github.com/7luisfelipe/teste-jenkins',
                    credentialsId: 'token_git'
                // Clonar o repositório
                git url: 'https://github.com/7luisfelipe/teste-jenkins', branch: 'main'
            }
        }
        stage('Build with Maven') {
            steps {
                // Rodar Maven para construir o artefato
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                // Construir a imagem Docker
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        stage('Run Docker Container') {
            steps {
                // Remover contêiner anterior (se existir) e rodar um novo
                sh """
                docker rm -f hello-jenkins || true
                docker run -d --name hello-jenkins -p 8080:8080 ${IMAGE_NAME}
                """
            }
        }
    }

    post {
        always {
            // Mostrar o status do contêiner para fins de debug
            sh 'docker ps -a'
        }
    }
}

