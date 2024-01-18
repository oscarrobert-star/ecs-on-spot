resource "aws_vpc" "main" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true # Enable IPv6 for the VPC

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id          = aws_vpc.main.id
  assign_ipv6_address_on_creation = true
  ipv6_native     = true
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)}"
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id          = aws_vpc.main.id
  assign_ipv6_address_on_creation = true
  ipv6_native     = true
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)}"
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id          = aws_vpc.main.id
  assign_ipv6_address_on_creation = true
  ipv6_native     = true
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 3)}"
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "public-subnet-3"
  }
}
