# =======================================================================
data "aws_caller_identity" "current" {}
# =======================================================================
module "cluster_nodes" {
  source                          = "../modules/terraform-aws-eks"

  cluster_name                    = "${var.instance_name}-cluster"
  cluster_version                 = var.eks_version
  vpc_id                          = "vpc-098e49b6a2557a7d3" #module.global.vpc_id
  subnets                         = module.cluster_subnet_sn.sn
  manage_aws_auth                 = false
  map_roles                       = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/EKSNodeRole-${var.instance_name}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = [
        "system:bootstrappers",
        "system:nodes"
      ]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/okta-devops"
      username = "designated_role"
      groups   = ["system:masters"]
    }
  ]

  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_enabled_log_types       = [
    "api",
    "audit",
    "authenticator",
    "scheduler",
    "controllerManager"
  ]

   node_groups = {
      node_group_1 = {
         name_prefix                = var.node_group_name
         min_capacity               = var.min_capacity
         desired_capacity           = var.desired_capacity
         max_capacity               = var.max_capacity

         launch_template_id         = aws_launch_template.default.id
         launch_template_version    = aws_launch_template.default.default_version

         instance_types             = var.instance_types

         tags = [
            {
              "key"                 = "k8s.io/cluster-autoscaler/enabled"
              "propagate_at_launch" = "false"
              "value"               = "true"
            },
            {
              "key"                 = "k8s.io/cluster-autoscaler/${var.instance_name}"
              "propagate_at_launch" = "false"
              "value"               = "owned"
            }
         ]
      }
   }

  cluster_tags = {
    env        = var.env_profile
    managed_by = "Terraform"
    owner      = "DevOps"
  }
}
# =======================================================================
