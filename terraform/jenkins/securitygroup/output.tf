output sg_id {
  value       = aws_security_group.sg_jenkins.id
  description = "security group id"
}

output vpc_id {
  value       = module.network.vpc_id
  description = "vpc_id"
}

output subnet_id {
  value       = module.network.subnet_id
  description = "subnet_id"
  depends_on  = []
}

output eip_id {
  value       = module.network.eip_id
  description = "elastic ip id for jenkins master"
  depends_on  = [subnet_id, vpc_id]
}
