resource "aws_db_subnet_group" "sb" {
  name       = "sb-db-subnets"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "sb-db-subnets" }
}

resource "aws_security_group" "db" {
  name   = "sb-mysql"
  vpc_id = var.vpc_id

  # allow MySQL ONLY from the k3s node security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.sg_k3s_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sb-mysql" }
}

resource "random_password" "dbpass" {
  length  = 24
  special = true
}

resource "aws_db_instance" "mysql" {
  identifier     = "sb-mysql-dev"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t4g.micro" # low-cost (ARM)
  username       = var.db_username
  password       = random_password.dbpass.result
  db_name        = var.db_name

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"

  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false
  backup_retention_period = 3

  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.sb.name

  tags = { Name = "sb-mysql-dev" }
}
