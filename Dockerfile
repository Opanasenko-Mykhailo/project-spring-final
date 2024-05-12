FROM maven:3.8.4-amazoncorretto-17 as build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

RUN mv target/JiraRush.jar /app/JiraRush.jar

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/JiraRush.jar /app/

COPY ./resources /app/resources
COPY ./config /app/config

EXPOSE 8080

CMD ["java", "-jar", "JiraRush.jar"]
