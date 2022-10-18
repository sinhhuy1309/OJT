########### VPC Security Group ################
resource "aws_security_group" "bastian_sg" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-jenkins-sg"
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress_efs" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-ingress_efs"
  ingress {
    from_port   = 2049
    to_port     = 2049
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

resource "aws_security_group" "albSG" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-albSG"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastian-sg" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-BastianSG"
  ingress {
    from_port   = 22
    to_port     = 22
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


########### EKS Cluster Security Group ################
# # Security Group for Dataplane
# resource "aws_security_group" "data_plane_sg" {
#   vpc_id = var.vpc.vpc_id
#   name = "${var.name}-worker-sg"
# }

# # Security Group traffic rules
# resource "aws_security_group_rule" "nodes" {
#   description = "Allow nodes to communnicate with each other"
#   security_group_id = aws_security_group.data_plane_sg.id
#   type = "ingress"
#   from_port = 0
#   to_port = 65535
#   protocol = "-1"
#   cidr_blocks = flatten([var.vpc.public_subnet, var.vpc.private_subnet])
# }

# resource "aws_security_group_rule" "nodes_inbound" {
#   description = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
#   security_group_id = aws_security_group.data_plane_sg.id
#   type = "ingress"
#   from_port = 1025
#   to_port = 65535
#   protocol = "tcp"
#   cidr_blocks = flatten([var.vpc.public_subnet, var.vpc.private_subnet])
# }

# resource "aws_security_group_rule" "node_outbound" {
#   security_group_id = aws_security_group.data_plane_sg.id
#   type = "egress"
#   from_port = 0
#   to_port = 0
#   protocol = "-1"
#   cidr_blocks = ["0.0.0.0/0"]
# }

# # Security group for control plane
# resource "aws_security_group" "control_plane_sg" {
#   vpc_id = var.vpc.vpc_id
#   name = "${var.name}-ControlPlane-sg"
# }

# resource "aws_security_group_rule" "control_plane_inbound" {
#   security_group_id = aws_security_group.control_plane_sg.id
#   type = "ingress"
#   from_port = 0
#   to_port = 65535
#   protocol = "tcp"
#   cidr_blocks = flatten([var.vpc.public_subnet, var.vpc.private_subnet])
# }

# resource "aws_security_group_rule" "control_plane_outbound" {
#   security_group_id = aws_security_group.control_plane_sg.id
#   type = "egress"
#   from_port = 0
#   to_port = 65535
#   protocol = "-1"
#   cidr_blocks = ["0.0.0.0/0"]
# }

# # EKS Cluster Security Group
# resource "aws_security_group" "eks_cluster" {
#   vpc_id = var.vpc.vpc_id
#   name = "${var.name}-eks-cluster-sg"
# }

# resource "aws_security_group_rule" "cluster-inbound" {
#   description = "Allow worker nodes to communicate with the cluster API Server"
#   security_group_id = aws_security_group.eks_cluster.id
#   source_security_group_id = aws_security_group.eks_nodes.id
#   type = "ingress"
#   from_port = 443
#   to_port = 443
#   protocol = "tcp"
# }

# resource "aws_security_group_rule" "cluster_outbound" {
#   description = "Allow cluster API Server to communicate with the worker nodes"
#   security_group_id = aws_security_group.eks_cluster.id
#   source_security_group_id = aws_security_group.eks_nodes.id
#   type = "egress"
#   from_port = 1024
#   to_port = 65535
#   protocol = "tcp"
# }

# # EKS Node Security Group
# resource "aws_security_group" "eks_nodes" {
#   vpc_id = var.vpc.id
#   name = "${var.name}-eks-node-sg"
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group_rule" "node_internal" {
#   description              = "Allow nodes to communicate with each other"
#   from_port                = 0
#   protocol                 = "-1"
#   security_group_id        = aws_security_group.eks_nodes.id
#   source_security_group_id = aws_security_group.eks_nodes.id
#   to_port                  = 65535
#   type                     = "ingress"
# }

# resource "aws_security_group_rule" "nodes_cluster_inbound" {
#   description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
#   from_port                = 1025
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.eks_nodes.id
#   source_security_group_id = aws_security_group.eks_cluster.id
#   to_port                  = 65535
#   type                     = "ingress"
# }
