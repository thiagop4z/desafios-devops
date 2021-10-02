# DevOps Challenge Idwall :: Thiago Paz #

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.60.0"
    }
  }
}

# AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create Security Group to allow port 22, 80, 443
resource "aws_security_group" "idwall-sg" {
  name        = "idwall sg"
  description = "Allow ports 22, 80, 443"

  ingress {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
    
    ingress {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
    
    ingress {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${var.ssh_range}"] # ask user for cidr_blocks
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1" # -1 = all protocols
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "idwall security group"
  }
}

# Create Ubuntu server, install docker and run httpd container
# Same resource recreated below using module
/*
resource "aws_instance" "idwall-ec2" {
    ami = "ami-09e67e426f25ce0d7" #Ubuntu Server 20.04
    instance_type = "t2.micro"
    key_name = "DevOps-Master"

    user_data = <<-E0F
                #!/bin/bash
                sudo apt update -y
                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh get-docker.sh
                sudo docker run -tdp 80:80 httpd
                E0F
    
    tags = {
        Name = "idwall-ec2"
    }
}
*/

# Resource above refactored using modules
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "idwall-ec2"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  key_name               = "DevOps-Master" # Key pair
  monitoring             = true

  user_data = <<-E0F
                #!/bin/bash
                sudo apt update -y
                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh get-docker.sh
                sudo docker run -tdp 80:80 httpd
                E0F

  tags = {
      Name = "idwall ec2"
  }
}

# Attach instance's primary nic to created security group
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.idwall-sg.id
  network_interface_id = module.ec2_instance.primary_network_interface_id
}
