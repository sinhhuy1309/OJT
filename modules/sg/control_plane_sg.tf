resource "aws_security_group" "control_plane_sg" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-ControlPlane-sg"
}

resource "aws_security_group_rule" "control_plane_inbound" {
  security_group_id = aws_security_group.control_plane_sg.id
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  #cidr_blocks = flatten([var.vpc.public_subnet_cidr, var.vpc.private_subnet_cidr])
  cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

resource "aws_security_group_rule" "control_plane_outbound" {
  security_group_id = aws_security_group.control_plane_sg.id
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
