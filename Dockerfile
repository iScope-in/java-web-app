# Example of a complex Dockerfile: Create a Dockerfile for deployment of java web application starting from installing all the dependency softwares till running the webapp so that, it can be accessible through browser.
# Download ubuntu as a base image
FROM ubuntu:latest
MAINTAINER Nihar Paital < niharp.india@gmail.com>

# Creating Project base directory
RUN mkdir -p /project

# Update all local packages from the configured repositories
#Package Index Updates: The package manager relies on a local cache of available packages on the system. Running apt-get update refreshes this cache, making sure that the information about the latest	versions of packages is available.
#Dependency Resolution: When you subsequently install packages using apt-get install, the package manager uses the updated package index to resolve dependencies and install the correct versions of packages.
RUN apt-get update

# Install Java and setup
RUN apt-get install -y tree git openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install tomcat and configure
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz .
RUN tar -zxf apache-tomcat-9.0.84.tar.gz
RUN mv apache-tomcat-9.0.84 tomcat
RUN rm apache-tomcat-9.0.84.tar.gz

# Install maven and configure
ADD https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz .
RUN tar -zxf apache-maven-3.9.6-bin.tar.gz
RUN mv apache-maven-3.9.6 maven
RUN rm apache-maven-3.9.6-bin.tar.gz

# Environment variables setup for required executable to run
ENV M2_HOME /project/maven
ENV M2 /project/maven/bin
ENV CATALINA_HOME /project/tomcat
ENV PATH $PATH:$JAVA_HOME:$M2_HOME:$M2:$CATALINA_HOME/bin

# Downloading Project sourcecode from GitHub
WORKDIR /project
RUN git clone https://github.com/iScope-in/java-web-app.git

# Creating build package(Artifact) from the Source code
WORKDIR /project/java-web-app
RUN /project/maven/bin/mvn clean package

# Copying the artifact to Deployment Location. Once a web application is deployed in the webapps directory, 	it becomes accessible via the URL path that corresponds to its name. For example, if you deploy an 	application named welcomeapp, it would be accessible at http://localhost:8080/welcomeapp.
RUN cp /project/java-web-app/target/welcomeapp.war /project/tomcat/webapps

# Expose the default Tomcat port
EXPOSE 8080

# WORKDIR /project/tomcat/bin
# Set the default command to run Tomcat
ENTRYPOINT ["catalina.sh", "run"]
