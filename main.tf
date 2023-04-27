terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # profile = "mck-sandbox"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

module "instance_key_pair" {
  source = "./modules/key_pair"

  key_pair_name = var.key_pair_name
}

module "vpc" {
  source = "./modules/vpc"
}
module "internet_gateway" {
  source = "./modules/gateway"

  vpc_id = module.vpc.vpc_id
}

module "instance_registry" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-registry"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.10.0/24"
}

module "instance_auth" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-auth"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.20.0/24"
}

module "instance_product" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-product"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.30.0/24"
}

module "instance_transportation" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-transportation"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.40.0/24"
}

module "instance_orgarnization" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-orgarnization"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.50.0/24"
}

module "instance_route" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-route"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.60.0/24"
}

module "instance_user" {
  source = "./modules/instance"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-user"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.70.0/24"
}