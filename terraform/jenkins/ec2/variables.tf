variable department {
  type        = string
  default     = "devops-fi-hki"
  description = "tag"
}

variable contact {
  type        = string
  description = "tag"
}

variable ami {
  type        = string
  default     = "ami-050981837962d44ac"
  description = "ami for jenkins_master, default:Ubuntu Server 18.04 LTS (HVM), SSD Volume Type "
}

variable instance_type {
  type        = string
  default     = "t3.micro"
  description = "instance type"
}

variable ssh_key_name {
  type        = string
  default     = "ruiyang-master-thesis"
  description = "ssh key for ec2"
}

variable ecs_cluster_name {
  type        = string
}
