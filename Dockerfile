# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Maven Wrapper scripts and Maven configuration
COPY mvnw ./
COPY .mvn .mvn

# Make the Maven Wrapper script executable
RUN chmod +x mvnw

# Copy the Maven project file
COPY pom.xml ./

# Download dependencies (to leverage Docker cache)
RUN ./mvnw dependency:resolve

# Copy the project source code
COPY src ./src

# Package the application
RUN ./mvnw package -DskipTests

# Expose the port that the application runs on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "./target/greetings-0.0.1-SNAPSHOT.jar"]