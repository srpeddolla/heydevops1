FROM maven:3.8.1-jdk-11-slim AS build
 WORKDIR /app
 COPY pom.xml .
 RUN mvndependency:go-offline
 COPY src/ src/
 RUN mvnpackage