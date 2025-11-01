variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_a" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_a" {
  type    = string
  default = "10.0.11.0/24"
}

variable "az_a" {
  type    = string
  default = "ap-south-1a"
}

variable "my_ip" {
  type        = string
  description = "Your public IP /32, e.g. 103.x.x.x/32"
}
