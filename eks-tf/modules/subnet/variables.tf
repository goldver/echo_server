variable "region" {}
variable "vpc_id" {}
variable "subnet_cidrs" {
  type = list(string)
}

variable "instance_name" {}
variable "env_profile" {}
variable "component" {}

variable "map_public_ip_on_launch" {}

variable "count_index" {
  default = 1
}




