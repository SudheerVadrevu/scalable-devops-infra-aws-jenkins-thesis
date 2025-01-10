variable "cluster_name" {
  description = "The cluster_name"
  default = "default"
}

variable "departemnt" {
  description = "Department"
}

variable "contact" {
  description = "Service owner email"
}


variable "container_name" {
  description = "Container name"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "aws_region" {
  description = "AWS Region for the VPC"
  default     = "eu-north-1"
}

variable "public_subnet_1a" {
  description = "Public Subnet on eu-north-1a"
}

variable "public_subnet_1b" {
  description = "Public Subnet on eu-north-1b"
}

variable "jenkins_sg_id" {
  description = "Application Load Balancer Security Group"
}

variable "security_groups_ids" {
  type        = list(string)
  description = "Security group lists"
}

variable "alb_port" {
  description = "ALB listener port"
}

variable "container_port" {
  description = "ALB target port"
}

variable "desired_tasks" {
  description = "Number of containers desired to run the application task"
}

variable "desired_task_cpu" {
  description = "Task CPU Limit"
}

variable "desired_task_memory" {
  description = "Task Memory Limit"
}

variable "min_tasks" {
  description = "Minimum"
}

variable "max_tasks" {
  description = "Maximum"
}

variable "cpu_to_scale_up" {
  description = "CPU % to Scale Up the number of containers"
}

variable "cpu_to_scale_down" {
  description = "CPU % to Scale Down the number of containers"
}
