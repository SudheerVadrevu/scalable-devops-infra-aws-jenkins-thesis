module network {
  source = "../networking"
  contact  = var.contact
  ecs_cluster_name = var.ecs_cluster_name
}

resource "aws_security_group" "sg_jenkins" {
  name = "sg_${var.ecs_cluster_name}"
  description = "Sg for Jenkins Cluster"
  vpc_id = module.network.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 50000
    to_port = 50000
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
    tags  = {
        Contact = var.contact
        Department = var.department
    }
}
