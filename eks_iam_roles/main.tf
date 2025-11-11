# --------------------------------------------
# EKS Cluster IAM Role
# --------------------------------------------
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project}-${var.environment}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    { Name = "${var.project}-${var.environment}-eks-cluster-role" }
  )
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ])
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = each.value
}

# --------------------------------------------
# Node Group IAM Role
# --------------------------------------------
resource "aws_iam_role" "eks_node_role" {
  name = "${var.project}-${var.environment}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    { Name = "${var.project}-${var.environment}-eks-node-role" }
  )
}

resource "aws_iam_role_policy_attachment" "eks_node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])
  role       = aws_iam_role.eks_node_role.name
  policy_arn = each.value
}

# --------------------------------------------
# Optional: EKS Admin Policy for Kubectl Access
# --------------------------------------------
resource "aws_iam_policy" "eks_admin_policy" {
  count = var.create_admin_policy ? 1 : 0

  name = "${var.project}-${var.environment}-eks-admin-policy"
  description = "Allow full EKS access for admin users"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*",
          "ec2:Describe*",
          "iam:List*",
          "iam:Get*"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(
    var.tags,
    { Name = "${var.project}-${var.environment}-eks-admin-policy" }
  )
}
