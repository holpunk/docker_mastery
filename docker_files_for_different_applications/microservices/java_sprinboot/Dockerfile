# file to build a docker image for a java springboot application which exposes port 8080 and healthchecks
#add some of the environmental variables to the dockerfiles to be used in the application

FROM openjdk:17-jdk-slim
#user 198
USER 198
# Set environment variables
ENV JAVA_OPTS="-Xmx512m -Xms256m" \
    SPRING_PROFILES_ACTIVE=prod \
    SPRING_APPLICATION_NAME=my-springboot-app \
    SERVER_PORT=8080
# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
# Set the timezone to UTC
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Create a non-root user to run the application
RUN useradd -ms /bin/bash appuser
# Switch to the non-root user
USER appuser

# Set the working directory in the container
WORKDIR /app

# Copy the jar file into the container
COPY target/*.jar app.jar
# Expose the port the app runs on
EXPOSE 8080
# Set the command to run the jar file
CMD ["java", "-jar", "app.jar"]
# Healthcheck to ensure the application is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

