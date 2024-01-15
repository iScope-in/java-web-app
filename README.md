deploy.sh : This is a shellscript meant for running this web application in linux
Dockerfile: Creating a docker container using Dockerfile. Beloaw is the instructions.
  Step1: Download the Dockerfile to your Host machine
  Step2: Install docker on host machine(https://docs.docker.com/engine/install/ubuntu/)
  Step3: # docker build -t <imagename> .
  Step4: # docker run -d --name mywebapp2 -p 8081:8080 myimg
	   or
	   docker run --name mywebapp2 -p 8081:8080 -it myimg 
  Step3:  Check in Browser http://<Public IP of Host>:8081/welcomeapp
