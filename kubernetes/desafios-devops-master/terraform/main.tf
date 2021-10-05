# DevOps Challenge Idwall .::. Thiago Paz #

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

# Create Security Group to allow connection on ports 22, 80, 443
module "idwall-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "idwall sg"
  description = "Allow ports 22, 80, 443"


  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp", "http-80-tcp"]
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "${var.ssh_range}" # ask user for cidr_blocks
    },
  ]
}


# Create Ubuntu server, install docker and run httpd container
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "idwall-ec2"

  ami                    = "ami-09e67e426f25ce0d7" # Ubuntu Server 20.04
  instance_type          = "t2.micro"
  key_name               = "${var.key_pair}"

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
  security_group_id    = module.idwall-sg.security_group_id
  network_interface_id = module.ec2_instance.primary_network_interface_id
}
