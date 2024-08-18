provider "aws" {
  region = "eu-central-1"
}


module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "vpc"
}


module "subnet_public" {
  source     = "./modules/subnet"
  name       = "subnet-public"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1b"
  vpc_id     = module.vpc.vpc_id
}

module "subnet_private_1" {
  source     = "./modules/subnet"
  name       = "subnet-private"
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
  vpc_id     = module.vpc.vpc_id
}

module "subnet_private_2" {
  source     = "./modules/subnet"
  name       = "subnet-private"
  cidr_block = "10.0.3.0/24"
  vpc_id     = module.vpc.vpc_id
  availability_zone = "eu-central-1a"
}


module "ig" {
  source = "./modules/ig"
  name="vpc-ig"
  vpc_id = module.vpc.vpc_id
}

module "rt" {
  source = "./modules/rt"
  name = "route-table"
  vpc_id = module.vpc.vpc_id
  igw_id = module.ig.igw_id
  cidr_block = "0.0.0.0/0"
  subnet_id = module.subnet_public.subnet_id
}

module "sg" {
  source = "./modules/sg"
  name = "all"
  vpc_id = module.vpc.vpc_id
}


module "vm" {
  source    = "./modules/ec2"
  name      = "vm"
  type      = "t3.micro"
  ami       = "ami-0a49b025fffbbdac6"
  subnet_id = module.subnet_public.subnet_id
  sg_ids= [module.sg.sg_id]
} 

module "eip" {
  source = "./modules/eip"
  name ="vm-ip"
  ec2_id = module.vm.ec2_id
}
module "rds" {
  source = "./modules/rds"

  name                   = "mydb"
  db_name                = "mydatabase"
  username               = "admin"
  password               = "YOURPASSWORD"
  subnet_ids             = [module.subnet_private_1.subnet_id, module.subnet_private_2.subnet_id]
  vpc_security_group_ids = [module.sg.sg_id]
}

output "rds_endpoint" {
  value = module.rds.endpoint
}