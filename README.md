# Objective

Deploy a containerized Python Flask applicationg using Jenkins on AWS Infrastructure provisioned using Terraform

# Steps
![Pipeline](screenshots/Screenshot%202023-11-03%20at%2010.55.00%20PM.png)
![App](screenshots/Screenshot%202023-11-03%20at%2010.55.37%20PM.png)
# Systems Diagram
![Diagram](screenshots/Screenshot%202023-11-04%20at%2012.37.57%20AM.png)

# Issues
Docker did not instal properly on the Jenkins agent server and kept giving me a `docker not found` and `permission denied`` error. I had to manually install docker and disconnect/reconnect the agent for the chnages to work

# Optimization