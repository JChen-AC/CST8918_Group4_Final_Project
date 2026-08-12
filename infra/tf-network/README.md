# infra/tf-network

Creates the shared project resource group, VNet, and four environment subnets.

## ⚠️ Temporary: working without shared backend access

Backend access issues are still being sorted out on the team's end. Per
Josh: work locally with your own resource group / local state for now, then
send the final code over once it's confirmed working. The `backend "azurerm"`
block in `providers.tf` is currently commented out for this reason — Terraform
will use local state (a `.tfstate` file on your machine) instead.

**Before merging to main**, uncomment the backend block in `providers.tf` and
delete any local `.tfstate`/`.tfstate.backup` files (don't commit them —
they're already covered by `.gitignore`, but double check).

## ⚠️ Resource Group ownership — team note

This component creates the **canonical shared resource group**
(`cst8918-final-project-group-4`) for the whole project, per the assignment
spec (Networking owns resource group creation).

`infra/tf-frontend/main.tf` currently *also* creates a resource with this
same name via its own `module "frontendresourcegroup"` call. That will
conflict with this one — two separate Terraform states can't both "own" a
resource group with the same name in Azure.

**Fix needed on the frontend side:** swap that module call for a lookup of
the existing resource group instead of creating a new one.

## Resources created

- Resource group: `cst8918-final-project-group-4`
- VNet: `10.0.0.0/14`
- Four subnets, one per environment (prod 10.0.0.0/16, test 10.1.0.0/16, dev 10.2.0.0/16, admin 10.3.0.0/16)

## Usage

```bash
cd infra/tf-network
terraform init
terraform plan
terraform apply
```

## Outputs

resource_group_name, vnet_id, vnet_name, subnet_ids (map of env → subnet ID), subnet_address_prefixes (map of env → CIDR)