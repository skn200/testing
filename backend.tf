terraform {
  backend "azurerm" {
    resource_group_name  = "TF-BKP-RG"
    storage_account_name = "sagtftest2"
    container_name       = "tfstate2"
    key                  = "my.terraform2.tfstate"
  }
}
