# =======================================================================
variable "azs" {
  type = list(string)
  default = [
    "a",
    "c",
  ]
}

data "aws_region" "current" {}
# =======================================================================
resource "aws_subnet" "sn" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = format("%s%s", data.aws_region.current.name, var.azs[count.index])
  map_public_ip_on_launch = var.map_public_ip_on_launch

  count                   = var.count_index

  tags = {
    Name                  = "${var.env_profile}-${var.instance_name}-${upper(var.azs[count.index])}"
    environment           = var.env_profile
    managed_by            = "Terraform"
    owner                 = "Security"
    Datetime              = formatdate("DD MMMM YYYY hh:mm", timestamp())
  }

  lifecycle {
    ignore_changes        = [tags["Datetime"]]
  }
}
# =======================================================================
