# =======================================================================
# GENERAL
provider "aws" { alias = "region" }
data "aws_region" "current" { provider = aws.region }

variable "instance_name" { default = "echo_server" }
variable "component" { default = "eks" }
variable "env_profile" { default = "stg" }
# EKS CLUSTER
variable "eks_version" { default = "1.19" }

# EKS NODE GROUP
variable "node_group_name" {
  default = "main_node_group"
}
variable "min_capacity" {
  default = 1
}
variable "max_capacity" {
  default = 1
}
variable "desired_capacity" {
  default = 1
}
variable "enable_irsa" {
  default = true
}
variable "volume_size" {
  default = 100
}
variable "instance_types" {
  default = [
    "t2.small"
  ]
}
# =======================================================================
# EKS NETWORKING CONFIGURATION #
variable "cluster_endpoint_private_access" {
  default = true
}
variable "cluster_endpoint_public_access" {
  default = false
}
# =======================================================================

variable "cluster_subnet_cidr" {
  default = [
    "10.10.1.0/28",
    "10.10.1.16/28"
  ]
}