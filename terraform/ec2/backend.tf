terraform {
  backend "s3" {
    bucket = "terraform-demo-init-state"
    key    = "ec2/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
