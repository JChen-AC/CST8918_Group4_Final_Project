# CST8918 Group 4 Final Project

## Project Description
This repository contains the Infrastructure as Code (IaC) for the CST8918 final project.

The team is recreating the Remix Weather application environment on Azure using Terraform modules and automated workflows. The infrastructure is split into focused Terraform stacks for backend state resources, shared networking, and frontend resources.

## Team Members
| Name | Student Number | GitHub Profile |
| --- | --- | --- |
| Corey Mark-Stewart | 040 770 982 | [CoreyCauterize](https://github.com/CoreyCauterize) |
| Joshua Chen |  | [JChen-AC](https://github.com/JChen-AC) |
| Naveed Hossain |  | [NaveedHossain2026](https://github.com/NaveedHossain2026) |
| Hesheng Yang |  | [GitHub Profile (to be confirmed)](https://github.com/) |

## Special Instructions for Running the Project

### Prerequisites
- Terraform 1.1.0 or newer
- Azure subscription access
- Azure CLI installed and authenticated (`az login`)

### Repository Layout
- `infra/tf-backend`: Creates backend resource group and storage account used for Terraform state.
- `infra/tf-network`: Creates shared project resource group, virtual network, and environment subnets.
- `infra/tf-frontend`: Creates frontend infrastructure resources.

### Recommended Apply Order
1. Apply `infra/tf-backend` first.
2. Apply `infra/tf-network` second.
3. Apply `infra/tf-frontend` last.

### Run Terraform in Each Stack
From the repository root, run the following per stack:

```powershell
cd infra/tf-backend
terraform init
terraform plan
terraform apply

cd ../tf-network
terraform init
terraform plan
terraform apply

cd ../tf-frontend
terraform init
terraform plan
terraform apply
```

### Notes
- Some stacks are configured with an `azurerm` backend and OIDC (`use_oidc = true`). Ensure your authentication method matches your environment (local or CI).
- Do not commit local Terraform state files (`*.tfstate` and `*.tfstate.backup`).

