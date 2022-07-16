variable "vpc_id" {}

variable "instance_name" {}
variable "env_profile" {}
variable "component" {
  default = "ec2"
}

variable "sg_description" {}

variable "sg_rule_type" {
  description = "Type of Security Group: ingress"
  default = "ingress"
}
variable "sec_group_rules_list" {
  description = "Rules list we want to add"
  default = []
}
variable "sec_group_rules_source_sgs" {
  description = "Security group list we want to add"
  default = []
}



