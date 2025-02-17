output vpc_id {
  value       = aws_vpc.cluster_vpc.id
  description = "vpc_id"
}

output subnet_id {
  value       = aws_subnet.public_subnet_sthm.id
  description = "subnet_id"
  depends_on  = []
}

output eip_id {
  value       = aws_eip.vpc_eip.id
  description = "elastic ip id for jenkins master"
  depends_on  = [subnet_id, vpc_id]
}
