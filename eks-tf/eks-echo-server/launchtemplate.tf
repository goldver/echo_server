# =======================================================================
resource "aws_launch_template" "default" {
  name_prefix            = "launch_template_1"
  description            = "Default Launch-Template"
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.volume_size
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = concat(module.eks_managed_sg.instance_sg, [
      module.cluster_nodes.cluster_primary_security_group_id
    ])
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      CustomTag = "Instance custom tag"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      CustomTag = "Volume custom tag"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      CustomTag = var.instance_name
    }
  }

  # Tag the LT itself
  tags = {
    CustomTag = "Launch template custom tag"
  }

  lifecycle {
    create_before_destroy = true
  }
}
# =======================================================================
