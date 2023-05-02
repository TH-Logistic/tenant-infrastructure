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

resource "aws_db_instance" "instance_rds" {
  allocated_storage = 10
  db_name = var.rds_db_name
  engine = "postgres"
  instance_class = "db.t2.micro"
  username = var.rds_username
  password = var.rds_password
  skip_final_snapshot = true
}

module "instance_key_pair" {
  source = "github.com/TH-Logistic/key_pair"

  key_pair_name = var.key_pair_name
}

module "vpc" {
  source = "github.com/TH-Logistic/vpc"
}
module "internet_gateway" {
  source = "github.com/TH-Logistic/gateway"

  vpc_id = module.vpc.vpc_id
}

module "instance_mongo" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-mongo"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.0.0/24"
  user_data           = file("./scripts/docker.sh")
}

module "instance_auth" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-auth"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.10.0/24"
}

module "instance_product" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-product"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.20.0/24"
}

module "instance_transportation" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-transportation"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.30.0/24"
}

module "instance_orgarnization" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-orgarnization"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.40.0/24"
}

module "instance_route" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-route"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.60.0/24"
}

module "instance_user" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-user"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.70.0/24"
}