# PBS TF Virtual Service Module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-virtual-service-module?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions an App Mesh virtual service that fronts a virtual router or a virtual node.

If your service is relatively simple you'll likely want to use a virtual node backend. If you would like to provide more complicated routing to the compute backing your virtual service, you'll want to use a virtual router backend.

Integrate this module like so:

### Virtual Node Example

```hcl
module "virtual-service" {
  source = "github.com/pbs/terraform-aws-virtual-service-module?ref=x.y.z"

  mesh_name = module.mesh.id

  virtual_node_name = aws_appmesh_virtual_node.node.name

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

### Virtual Router Example

```hcl
module "virtual-service" {
  source = "github.com/pbs/terraform-aws-virtual-service-module?ref=x.y.z"

  mesh_name = module.mesh.id

  virtual_router_name = aws_appmesh_virtual_router.router.name

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
