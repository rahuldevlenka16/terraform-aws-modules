# Terraform AWS Modules

Reusable Terraform modules for AWS infrastructure.

| Module | Description |
|--------|--------------|
| [vpc/](./vpc) | Creates a VPC with public/private subnets and optional NAT |
| [eks/](./eks) | Creates an EKS cluster and related IAM roles |
| [node-group/](./node-group) | Manages EKS node groups |
| [iam/](./iam) | Creates reusable IAM roles and policies |



# VPC Module

Reusable VPC Terraform module that can create:
- VPC
- Public and private subnets
- Internet Gateway
- Optional NAT Gateway
- Route tables



### Example (for EKS)

```hcl
module "vpc" {
  source = "github.com/rahuldevlenka16/terraform-modules//vpc?ref=v1.0.0"
  cidr_block = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs = ["ap-south-1a", "ap-south-1b"]
  create_nat = true
  environment = "dev"
  project = "eks-cluster"
}
