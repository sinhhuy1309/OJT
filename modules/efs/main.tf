resource "aws_efs_file_system" "eks_efs" {
  creation_token = "EKS-EFS"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    "Name" = "${var.name}-eksEFS"
  }
}

resource "aws_efs_mount_target" "eks_efs_mount" {
  file_system_id = aws_efs_file_system.eks_efs.id
  security_groups = [var.sg.ingress_efs]
  count = length(var.vpc.public_subnet)
  subnet_id = var.vpc.public_subnet[count.index]
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.eks_efs.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "EFSMountPolicy",
    "Statement": [
        {
            "Sid": "EFSMountPolicy",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.eks_efs.arn}",
            "Action": [
                "elasticfilesystem:ClientRootAccess",
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "elasticfilesystem:AccessedViaMountTarget": "true"
                }
            }
        }
    ]
}
POLICY
}