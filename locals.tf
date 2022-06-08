locals {
  name = var.name != null ? var.name : var.product

  virtual_router_name_set = var.virtual_router_name != null ? toset([var.virtual_router_name]) : toset([])
  virtual_node_name_set   = var.virtual_node_name != null ? toset([var.virtual_node_name]) : toset([])

  creator = "terraform"

  tags = merge(
    var.tags,
    {
      Name                                      = local.name
      "${var.organization}:billing:product"     = var.product
      "${var.organization}:billing:environment" = var.environment
      creator                                   = local.creator
      repo                                      = var.repo
    }
  )
}
