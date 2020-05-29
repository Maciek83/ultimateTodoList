FROM maven:3.6.3-adoptopenjdk-11
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean package
RUN mkdir /shareddata