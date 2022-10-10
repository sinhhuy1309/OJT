######### Networking #############
vpc_cidr_block = "10.0.0.0/16"
map_az_subnet = {
    "ap-east-1a" = "10.0.0.1/24"
    "ap-east-1b" = "10.0.0.2/24"
    "ap-east-1c" = "10.0.0.3/24"
}

######### ELB #############
name = "huyls"
instance_type = "t3.medium"
key_pair = "huyls"
image_id = "ami-09800b995a7e41703"