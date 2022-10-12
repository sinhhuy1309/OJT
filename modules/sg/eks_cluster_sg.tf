resource "aws_security_group" "eks_cluster" {
  vpc_id = var.vpc.vpc_id
  name = "${var.name}-eks-cluster-sg"
}

resource "aws_security_group_rule" "cluster-inbound" {
  description = "Allow worker nodes to communicate with the cluster API Server"
  security_group_id = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
}

resource "aws_security_group_rule" "cluster_outbound" {
  description = "Allow cluster API Server to communicate with the worker nodes"
  security_group_id = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  type = "egress"
  from_port = 1024
  to_port = 65535
  protocol = "tcp"
}