
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"

}

###################################################################################################

#SECURITY GROUPS

###################################################################################################

#Port 8000 Security group default VPC
module "app_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "app-service"
  description = "Security group for application with custom port 8000 open within VPC"
  vpc_id      = var.vpc_id
  tags = {
    Terraform = "true"
    Name      = "Deployment7-gunicorn-sg-group"
  }

  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = "tcp"
      description = " Gunicorn Application port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = "-1"
      description = "All protocols"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

#SSH Security Group us-east VPC
module "ssh_security_group" {
  name                = "ssh"
  source              = "terraform-aws-modules/security-group/aws//modules/ssh"
  version             = "~> 5.0"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform = "true"
    Name      = "Deployment7-ssh-sg-group"
  }

}

module "http_8080_security_group" {
  name        = "jenkins-server"
  source  = "terraform-aws-modules/security-group/aws//modules/http-8080"
  version = "~> 5.0"
  vpc_id = var.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform = "true"
    Name= "Deployment7-8080-sg-group"
  }

}

###################################################################################################

#EC2s

###################################################################################################

resource "aws_instance" "jenkins_server01" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [module.ssh_security_group.security_group_id, module.http_8080_security_group.security_group_id]
  subnet_id                   = "subnet-0e6fcd89303fcf68a" #us-east-1a
  associate_public_ip_address = true
  key_name = "pub-instance"

  user_data = file("jenkins_server.sh")

  tags = {
    Name = "deployment7-jenkinsServer"
  }

}

resource "aws_instance" "docker_server01" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [module.ssh_security_group.security_group_id, module.app_service_sg.security_group_id]
  subnet_id                   = "subnet-07915f122c25d65ad" #us-east-1b
  associate_public_ip_address = true
  key_name = "pub-instance"

  user_data = file("docker_server.sh")

  tags = {
    Name = "deployment7-jenkinsAgent-dockerServer"
  }

}

resource "aws_instance" "terraform_server01" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [module.ssh_security_group.security_group_id]
  subnet_id                   = "subnet-04eca892e2fcf842c" #us-east-1c
  associate_public_ip_address = true
  key_name = "pub-instance"

  user_data = file("terraform_server.sh")

  tags = {
    Name = "deployment7-jenkinsAgent-terraformServer"
  }

}