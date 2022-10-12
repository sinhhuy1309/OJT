resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.name}-eks-nodes"
  node_role_arn = aws_iam_role.node.arn
  subnet_ids = var.vpc.private_subnet[*]
  instance_types = ["t3.medium"]
  disk_size = 10
  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
