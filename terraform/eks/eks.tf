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
  version         = "14.0.0"
  cluster_name    = "${local.app_name}-eks-cluster"
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true

  tags = {
    Environment = "test"
    Owner = "Zhenyu.li"
  }

  worker_groups_launch_template = [
    {
      name                 = "worker-group-1"
      instance_type        = "t3.small"
      asg_desired_capacity = 1
      public_ip            = true
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                 = "worker-group-2"
      instance_type        = "t3.medium"
      asg_desired_capacity = 1
      public_ip            = true
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  map_roles                            = var.map_roles
  # map_users                            = var.map_users
  # map_accounts                         = var.map_accounts
}
