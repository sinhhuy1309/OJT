output "vpc" {
  value = {
    vpc_id        = aws_vpc.vpc.id
    public_subnet = [for subnet in aws_subnet.public_subnet : subnet.id]
    private_subnet = [for subnet in aws_subnet.private_subnet : subnet.id]
    public_subnet_cidr = [for subnet in aws_subnet.public_subnet : subnet]
    private_subnet_cidr = [for subnet in aws_subnet.private_subnet : subnet]
  }
}