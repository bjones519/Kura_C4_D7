# Objective

Deploy a containerized Python Flask application using Jenkins on AWS Infrastructure provisioned using Terraform

# Steps
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