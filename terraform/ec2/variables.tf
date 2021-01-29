variable "app_name" {
  description = "Application name"
  type        = string
}

variable "availability_zone" {
  description = "aws availability zone"
  type        = string
}

variable "vpc" {
  description = "vpc settings"
  type        = map(any)
}

variable "subnet" {
  description = "subnet settings"
  type        = map(any)
}

variable "ec2" {
  description = "ec2 settings"
  type        = map(any)
}
