
#VPC
resource "aws_vpc" "cluster_vpc" {
  cidr_block = "10.0.0.0/16" 
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
        Name = "ruiyang-thesis-vpc"
        Contact = var.contact
        Department = var.department
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = {
        Contact = var.contact
        Department = var.department
    }
}

# Route to Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.cluster_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Elastic IP
resource "aws_eip" "vpc_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.gw]
        tags = {
        Contact = var.contact
        Department = var.department
    }
}

  
#### Public Subnets

resource "aws_subnet" "public_subnet_sthm" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags  = {
        Contact = var.contact
        Department = var.department
    }
}
# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_sthm" {
  subnet_id      = aws_subnet.public_subnet_sthm.id
  route_table_id = aws_vpc.cluster_vpc.main_route_table_id
}
