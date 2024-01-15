#!/bin/bash

# Developer will send one application to you
   # Developer keeps the Java source code at some central location like GitHub
   # Being a DevOps Eng I will Download from GitHUb(clone)
mkdir -p /project
# java-web-app
# To see the content of java-web-app dir
apt-get update
apt-get install tree -y
cd /project
tree java-web-app

# Install Java and configue as the application is ajava based app
apt-get install openjdk-8-jdk
echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.bashrc

# install maven and configure
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
tar -zxf apache-maven-3.9.6-bin.tar.gz
mv apache-maven-3.9.6 maven
rm apache-maven-3.9.6-bin.tar.gz

echo 'M2_HOME=/project/maven' >> ~/.bashrc
echo 'M2=/project/maven/bin' >> ~/.bashrc
echo "PATH=$PATH:$JAVA_HOME:$M2_HOME:$M2" >> ~/.bashrc
source ~/.bashrc

# Install Tomcat and configure
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz
tar -zxf apache-tomcat-9.0.84.tar.gz
mv apache-tomcat-9.0.84 tomcat
rm apache-tomcat-9.0.84.tar.gz
sh /project/tomcat/bin/startup.sh

cd /project
git clone https://github.com/iScope-in/java-web-app.git

# Go to your downloaded application dir
cd /project/java-web-app

# Run the below command to craete artifact
/project/maven/bin/mvn clean package
sleep 2
# target will be created with the war file
