resource "azurerm_public_ip" "ingress_public_ip" {
  name                = "ingressPublicIp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  domain_name_label   = "terraformhackaton"
  sku                 = "Standard"

  tags = {
    environment = "development"
  }

  depends_on = [azurerm_kubernetes_cluster.default]
}