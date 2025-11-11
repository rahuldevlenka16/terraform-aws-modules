# --------------------------------------------
# EKS Cluster
# --------------------------------------------
resource "aws_eks_cluster" "this" {
  name     = "${var.project}-${var.environment}-eks"
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    public_access_cidrs     = var.public_access_cidrs
  }

  enabled_cluster_log_types = var.cluster_log_types

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-eks-cluster"
    }
  )
}

# --------------------------------------------
# Optional: Cluster Security Group
# --------------------------------------------
resource "aws_security_group" "eks_cluster_sg" {
  count  = var.create_cluster_sg ? 1 : 0
  name   = "${var.project}-${var.environment}-eks-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow all node-to-control-plane traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-eks-sg"
    }
  )
}
