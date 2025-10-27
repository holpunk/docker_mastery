# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
# The source path is relative to the build context (repository root)
COPY ./application_source_code/springboot/pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY ./application_source_code/springboot/src ./src

# Package the application
RUN mvn package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the executable jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java","-jar","app.jar"]

