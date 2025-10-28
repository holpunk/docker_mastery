# Use Maven image for build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven descriptor
COPY pom.xml .

# Copy source code (path is relative to build context)
COPY src ./src

# Resolve dependencies
RUN mvn -B -q dependency:go-offline

# Build the application
RUN mvn -B -q package -DskipTests

# Runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
