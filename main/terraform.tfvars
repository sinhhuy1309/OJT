######### Networking #############
vpc_cidr_block = "10.0.0.0/16"
region = "ap-east-1"

# replace map values in modules/networking/vars.tf --> variables "map_az_subnet"
# map_az_subnet_public = {
#     "ap-east-1a" = "10.0.1.0/24"
#     "ap-east-1b" = "10.0.2.0/24"
#     "ap-east-1c" = "10.0.3.0/24"
# }


######### ELB #############
name = "huyls"
instance_type = "t3.medium"
key_pair = "huyls"
image_id = "ami-09800b995a7e41703"

######## Jenkins ##########
jenkins_admin_user = "admin"
jenkins_admin_password = ""