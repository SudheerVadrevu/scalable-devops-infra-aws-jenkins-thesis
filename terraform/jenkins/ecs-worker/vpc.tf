
#VPC
resource "aws_vpc" "cluster_vpc" {
  cidr_block = "10.0.0.0/16" 
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
        Name = "ruiyang-${var.cluster_name}-vpc"
        Contact = var.contact
        Department = var.department
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags {
        Name = "InternetGateway"
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
}

  
#### Public Subnets

resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.cluster_vpc.id}"
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "cluster-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.cluster_vpc.id}"
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "cluster-public-subnet-2"
  }
}

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
  subnet_id      = "${aws_subnet.public_subnet_us_east_1a.id}"
  route_table_id = "${aws_vpc.cluster_vpc.main_route_table_id}"
}

# Associate subnet public_subnet_us_east_1b to public route table
resource "aws_route_table_association" "public_subnet_us_east_1b_association" {
  subnet_id      = "${aws_subnet.public_subnet_us_east_1b.id}"
  route_table_id = "${aws_vpc.cluster_vpc.main_route_table_id}"
}