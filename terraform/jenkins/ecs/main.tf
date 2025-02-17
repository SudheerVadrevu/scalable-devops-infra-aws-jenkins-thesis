resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  setting {
      name = "containerInsights"
      value = "enabled"
  }
    tags = {
        Contact = var.contact
        Department = var.department
    }
}