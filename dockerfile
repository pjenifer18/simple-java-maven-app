FROM docker.io/library/openjdk:8-slim
RUN apt-get update -y
RUN apt-get install maven -y
WORKDIR /opt
COPY . .
RUN mvn -B -DskipTests clean package
RUN ./target
CMD ["java", "-jar" , "./target/gs-maven-0.1.0.jar"]