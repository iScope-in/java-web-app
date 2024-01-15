FROM ubuntu:latest

MAINTAINER Nihar Paital < niharp.india@gmail.com>

RUN mkdir -p /project


RUN apt-get update
RUN apt-get install -y tree git openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /project
RUN git clone https://github.com/iScope-in/java-web-app.git

# Install maven and configure
ADD https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz .
RUN tar -zxf apache-maven-3.9.6-bin.tar.gz
RUN mv apache-maven-3.9.6 maven
RUN rm apache-maven-3.9.6-bin.tar.gz

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz .
RUN tar -zxf apache-tomcat-9.0.84.tar.gz
RUN mv apache-tomcat-9.0.84 tomcat
RUN rm apache-tomcat-9.0.84.tar.gz

ENV M2_HOME /project/maven
ENV M2 /project/maven/bin
ENV CATALINA_HOME /project/tomcat
ENV PATH $PATH:$JAVA_HOME:$M2_HOME:$M2:$CATALINA_HOME/bin

WORKDIR /project/java-web-app
RUN /project/maven/bin/mvn clean package

RUN cp /project/java-web-app/target/welcomeapp.war /project/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# WORKDIR /project/tomcat/bin
# Set the default command to run Tomcat
ENTRYPOINT ["catalina.sh", "run"]
