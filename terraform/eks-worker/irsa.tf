module "iam_assumable_role_admin_autoscaler" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "3.6.0"
  create_role                   = true
  role_name                     = "cluster-autoscaler"
  provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns              = [aws_iam_policy.cluster_autoscaler.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.autoscaler_sa_namespace}:${local.autoscaler_sa_name}"]

  tags = {
    Environment = "test"
    Owner       = "Zhenyu.li"
  }
}

module "iam_assumable_role_admin_example" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "3.6.0"
  create_role                   = true
  role_name                     = "${local.app_name}-pod-role"
  provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns              = [aws_iam_policy.tf_demo_pod_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.example_sa_namespace}:${local.example_sa_name}"]

  tags = {
    Environment = "test"
    Owner       = "Zhenyu.li"
  }
}
