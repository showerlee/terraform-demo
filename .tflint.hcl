config {
  module = false
  force = false
}

plugin "aws" {
  enabled = true
  version = "0.5.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_deprecated_index" {
  enabled = false
}

rule "terraform_comment_syntax" {
  enabled = false
}

rule "terraform_naming_convention" {
  enabled = false
}
