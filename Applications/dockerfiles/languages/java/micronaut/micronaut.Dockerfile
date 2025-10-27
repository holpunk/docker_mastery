from openjdk:17-jdk-slim
WORKDIR /app
COPY .. /app
RUN ./mvnw package
EXPOSE 8080
CMD ["java", "-jar", "target/micronaut-app-0.1.jar"]
