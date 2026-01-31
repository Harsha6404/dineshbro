module "vpc" {
  source = "../../modules/vpc"

  cidr = "10.0.0.0/16"
  name = "hotel-vpc"
}

module "subnets" {
  source = "../../modules/subnet"

  vpc_id = module.vpc.vpc_id

  public_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  azs = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

module "network" {
  source = "../../modules/network"

  vpc_id = module.vpc.vpc_id

  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}
