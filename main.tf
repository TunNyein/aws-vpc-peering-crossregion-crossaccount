
##############################################################
##### VPC Module
##############################################################

module "vpc-A" {

  source = "./modules/vpc-a"

  providers = {
    aws = aws.account-A
  }

  vpc_cidr_address_space  = var.vpcs.vpc-a.vpc_cidr_address_space
  vpc_prefix              = var.vpcs.vpc-a.vpc_prefix
  vpc_environment         = var.vpcs.vpc-a.vpc_environment
  vpc_public_subnet_cidr  = var.vpcs.vpc-a.vpc_public_subnet_cidr
  
  instance_type           = var.vpcs.vpc-a.instance_type

}


module "vpc-B" {

  source = "./modules/vpc-b"

  providers = {
    aws = aws.account-A
  }

  vpc_cidr_address_space  = var.vpcs.vpc-b.vpc_cidr_address_space
  vpc_prefix              = var.vpcs.vpc-b.vpc_prefix
  vpc_environment         = var.vpcs.vpc-b.vpc_environment
  
  vpc_private_subnet_cidr = var.vpcs.vpc-b.vpc_private_subnet_cidr
  instance_type           = var.vpcs.vpc-b.instance_type

}


module "vpc-C" {

  source = "./modules/vpc-c"

  providers = {
    aws = aws.account-B
  }

  vpc_cidr_address_space  = var.vpcs.vpc-c.vpc_cidr_address_space
  vpc_prefix              = var.vpcs.vpc-c.vpc_prefix
  vpc_environment         = var.vpcs.vpc-c.vpc_environment
  
  vpc_private_subnet_cidr = var.vpcs.vpc-c.vpc_private_subnet_cidr
  instance_type           = var.vpcs.vpc-c.instance_type

}
