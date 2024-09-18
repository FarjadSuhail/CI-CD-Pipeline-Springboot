# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Install bash (since the slim image may not include it)
RUN apt-get update && apt-get install -y bash

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper and project files
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Ensure mvnw has execute permissions
RUN chmod +x mvnw

# Resolve dependencies (ensure correct line endings in mvnw)
RUN ./mvnw dependency:resolve

# Copy the project source
COPY src ./src

# Package the application
RUN ./mvnw package -DskipTests

# Expose the port that the application runs on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "./target/greetings-0.0.1-SNAPSHOT.jar"]
