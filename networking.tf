/*********************
      VPC
**********************/
resource "aws_vpc" "main" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true # Enable IPv6 for the VPC

  tags = {
    Name = "main"
  }
}

/*********************
      Subnets
**********************/
resource "aws_subnet" "public_subnets" {
  count = 3

  vpc_id                                         = aws_vpc.main.id
  cidr_block                                     = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 1)
  assign_ipv6_address_on_creation                = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, count.index + 1)
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = 3

  vpc_id                                         = aws_vpc.main.id
  cidr_block                                     = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 4)
  assign_ipv6_address_on_creation                = true
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, count.index + 4)
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "private-subnet-${count.index + 4}"
  }
}

/*********************
      IGWS
**********************/
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_egress_only_internet_gateway" "egress" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "egress-only-igw"
  }
}

/*********************
      Route table
**********************/
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Public route table"
  }
}
/*********************
      Routes
**********************/
resource "aws_route" "egress_only" {
  route_table_id              = aws_vpc.main.main_route_table_id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.egress.id
}

/*********************
  Subnet Associations
**********************/
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = 3
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index + 4)
  route_table_id = aws_vpc.main.main_route_table_id
}

resource "aws_route_table_association" "public_subnet_assoc" {
  count          = 3
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}