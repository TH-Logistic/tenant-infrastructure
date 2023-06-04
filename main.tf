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
  user_data = templatefile("./scripts/instance-user-data/mongo-db.tftpl", {
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_rds" {
  source = "github.com/thinhlh/terraform-rds"

  vpc_id              = module.vpc.vpc_id
  subnet_cidr_1       = "10.0.10.0/24"
  subnet_cidr_2       = "10.0.20.0/24"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  engine              = "postgres"
  rds_db_name         = var.rds_db_name
  rds_username        = var.rds_username
  rds_password        = var.rds_password
  allocated_storage   = 10
}

module "instance_auth" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-auth"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.30.0/24"

  user_data = templatefile("./scripts/instance-user-data/auth-service.tftpl", {
    algorithm      = "HS256"
    secret_key     = var.app_secret
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_product" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-product"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.40.0/24"

  user_data = templatefile("./scripts/instance-user-data/product-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_transportation" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-transportation"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.50.0/24"

  user_data = templatefile("./scripts/instance-user-data/transportation-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_organization" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-organization"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.60.0/24"

  user_data = templatefile("./scripts/instance-user-data/organization-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_route" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-route"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.70.0/24"

  user_data = templatefile("./scripts/instance-user-data/route-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_healthcheck" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-healthcheck"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.80.0/24"

  user_data = templatefile("./scripts/instance-user-data/healthcheck-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_job" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-job"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.90.0/24"

  user_data = templatefile("./scripts/instance-user-data/job-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_billing" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-billing"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.100.0/24"

  user_data = templatefile("./scripts/instance-user-data/billing-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
  })
}

module "instance_user" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-user"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.110.0/24"

  user_data = templatefile("./scripts/instance-user-data/user-service.tftpl", {
    mongo_host     = module.instance_mongo.public_ip
    mongo_port     = 27017
    mongo_db_name  = var.mongo_db_name
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
    auth_host      = module.instance_auth.public_ip
    auth_port      = 8001
  })
}

module "instance_gateway" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-gateway"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.120.0/24"

  user_data = templatefile("./scripts/instance-user-data/gateway.tftpl", {
    product_host        = module.instance_product.public_ip
    transportation_host = module.instance_transportation.public_ip
    garage_host         = module.instance_transportation.public_ip
    organization_host   = module.instance_organization.public_ip
    route_host          = module.instance_route.public_ip
    location_host       = module.instance_route.public_ip
    healthcheck_host    = module.instance_healthcheck.public_ip
    job_host            = module.instance_job.public_ip
    billing_host        = module.instance_billing.public_ip
    auth_host           = module.instance_auth.public_ip
    user_host           = module.instance_user.public_ip
  })
}