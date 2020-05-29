FROM tomcat:8.5.55-jdk11-openjdk
COPY ./tomd/server.xml /usr/local/tomcat/conf/
ADD http://www.mirrorservice.org/sites/ftp.mysql.com/Downloads/Connector-J/mysql-connector-java-8.0.20.tar.gz /usr/local/tomcat
RUN tar -xvf mysql-connector-java-8.0.20.tar.gz
RUN mv /usr/local/tomcat/mysql-connector-java-8.0.20/mysql-connector-java-8.0.20.jar /usr/local/tomcat/lib
RUN mkdir /shareddata