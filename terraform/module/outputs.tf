# DevOps Challenge Idwall .::. Thiago Paz #

# Public IP output using Resource
/*
output idwall_ec2_public_ip {
    value = aws_instance.idwall-ec2.public_ip
}
*/

# Public IP output using Module
output idwall_ec2_public_ip {
    value = module.ec2_instance.public_ip
}
