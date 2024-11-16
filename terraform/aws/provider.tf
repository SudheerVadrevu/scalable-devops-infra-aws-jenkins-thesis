provider "aws" {
     version = "2.55.0"
    shared_credentials_file = "${var.HOME}/${var.aws_credentials_file}"
    region = var.aws_region
}