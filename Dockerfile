#FROM openjdk:17-jdk-slim
#COPY target/hello-jenkins-1.0-SNAPSHOT.jar app.jar
#ENTRYPOINT ["java", "-jar", "/app.jar"]

# Use a imagem do OpenJDK como base
FROM openjdk:17-jdk-slim

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo JAR para o contêiner
COPY target/testjenkins-0.0.1-SNAPSHOT.jar app.jar

# Exponha a porta 8080
EXPOSE 8081

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
