terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "mck-sandbox"
}

module "instance_key_pair" {
  source = "./modules/key_pair"

  key_pair_name = "th_key_pair_v2"
}

module "instance_registry" {
  source = "./modules/instance"

  key_pair_name = module.instance_key_pair.key_pair_name
  instance_name = "th-registry"
}

module "instance_auth" {
  source = "./modules/instance"

  key_pair_name = module.instance_key_pair.key_pair_name
  instance_name = "th-auth"
}

# module "instance_product" {
#   source = "./modules/instance"

#   key_pair_name = module.instance_key_pair.key_pair_name
#   instance_name = "th-product"
# }

# module "instance_transportation" {
#   source = "./modules/instance"

#   key_pair_name = module.instance_key_pair.key_pair_name
#   instance_name = "th-transportation"
# }

# module "instance_orgarnization" {
#   source = "./modules/instance"

#   key_pair_name = module.instance_key_pair.key_pair_name
#   instance_name = "th-orgarnization"
# }

# module "instance_route" {
#   source = "./modules/instance"

#   key_pair_name = module.instance_key_pair.key_pair_name
#   instance_name = "th-route"
# }

# module "instance_user" {
#   source = "./modules/instance"

#   key_pair_name = module.instance_key_pair.key_pair_name
#   instance_name = "th-user"
# }

