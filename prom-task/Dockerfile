FROM openjdk:17

WORKDIR /app
COPY ./target/spring-petclinic-3.1.0.jar /app
COPY config.yaml /app
COPY jmx_prometheus_javaagent-0.19.0.jar /app
EXPOSE 12345
EXPOSE 8080
CMD ["java", "-javaagent:jmx_prometheus_javaagent-0.19.0.jar=12345:config.yaml", "-jar", "spring-petclinic-3.1.0.jar"]

