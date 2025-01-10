data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "ruiyang-thesis-cluster" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "ruiyang-thesis-cluster-node",
    "kubernetes.io/cluster/${var.cluster_name}", "shared",
  )
}

resource "aws_subnet" "ruiyang-thesis-cluster" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.ruiyang-thesis-cluster.id

  tags = map(
    "Name", "ruiyang-thesis-cluster-node",
    "kubernetes.io/cluster/${var.cluster_name}", "shared",
  )
}

resource "aws_internet_gateway" "ruiyang-thesis-cluster" {
  vpc_id = aws_vpc.ruiyang-thesis-cluster.id

  tags = {
    Name = "truiyang-thesis-cluster"
  }
}

resource "aws_route_table" "ruiyang-thesis-cluster" {
  vpc_id = aws_vpc.ruiyang-thesis-cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ruiyang-thesis-cluster.id
  }
}

resource "aws_route_table_association" "ruiyang-thesis-cluster" {
  count = 2

  subnet_id      = aws_subnet.ruiyang-thesis-cluster.*.id[count.index]
  route_table_id = aws_route_table.ruiyang-thesis-cluster.id
}