terraform {
  backend "s3" {
    bucket = "terraform-demo-test-state"
    key    = "ec2/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
