module "mesh" {
  source = "github.com/pbs/terraform-aws-app-mesh-module?ref=0.0.1"

  name = var.product

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

resource "aws_appmesh_virtual_node" "node" {
  name      = var.product
  mesh_name = module.mesh.id

  spec {
    backend {
      virtual_service {
        virtual_service_name = "node.${var.product}.local"
      }
    }
  }

  tags = {
    organization = var.organization
    environment  = var.environment
    product      = var.product
    repo         = var.repo
  }
}

module "virtual_service" {
  source = "../.."

  mesh_name         = module.mesh.id
  virtual_node_name = aws_appmesh_virtual_node.node.name

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
