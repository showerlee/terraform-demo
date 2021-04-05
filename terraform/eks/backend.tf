terraform {
  backend "s3" {
    bucket = "terraform-demo-init-state"
    key    = "eks/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
