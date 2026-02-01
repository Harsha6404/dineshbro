module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  enable_irsa = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  access_entries = {
    harsha-admin = {
      principal_arn = "arn:aws:iam::942446708353:user/harsha"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["c7i-flex.large"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  tags = {
    Environment = "dev"
    Project     = "hotel-devsecops"
  }
}
