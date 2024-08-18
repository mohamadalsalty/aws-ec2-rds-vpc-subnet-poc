resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = aws_db_subnet_group.this.id
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot  = var.skip_final_snapshot
  publicly_accessible  = var.publicly_accessible
  storage_type         = var.storage_type

  tags = {
    Name = var.name
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name}-subnet-group"
  }
}

output "endpoint" {
  value = aws_db_instance.this.endpoint
}