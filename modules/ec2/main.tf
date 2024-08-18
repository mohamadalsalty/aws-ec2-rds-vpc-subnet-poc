


resource "aws_instance" "this" {
    subnet_id = var.subnet_id
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<html><h1>Hello from Terraform</h1></html>" > /var/www/html/index.html
              EOF

  ami           = var.ami
  instance_type = var.type
  vpc_security_group_ids = var.sg_ids
  tags = {
    Name = var.name
  }
}

output "ec2_id" {
  value = aws_instance.this.id
}

