# Etapa 1: Construcción
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY ../.. .
RUN mvn clean package -DskipTests

# Etapa 2: Ejecución
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copiamos el JAR construido desde la etapa 1
COPY --from=builder /app/target/*.jar app.jar

# Render asigna un puerto dinámico → se expone con ENV
ENV PORT=8080

# Levantamos la app
CMD ["java", "-jar", "app.jar"]
