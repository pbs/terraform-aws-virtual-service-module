module "mesh" {
  source = "github.com/pbs/terraform-aws-app-mesh-module?ref=0.0.1"

  name = var.product

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

resource "aws_appmesh_virtual_router" "router" {
  name      = var.product
  mesh_name = module.mesh.id

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
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

  mesh_name           = module.mesh.id
  virtual_router_name = aws_appmesh_virtual_router.router.name

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
