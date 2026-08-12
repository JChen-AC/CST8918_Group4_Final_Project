resource "azurerm_resource_group" "rg" {
  name     = "${var.label_prefix}-githubactions-rg"
  location = var.region
  tags = {
    Class      = "CST8918"
    Assignment = "Final-Project"    
  }
}
