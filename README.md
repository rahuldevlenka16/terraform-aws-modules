# Terraform AWS Modules

Reusable Terraform modules for AWS infrastructure.

| Module | Description |
|--------|--------------|
| [vpc/](./vpc) | Creates a VPC with public/private subnets and optional NAT |
| [eks/](./eks) | Creates an EKS cluster and related IAM roles |
| [node-group/](./node-group) | Manages EKS node groups |
| [iam/](./iam) | Creates reusable IAM roles and policies |


# Modules

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
  source = "git::https://github.com/rahuldevlenka16/terraform-aws-modules.git//vpc?ref=master"
  cidr_block = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs = ["ap-south-1a", "ap-south-1b"]
  create_nat = true
  environment = "dev"
  project = "eks-cluster"
}

---

# EKS IAM Role Module

Reusable Terraform module for creating IAM roles and policies for EKS clusters and nodes.

### Features
- EKS cluster IAM role with required AWS-managed policies  
- EKS node IAM role with worker and networking policies  
- Optional admin IAM policy for kubectl access  

### Example usage

```hcl
module "iam" {
  source = "git::https://github.com/rahuldevlenka16/terraform-aws-modules.git//eks_iam_roles?ref=master"

  project = "myapp"
  environment = "dev"
  create_admin_policy = true #remove this
}

---

# EKS Node Group Module

Reusable Terraform module to create an EKS managed node group.

### Features
- Creates EKS managed node groups with configurable size and instance type  
- Supports optional SSH key pair for node access  
- Works seamlessly with your `eks` and `eks_iam_roles` modules  


### Example Usage

```hcl
module "node_group" {
  source = "git::https://github.com/rahuldevlenka16/terraform-aws-modules.git//node-group?ref=master"

  cluster_name  = module.eks.cluster_name
  node_role_arn = module.eks_iam_roles.node_role_arn
  subnet_ids    = module.vpc.private_subnets

  project       = "myapp"
  environment   = "dev"

  desired_size  = 2
  max_size      = 3
  min_size      = 1
  instance_type = "t3.medium"
  capacity_type = "SPOT"
}

---

# EKS Module

Reusable Terraform module to create an **Amazon EKS cluster**.


### Features
- Creates EKS control plane with configurable version  
- Supports public or private endpoint access  
- Enables control plane logs  
- Can optionally create a cluster security group  
- Designed to plug directly into your `vpc` and `eks_iam_roles` modules  


### Example Usage

```hcl
module "eks" {
  source = "git::https://github.com/rahuldevlenka16/terraform-aws-modules.git//eks?ref=main"

  subnet_ids        = module.vpc.private_subnets
  vpc_id            = module.vpc.vpc_id
  cluster_role_arn  = module.eks_iam_roles.cluster_role_arn
  kubernetes_version = "1.29"

  project     = "myapp"
  environment = "dev"

  endpoint_public_access  = true
  endpoint_private_access = false
  create_cluster_sg       = true
}

