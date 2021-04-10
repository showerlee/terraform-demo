locals {
  app_name = "terraform-demo-eks-node"
  example_sa_namespace    = "default"
  example_sa_name         = "sa-for-pod-assume-role"
  jenkins_agent_role_name       = "jenkins-agent-pod-role"
  jenkins_agent_sa_namespace    = "jenkins"
  jenkins_agent_sa_name         = "sa-for-jenkins-agent-pod-role"
}
