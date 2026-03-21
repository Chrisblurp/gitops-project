resource "azurerm_resource_group" "rg" {
  name     = "gitops-rg"
  location = "westeurope"
}

resource "azurerm_container_registry" "acr" {
  name                = "gitopsacr123456" 
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "devops-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "gitops"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b2s_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
