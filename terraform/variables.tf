# DevOps Challenge Idwall .::. Thiago Paz #

# Variables to allow users input of region and SSH ip range

variable "aws_region" {
    description = "Desired cloud region. Example: us-east-1"
}

variable "ssh_range" {
    description = "IP or range allowed to SSH connection. Format: 0.0.0.0/0"
}

variable "key_pair" {
    description = "A key pair consists of a public key that AWS stores, and a private key file that you store. Together, they allow you to connect to your instance securely. Provide your Key Pair name."
}