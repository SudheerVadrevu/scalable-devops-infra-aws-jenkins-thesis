
resource "aws_iam_role" "ruiyang-thesis-node" {
  name = "${var.cluster_name}-node"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ruiyang-thesis-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.ruiyang-thesis-node.name
}

resource "aws_iam_role_policy_attachment" "ruiyang-thesis-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.ruiyang-thesis-node.name
}

resource "aws_iam_role_policy_attachment" "ruiyang-thesis-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.ruiyang-thesis-node.name
}

resource "aws_eks_node_group" "thesis" {
  cluster_name    = var.cluster_name
  node_group_name = "ruiyang-eks"
  node_role_arn   = aws_iam_role.ruiyang-thesis-node.arn
  subnet_ids      = aws_subnet.ruiyang-thesis-cluster[*].id
  instance_types  = ["t3.nano"]
  disk_size = 8

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.ruiyang-thesis-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.ruiyang-thesis-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.ruiyang-thesis-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}