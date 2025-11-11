variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the node group"
  type        = list(string)
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "default"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "disk_size" {
  description = "Disk size in GB for worker nodes"
  type        = number
  default     = 20
}

variable "capacity_type" {
  description = "Capacity type (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "max_unavailable" {
  description = "Maximum number of nodes that can be unavailable during update"
  type        = number
  default     = 1
}

variable "create_key_pair" {
  description = "Whether to create an SSH key pair for node access"
  type        = bool
  default     = false
}

variable "public_key_path" {
  description = "Path to public key file for node SSH access"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply to node group"
  type        = map(string)
  default     = {}
}
