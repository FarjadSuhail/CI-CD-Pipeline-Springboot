
# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project file and download dependencies (to leverage Docker cache)
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn
RUN ./mvnw dependency:resolve

# Copy the project source
COPY src ./src

# Package the application
RUN ./mvnw package -DskipTests

# Expose the port that the application runs on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "./target/greetings-0.0.1-SNAPSHOT.jar"]
