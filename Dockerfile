FROM openjdk:17-jdk-slim
COPY target/hello-jenkins-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
