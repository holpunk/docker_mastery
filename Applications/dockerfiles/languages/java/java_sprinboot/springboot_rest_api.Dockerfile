from openjdk:latest
WORKDIR /app
COPY .. /app



RUN ./mvnw package
EXPOSE 8080
CMD ["java", "-jar", "target/*.jar"]
