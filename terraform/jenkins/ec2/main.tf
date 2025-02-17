module security_group {
  source = "../securitygroup"
    contact = var.contact
      ecs_cluster_name = var.ecs_cluster_name
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins_master.id
  allocation_id = module.security_group.eip_id
}

resource "aws_instance" "jenkins_master" {
  ami              = var.ami
  instance_type    = var.instance_type
 key_name = var.ssh_key_name
  vpc_security_group_ids = [
    module.security_group.sg_id
  ]
  subnet_id = module.security_group.subnet_id
 associate_public_ip_address = true
 iam_instance_profile        = aws_iam_instance_profile.jenkins_profile.name
	user_data = file("ec2/scripts/install_jenkins.sh")
    tags = {
        Contact = var.contact
        Department = var.department
    }
}