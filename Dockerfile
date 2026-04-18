FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/simple-java-maven-app-1.0.jar app.jar
CMD ["java","-jar","app.jar"]
