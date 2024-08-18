resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "sg-${var.name}"
  }
}


output "sg_id" {
  value = aws_security_group.this.id
}