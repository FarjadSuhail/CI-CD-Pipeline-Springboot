# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Install bash (since the slim image may not include it) and dos2unix to fix line endings
RUN apt-get update && apt-get install -y bash dos2unix

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper and project files
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Fix any line ending issues with mvnw and ensure it is executable
RUN dos2unix mvnw && chmod +x mvnw

# Verify the mvnw permissions
RUN ls -l mvnw

# Resolve dependencies
RUN ./mvnw dependency:resolve

# Copy the project source
COPY src ./src

# Package the application
RUN ./mvnw package -DskipTests

# Expose the port that the application runs on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "./target/greetings-0.0.1-SNAPSHOT.jar"]
