variable "project" {
  description = "Project name"
  type        = string
  default     = "default"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}

variable "create_admin_policy" {
  description = "Whether to create an admin policy for EKS management"
  type        = bool
  default     = false
}
