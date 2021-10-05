# DevOps Challenge Idwall .::. Thiago Paz #

# Public IP output
output idwall_ec2_public_ip {
    value = module.ec2_instance.public_ip
}