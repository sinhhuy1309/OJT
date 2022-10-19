data "template_file" "ebs_csi_iam_policy" {
  template = "${file("${path.module}/iam-policy.json")}"
}

resource "aws_iam_policy" "ebs_csi_iam_policy" {
  name        = "${var.name}-AmazonEKS_EBS_CSI_Driver_Policy"
  path        = "/"
  description = "EBS CSI IAM Policy"
  policy = data.template_file.ebs_csi_iam_policy.rendered
}

resource "aws_iam_role" "ebs_csi_iam_role" {
  name = "${var.name}-ebs-csi-iam-role"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${var.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {            
            "${var.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }        
      },
    ]
  })
  tags = {
    tag-key = "${var.name}-ebs-csi-iam-role"
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.ebs_csi_iam_policy.arn 
  #role       = var.worker_node_iam_role
  role = aws_iam_role.ebs_csi_iam_role.name
}

######################
resource "aws_iam_policy" "eks_worknode_ebs_policy" {
  name = "${var.name}-Amazon_EBS_CSI_Driver"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}
# And attach the new policy
resource "aws_iam_role_policy_attachment" "worknode-AmazonEBSCSIDriver" {
  policy_arn = aws_iam_policy.eks_worknode_ebs_policy.arn
  role       = var.worker_node_iam_role
}