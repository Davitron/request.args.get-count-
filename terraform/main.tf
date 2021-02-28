provider "aws" {
  shared_credentials_file              = var.aws_credentials
  region                               = var.region
} 


module "network" {
    source        = "./modules/network"
    vpc_cidr      = var.vpc_cidr
    subnet_cidr   = var.subnet_cidr
    az            =  var.az
}

module "ec2" {
    source = "./modules/ec2"
    public_key_path = var.public_key_path
    private_key_path = var.private_key_path
    instance_type = var.instance_type
    subnet_id     = module.network.subnet_id
    security_group_id = module.network.security_group_id
    ansible_role_file = var.ansible_role_file
    ansible_playbook_file = var.ansible_playbook_file
}