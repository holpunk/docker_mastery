# Stage 1: Build the native executable
FROM quay.io/quarkus/ubi-quarkus-mandrel:23.0-java17 AS builder

# Copy source code
COPY --chown=quarkus:quarkus mvnw pom.xml ./
COPY --chown=quarkus:quarkus .mvn ./.mvn
COPY --chown=quarkus:quarkus src ./src

# Switch to the quarkus user
USER quarkus

# Build the native executable
# The -Dquarkus.native.container-build=true flag is important
# It tells Quarkus to build the native executable inside a container
RUN mvn package -Pnative -Dquarkus.native.container-build=true -DskipTests

# Stage 2: Create the minimal runtime image
FROM quay.io/quarkus/quarkus-micro-image:1.0

WORKDIR /work/

# Copy the native executable from the builder stage
COPY --from=builder /home/quarkus/target/*-runner /work/application

# Set permissions and expose port
RUN chmod 775 /work/application
EXPOSE 8080

# Set the command to run the application
# The -Dquarkus.http.host=0.0.0.0 allows the app to be accessible from outside the container
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]

# Healthcheck to ensure the application is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/q/health || exit 1
