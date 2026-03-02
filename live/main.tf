################################################################################
# Data Sources
################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

################################################################################
# Networking (Tier 1)
################################################################################

module "networking" {
  source = "../modules/networking"

  vpc_cidr           = var.vpc_cidr
  project_name       = var.project_name
  environment        = var.environment
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}

################################################################################
# Database (Tier 1)
################################################################################

module "database" {
  source = "../modules/database"

  vpc_id             = module.networking.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnet_ids = module.networking.private_subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  project_name       = var.project_name
  environment        = var.environment

}

################################################################################
# Application (Tier 2)
################################################################################

module "application" {
  source = "../modules/application"

  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  project_name      = var.project_name
  environment       = var.environment
  asg_min           = var.asg_min
  asg_max           = var.asg_max

}
