resource "aws_vpc" "main_network" {
  cidr_block              = var.vpc_cidr
  enable_dns_hostnames    = true
  tags = {
      "Name"                = "main-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id                  = aws_vpc.main_network.id

  tags = {
    "Name" = "IGW"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id                = aws_vpc.main_network.id
    cidr_block            = var.subnet_cidr
    availability_zone     = var.az
    map_public_ip_on_launch = true

    tags = {
      "Name"              = "public-subnet"
    }
}

resource "aws_route_table" "public_table" {
    vpc_id                = aws_vpc.main_network.id

    tags = {
      "Name"              = "Public-Subnet-Routetable"
    }

    route {
      cidr_block          = "0.0.0.0/0"
      gateway_id          = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id               = aws_subnet.public_subnet.id
  route_table_id          = aws_route_table.public_table.id
}

resource "aws_security_group" "sec_group" {
  vpc_id = aws_vpc.main_network.id
  name = "sample SG"
  description = "security group for instances"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5002
    to_port     = 5002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

