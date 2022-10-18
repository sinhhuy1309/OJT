output "efs_dns_name" {
  value = {
    dns_name = aws_efs_file_system.eks_efs.dns_name
  }
}

output "efs_mount_target" {
  value = {
    mount_target = aws_efs_mount_target.eks_efs_mount
  }
}