terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.46.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.3"
    }
  }
  required_version = ">= 0.14"
}
