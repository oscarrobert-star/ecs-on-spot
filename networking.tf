resource "aws_vpc" "main" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true # Enable IPv6 for the VPC

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnets" {
  count = 3

  vpc_id          = aws_vpc.main.id
  assign_ipv6_address_on_creation = true
  ipv6_native     = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 4, count.index + 1)
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = 3

  vpc_id          = aws_vpc.main.id
  assign_ipv6_address_on_creation = true
  ipv6_native     = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 4, count.index + 4)
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
