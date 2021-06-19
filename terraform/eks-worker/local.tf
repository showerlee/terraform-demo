locals {
  app_name                = "tf-demo-eks-worker"
  autoscaler_sa_namespace = "kube-system"
  autoscaler_sa_name      = "cluster-autoscaler-aws-cluster-autoscaler-chart"
  example_sa_namespace    = "default"
  example_sa_name         = "sa-for-pod-assume-role"
}
