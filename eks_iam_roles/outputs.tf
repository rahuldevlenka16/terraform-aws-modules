output "cluster_role_arn" {
  description = "IAM Role ARN for EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "IAM Role ARN for EKS node group"
  value       = aws_iam_role.eks_node_role.arn
}

output "admin_policy_arn" {
  description = "IAM Policy ARN for EKS admin (optional)"
  value       = var.create_admin_policy ? aws_iam_policy.eks_admin_policy[0].arn : null
}
