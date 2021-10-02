# Desafio DevOps Idwall :: Thiago Paz #

# Variables to allow users input of region and SSH ip range
# Default values was omitted to force user's input

variable "aws_region" {
    description = "Desired cloud region. Example: us-east-1"
}

variable "ssh_range" {
    description = "IP or range allowed to SSH connection. Example: 10.0.0.1/32"
}
