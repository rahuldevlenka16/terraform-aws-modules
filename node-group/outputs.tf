output "node_group_name" {
  description = "EKS node group name"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "ARN of the EKS node group"
  value       = aws_eks_node_group.this.arn
}

output "scaling_config" {
  description = "Scaling configuration of the node group"
  value = {
    desired_size = aws_eks_node_group.this.scaling_config[0].desired_size
    min_size     = aws_eks_node_group.this.scaling_config[0].min_size
    max_size     = aws_eks_node_group.this.scaling_config[0].max_size
  }
}
