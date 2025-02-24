provider "aws" {
    shared_credentials_file = "${var.HOME}/${var.aws_credentials_file}"
    region = var.aws_region
}