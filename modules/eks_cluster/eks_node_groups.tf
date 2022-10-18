resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.name}-eks-nodes"
  node_role_arn = aws_iam_role.node.arn
  subnet_ids = var.vpc.public_subnet
  instance_types = ["t3.medium"]
  disk_size = 20
  ami_type = "AL2_x86_64"
  # launch_template {
  #   name = aws_launch_template.eks_node_launch_tempalte.name
  #   version = aws_launch_template.eks_node_launch_tempalte.latest_version
  # }
  remote_access {
    ec2_ssh_key = var.key_pair
  }
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

# resource "aws_launch_template" "eks_node_launch_tempalte" {
#   name_prefix = "${var.name}"
#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs {
#       volume_size = 20
#     }
#   }
#   key_name = var.key_pair
#   provisioner "remote-exec" {
#     inline = [
#       "curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash",
#       "helm repo add jenkinsci https://charts.jenkins.io",
#       "helm repo update",
#       "kubectl apply -f jenkins-volume.yaml",
#       "kubectl apply -f jenkins-sa.yaml",
#       "helm install jenkins -n jenkins -f jenkins-values.yaml $chart",
#     ]
#     connection {
#     type     = "ssh"
#     user     = "root"
#     private_key = var.key_pair
#     host = 
#   }
#   }
# }
