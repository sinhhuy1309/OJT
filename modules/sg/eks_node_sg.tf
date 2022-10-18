resource "aws_security_group" "eks_nodes" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-eks-node-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "node_internal" {
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  #source_security_group_id = aws_security_group.eks_nodes.id
  #to_port                  = 65535
  to_port = 0
  type                     = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "nodes_cluster_inbound" {
#   description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
#   #from_port                = 1025
#   from_port = 0
#   #protocol                 = "tcp"
#   protocol = "-1"
#   security_group_id        = aws_security_group.eks_nodes.id
#   #source_security_group_id = aws_security_group.eks_cluster.id
#   #to_port                  = 65535
#   to_port = 0
#   type                     = "ingress"
#   cidr_blocks = ["0.0.0.0/0"]
# }
