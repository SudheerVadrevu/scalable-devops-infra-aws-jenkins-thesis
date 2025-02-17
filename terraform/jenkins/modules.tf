module "ecs" {
  source = "./ecs"
  ecs_cluster_name = var.ecs_cluster_name
  contact = var.contact
}

module "ec2" {
    source = "./ec2"
    contact = var.contact
    ecs_cluster_name = var.ecs_cluster_name
}
