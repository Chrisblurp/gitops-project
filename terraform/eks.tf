module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = "devops-gitops-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Fix the encryption issue
  create_kms_key = false
  cluster_encryption_config = {}

  # Essential settings
  cluster_endpoint_public_access = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Project     = "devops-gitops"
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["m7i-flex.large"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      tags = {
        Environment = "dev"
        Name        = "devops-gitops-node-group"
      }
    }
  }
}