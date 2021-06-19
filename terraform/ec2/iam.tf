resource "aws_iam_role" "tf_demo_role" {
  name               = "${var.app_name}-role"
  assume_role_policy = data.aws_iam_policy_document.tf_demo_assume_role.json
}

data "aws_iam_policy_document" "tf_demo_assume_role" {
  version = "2012-10-17"
  statement {
    actions = [
    "sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
      "ec2.amazonaws.com"]
    }
    effect = "Allow"
    sid    = ""
  }
}

resource "aws_iam_role_policy" "tf_demo_policy" {
  name   = "tf_demo_policy"
  role   = aws_iam_role.tf_demo_role.name
  policy = data.aws_iam_policy_document.tf_demo_policy_document.json
}

data "aws_iam_policy_document" "tf_demo_policy_document" {
  version = "2012-10-17"
  statement {
    actions = [
      "ec2:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_instance_profile" "tf_demo_profile" {
  name       = "tf_demo_profile"
  role       = aws_iam_role.tf_demo_role.name
  depends_on = [aws_iam_role.tf_demo_role]
}
