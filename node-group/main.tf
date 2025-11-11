# --------------------------------------------
# EKS Managed Node Group
# --------------------------------------------
resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project}-${var.environment}-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]
  disk_size      = var.disk_size

  capacity_type  = var.capacity_type  # On-Demand or SPOT

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-node-group"
    }
  )
}

# --------------------------------------------
# Optional: Key Pair for Node SSH Access
# --------------------------------------------
resource "aws_key_pair" "node_ssh_key" {
  count = var.create_key_pair ? 1 : 0
  key_name   = "${var.project}-${var.environment}-eks-key"
  public_key = file(var.public_key_path)
  tags       = var.tags
}
