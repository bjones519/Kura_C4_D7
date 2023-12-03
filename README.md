# Objective

Deploy a containerized Python Flask application using Jenkins on AWS Infrastructure provisioned using Terraform

# Steps
1. Created a Jenkins manager server with the following installed:
```
Jenkins, software-properties-common, add-apt-repository -y ppa:deadsnakes/ppa, python3.7, python3.7-venv, build-essential, libmysqlclient-dev, python3.7-dev
```
2. Configured a Jenkins agent and on the Jenkins agent server installed:
```
Terraform and default-jre
```

3. Configured a Jenkins agent and on the Jenkins agent server installed:
```
Docker, default-jre, software-properties-common, add-apt-repository -y ppa:deadsnakes/ppa, python3.7, python3.7-venv, build-essential, libmysqlclient-dev, python3.7-dev
```

4. Created a Dockerfile for the Python Flask application

5. Generated an access token from my Dockerhub, added the credentials into Jenkins and installed the Docker Pipeline Plugin

6. Added my AWS credentials to Jenkins so terraform can provision the infrastructure in my AWS Account

7. Wrote the Jenkinsfile that will test the application, build and push the Docker image to Dockerhub and Apply the terraform infrastructure

8. Created a multibranch pipeline and ran the pipeline


![Pipeline](screenshots/Screenshot%202023-11-03%20at%2010.55.00%20PM.png)
![App](screenshots/Screenshot%202023-11-03%20at%2010.55.37%20PM.png)
# Systems Diagram
![Diagram](screenshots/Screenshot%202023-11-05%20at%2010.51.13%20AM.png)

# Issues
Docker did not install properly on the Jenkins agent server and kept giving me a `docker not found` and `permission denied` error. I had to manually install docker and disconnect/reconnect the agent for the changes to be implemented

# Optimization
- Add a CDN to deliver static content to users
- Make the RDS database private and add a cache for faster reads to the database
- Add a bastion to connect to the instances in the private subnet
- Add rules for auto scaling the number of containers based on traffic spikes