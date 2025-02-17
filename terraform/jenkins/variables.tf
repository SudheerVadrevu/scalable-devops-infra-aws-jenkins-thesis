variable aws_region {
  type        = string
  default     = "eu-north-1"
}

variable availability_zone_names {
  type        = string
  default     = ""
  description = "avaliable zones"
}

variable contact {
  type        = string
}

variable ecs_cluster_name {
  type        = string
  default     = "ruiyang_test"
  description = "name of ecs cluster for jenkins workers"
}
