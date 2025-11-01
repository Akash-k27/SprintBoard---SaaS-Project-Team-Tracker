variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "At least two private subnet IDs across different AZs"
}

variable "sg_k3s_id" {
  type        = string
  description = "Security group ID of the k3s node; allowed to reach MySQL 3306"
}

variable "db_name" {
  type    = string
  default = "sprintboard"
}

variable "db_username" {
  type    = string
  default = "sbadmin"
}
