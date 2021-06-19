resource "aws_iam_policy" "tf_demo_pod_policy" {
  name_prefix = "${local.app_name}-pod-role"
  policy      = data.aws_iam_policy_document.tf_demo_pod_policy.json
}

data "aws_iam_policy_document" "tf_demo_pod_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "ec2:*",
      "s3:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "jenkins_agent_pod_policy" {
  name_prefix = "jenkins-agent-pod-role"
  policy      = data.aws_iam_policy_document.jenkins_agent_pod_policy.json
}

data "aws_iam_policy_document" "jenkins_agent_pod_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "ec2:*",
      "s3:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
