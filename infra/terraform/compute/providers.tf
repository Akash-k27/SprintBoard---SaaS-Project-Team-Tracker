provider "aws" {
  region = var.region
}

variable "region" {
  type    = string
  default = "ap-south-1"
}
