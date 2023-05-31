locals {
  cidr_block_dot=var.stage_name == "prod" ? 2 : ( var.stage_name == "dev" ? 0 : 1)  
}

resource "aws_vpc" "amie" {
  cidr_block       = "10.${local.cidr_block_dot}.0.0/20"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "amie"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.amie.id
  cidr_block        = "10.${local.cidr_block_dot}.0.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.amie.id
  cidr_block        = "10.${local.cidr_block_dot}.1.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "private_subnet_2"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.amie.id
  cidr_block        = "10.${local.cidr_block_dot}.2.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.amie.id
  cidr_block        = "10.${local.cidr_block_dot}.3.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "public_subnet_2"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.amie.id

  tags = {
    Name = "my-igw"
  }
}


resource "aws_route_table" "routable_public" {
  vpc_id = aws_vpc.amie.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "routable_public"
  }
}


resource "aws_route_table" "routable_private" {
  vpc_id = aws_vpc.amie.id

  tags = {
    Name = "routable_private"
  }
}

resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.routable_public.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.routable_public.id
}


resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.routable_private.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.routable_private.id
}
