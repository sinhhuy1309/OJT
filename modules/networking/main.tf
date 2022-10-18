resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.name}-internet-gateway"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  for_each = var.map_az_subnet_public
  availability_zone = each.key
  cidr_block = each.value
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.name}-${each.value}"
    "kubernetes.io/role/elb" = 1    
    "kubernetes.io/cluster/huyls-eks-cluster" = "shared" 
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  for_each = var.map_az_subnet_private
  availability_zone = each.key
  cidr_block = each.value
  tags = {
    "Name" = "${var.name}-${each.value}"
    "kubernetes.io/role/internal-elb" = 1    
    "kubernetes.io/cluster/huyls-eks-cluster" = "shared"
  }
}

resource "aws_eip" "eip_nat" {
  vpc = true
  tags = {
    "Name" = "${var.name}-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id = aws_subnet.public_subnet["ap-east-1a"].id
  depends_on = [aws_eip.eip_nat]
  tags = {
    "Name" = "${var.name}-PublicNAT"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "public_association" {
  depends_on = [aws_subnet.public_subnet]
  route_table_id = aws_route_table.public_route_table.id
  for_each = aws_subnet.public_subnet
  subnet_id = each.value.id
}

resource "aws_route_table_association" "private_association" {
  depends_on = [aws_subnet.private_subnet]
  route_table_id = aws_route_table.private_route_table.id
  for_each = aws_subnet.private_subnet
  subnet_id = each.value.id
}
