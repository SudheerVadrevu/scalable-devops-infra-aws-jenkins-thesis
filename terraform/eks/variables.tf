variable "aws_region" {
  type = string
  default = "eu-north-1"
}
variable "aws_credentials_file" {
  type = string
  default = ".aws/credentials"
}
variable "env_name" {
  type = string
  default = "test"
}

variable department {
  type        = string
  default     = "devops-fi-hki"
  description = "tag"
}

variable contact {
  type        = string
  description = "tag"
}


variable "frontend_ssh_port" {
  default     = 22
}
variable "frontend_app_port" {
  default     = 80
}
variable "cluster_name" {
  default = "ruiyang_master_thesis"
  type    = string
}

variable "HOME" {
    type = string
    default = "/Users/ruiyang"
}