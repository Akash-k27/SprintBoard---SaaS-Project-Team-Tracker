variable "private_b" {
  type    = string
  default = "10.0.12.0/24"
}

variable "az_b" {
  type    = string
  default = "ap-south-1b"
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_b
  availability_zone = var.az_b
  tags = {
    Name = "sb-private-b"
  }
}
