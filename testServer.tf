resource "aws_instance" "app_server" {
  ami           = "ami-07b36ea9852e986ad"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}