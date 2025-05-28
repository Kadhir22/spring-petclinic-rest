# Use Maven 3.9.9 (or newer) for build
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy project files
COPY . .

# Build the project (skip tests for speed)
RUN mvn clean package -DskipTests

# Use a minimal Java image for runtime
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose backend port
EXPOSE 9966

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
