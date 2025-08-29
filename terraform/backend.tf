terraform {
  backend "azurerm" {
    resource_group_name  = "rg-keycloak"        #rg for state
    storage_account_name = "kcstorageh"
    container_name       = "tfstate"
    key                  = "infra.tfstate"
    use_azuread_auth     = true
  }
}