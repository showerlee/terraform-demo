terraform {
  backend "s3" {
    bucket = "terraform-demo-init-state"
    key    = "eks-node/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
