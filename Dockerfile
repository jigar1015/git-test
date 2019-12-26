FROM gradle:4.7.0-jdk8-alpine
COPY . /app
WORKDIR /app
USER root
RUN ./gradlew clean build 
COPY /app/build/libs/*.jar /app/
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/gradle-example-0.0.2-SNAPSHOT.jar"]
EXPOSE 8080