# syntax=docker/dockerfile:1

# ---- Build stage: compile, test and package with Maven ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build

# Resolve dependencies first so this layer stays cached while only sources change
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B package && ls -la target

# ---- Runtime stage: slim JRE only ----
FROM eclipse-temurin:17-jre
WORKDIR /app

# Run as an unprivileged user instead of root
RUN groupadd --system app && useradd --system --gid app --no-create-home app

COPY --from=build /build/target/ci-cd-uebung-1.0.0.jar /app/app.jar
USER app

# The JAR has no Main-Class manifest entry, so start the main class via the classpath
ENTRYPOINT ["java", "-cp", "/app/app.jar", "com.example.cicd.App"]
