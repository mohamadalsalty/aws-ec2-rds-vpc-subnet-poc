resource "aws_eip" "this" {
  instance = var.ec2_id

  tags = {
    Name = "eip-${var.name}"
  }
}