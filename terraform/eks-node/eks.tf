data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "<14.0.0"
  cluster_name    = "${local.app_name}-cluster"
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  tags = {
    Environment = "test"
    Owner = "Zhenyu.li"
  }

  node_groups = {
    example = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      launch_template_id      = aws_launch_template.default.id
      launch_template_version = aws_launch_template.default.default_version

      additional_tags = {
        CustomTag = "EKS example"
        Owner = "Zhenyu.li"
      }
    }
  }

  map_roles                            = var.map_roles
  # map_users                            = var.map_users
  # map_accounts                         = var.map_accounts
}
