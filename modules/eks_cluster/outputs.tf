output "eks" {
  value = {
    certificate_authority = aws_eks_cluster.eks_cluster.certificate_authority[0].data
    cluster_name = aws_eks_cluster.eks_cluster.id
    endpoint = aws_eks_cluster.eks_cluster.endpoint
    worker_node_iam_role = aws_iam_role.node.name
    node_iam_role_arn = aws_iam_role.node.arn
    cluster = aws_eks_cluster.eks_cluster
  }
}