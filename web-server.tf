resource "aws_instance" "web_server" {
  ami           = "ami-0cd3c7f72edd5b06d"  # Replace with your desired AMI ID
  instance_type = "t2.micro"     # Replace with your desired instance type

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = element(aws_subnet.public_subnets.*.id, 0)  # Use the first public subnet

  key_name = "k8s"  # Replace with your key pair name

  tags = {
    Name = "web-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              service nginx start
              chkconfig nginx on
              EOF
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-security-group"
  }
}