# =======================================================================
data "aws_vpc" "default" {
  default                   = true
}
# =======================================================================
module "cluster_subnet_sn" {
  source                    = "../modules/subnet"

  region                    = data.aws_region.current.name
  vpc_id                    =  data.aws_vpc.default.id
  instance_name             = "${var.instance_name}-cluster"
  env_profile               = var.env_profile
  component                 = var.component
  subnet_cidrs              = var.cluster_subnet_cidr
  map_public_ip_on_launch   = "false"
  count_index               = 2
}
# =======================================================================
module "eks_managed_sg" {
  source                    = "../modules/security_group"

  vpc_id                    = data.aws_vpc.default.id
  instance_name             = var.instance_name
  env_profile               = var.env_profile
  sg_description            = var.instance_name
}
# =======================================================================