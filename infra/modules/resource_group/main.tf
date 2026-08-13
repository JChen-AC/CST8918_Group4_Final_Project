resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.region
  tags = {
    Class      = "CST8918"
    Assignment = "Final-Project"
  }
}
