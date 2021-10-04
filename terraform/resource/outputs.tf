# DevOps Challenge Idwall .::. Thiago Paz #

# Public IP output
output idwall_ec2_public_ip {
    value = aws_instance.idwall-ec2.public_ip
}
