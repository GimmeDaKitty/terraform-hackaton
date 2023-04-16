resource "helm_release" "nginx_ingress" {
  name       = var.ingress.name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.6.0"
  namespace  = kubernetes_namespace.terraform.metadata[0].name

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "controller.ingressClass"
    value = var.ingress.className
  }
  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress.className
  }
  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.ingress_public_ip.ip_address
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "rbac.createClusterRole"
    value = "true"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = var.resource_group_name
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }

  set {
    name  = "controller.healthStatus"
    value = false
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"
  }

  depends_on = [azurerm_kubernetes_cluster.default, azurerm_public_ip.ingress_public_ip, kubernetes_namespace.terraform]
}