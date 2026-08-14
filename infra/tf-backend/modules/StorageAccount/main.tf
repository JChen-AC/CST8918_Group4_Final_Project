resource "azurerm_storage_account" "storage" {
  name                     = "${var.label_prefix}githubactions"
  location                 = var.region
  resource_group_name      = var.rg_name
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cold"
  min_tls_version          = "TLS1_2"
  tags = {
    Class      = "CST8918"
    Assignment = "Final-Project"
  }
}

resource "azurerm_storage_container" "container" {
  name               = "tfstate"
  storage_account_id = azurerm_storage_account.storage.id

}
