variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID from network module output"
}

variable "sg_k3s_id" {
  type        = string
  description = "Security group ID for k3s node (from network module)"
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
}

variable "public_key_path" {
  type        = string
  description = "Path to your public key file (e.g., C:/Users/<you>/.ssh/id_rsa.pub)"
}
