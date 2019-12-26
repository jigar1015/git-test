FROM gradle:4.7.0-jdk8-alpine AS build
COPY . /app
WORKDIR /app
USER root
RUN ./gradlew clean build 

FROM openjdk:8-jre-slim
RUN mkdir /app
COPY --from=build /app/build/libs/*.jar /app/spring-boot-application.jar
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-boot-application.jar"]
EXPOSE 8080