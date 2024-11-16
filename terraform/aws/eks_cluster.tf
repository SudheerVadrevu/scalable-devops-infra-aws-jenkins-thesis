data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

# Override with variable or hardcoded value if necessary
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "aws_iam_role" "ruiyang-thesis-cluster" {
  name = var.cluster_name
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_security_group" "ruiyang-thesis-cluster" {
  name        = "terraform-eks-ruiyang-thesis-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.ruiyang-thesis-cluster.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-ruiyang-thesis-cluster"
  }
}

resource "aws_security_group_rule" "ruiyang-thesis-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ruiyang-thesis-cluster.id
  to_port           = 443
  type              = "ingress"
}


resource "aws_iam_role_policy_attachment" "ruiyang-thesis-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.ruiyang-thesis-cluster.name
}

resource "aws_iam_role_policy_attachment" "ruiyang-thesis-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.ruiyang-thesis-cluster.name
}


resource "aws_eks_cluster" "ruiyang-master-thesis" {
  name = var.cluster_name
  role_arn = aws_iam_role.ruiyang-thesis-cluster.arn

    vpc_config {
    security_group_ids = [aws_security_group.ruiyang-thesis-cluster.id]
    subnet_ids         = aws_subnet.ruiyang-thesis-cluster[*].id
  }
  depends_on = [
    aws_iam_role_policy_attachment.ruiyang-thesis-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.ruiyang-thesis-cluster-AmazonEKSServicePolicy,
  ]
}