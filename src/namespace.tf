resource "kubernetes_namespace" "terraform" {
  metadata {
    annotations = {
      name = "terraform"
    }

    labels = {
      mylabel = "terraform"
    }

    name = "terraform"
  }

  depends_on = [azurerm_kubernetes_cluster.default]
}