resource "random_pet" "prefix" {}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.cluster.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = var.cluster.node_count
    vm_size         = var.cluster.vm_size
    os_disk_size_gb = var.cluster.vm_disk_size
  }

  service_principal {
    client_id     = var.service_principal.client_id
    client_secret = var.service_principal.client_secret
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "dev"
  }
}
