# Configure the Azure Provider use the Default Subscription defined in the Azure CLI
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.32.0"
}
