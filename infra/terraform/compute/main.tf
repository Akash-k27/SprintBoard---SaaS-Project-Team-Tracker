data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# EC2 instance with k3s user-data
resource "aws_instance" "k3s" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.sg_k3s_id]

  # Use your EXISTING key pair; no aws_key_pair resource
  key_name = var.key_name

  user_data = file("${path.module}/user-data-k3s.sh")

  tags = { Name = "sb-k3s-tf" }
}

# Elastic IP for easy access
resource "aws_eip" "k3s" {
  domain     = "vpc"
  instance   = aws_instance.k3s.id
  depends_on = [aws_instance.k3s]
  tags       = { Name = "sb-k3s-tf-eip" }
}

output "instance_id" { value = aws_instance.k3s.id }
output "public_ip" { value = aws_eip.k3s.public_ip }
