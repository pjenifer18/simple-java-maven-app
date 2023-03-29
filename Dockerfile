FROM docker.io/library/openjdk:11-slim
RUN apt-get update -y
RUN apt-get install maven -y
WORKDIR /opt
COPY . .
RUN mvn -B -DskipTests clean package
RUN ./target
CMD ["java", "-jar" , "./target/my-app-1.0-SNAPSHOT.jar"]