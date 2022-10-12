provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host = module.eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.eks.certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.dev-cluster.name]
      command     = "aws"
    }
  }
}
# module "networking" {
#   source = "../modules/networking"
  
#   name = var.name
#   vpc_cidr_block = var.vpc_cidr_block
#   #map_az_subnet = var.map_az_subnet
# }

# module "sg" {
#   source = "../modules/sg"

#   name = var.name
#   vpc = module.networking.vpc
# }

# module "elb" {
#   source = "../modules/elb"

#   name = var.name
#   instance_type = var.instance_type
#   sg = module.sg.sg
#   vpc = module.networking.vpc
#   key_pair = var.key_pair
#   image_id = var.image_id
#   efs_dns_name = module.efs.efs_dns_name
#   efs_mount_target = module.efs.efs_mount_target
# }

# module "efs" {
#   source = "../modules/efs"

#   name = var.name
#   vpc = module.networking.vpc
#   sg = module.sg.sg
# }

# module "eks_cluster" {
#   source = "../modules/eks_cluster"

#   name = var.name
#   vpc = module.networking.vpc
# }
