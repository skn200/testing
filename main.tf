# Create a resource group
resource "azurerm_resource_group" "infra" {
  name     = skn-rg-1
  location = eastus
}
