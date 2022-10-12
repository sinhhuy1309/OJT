output "eks" {
  value = {
    certificate_authority = aws_eks_cluster.eks_cluster.certificate_authority.0.data
    cluster_name = aws_eks_cluster.eks_cluster.name
    endpoint = aws_eks_cluster.eks_cluster.endpoint
  }
}