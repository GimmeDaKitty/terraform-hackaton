resource "kubernetes_ingress_v1" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name      = "ingress"
    namespace = kubernetes_namespace.terraform.metadata[0].name
  }

  spec {

    ingress_class_name = var.ingress.className

    # default_backend {
    #   service {
    #     name = kubernetes_service_v1.example.metadata.0.name
    #     port {
    #       number = 8080
    #     }
    #   }
    # }

    rule {
      host = "terraformhackaton.westeurope.cloudapp.azure.com"
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.example.metadata.0.name
              port {
                number = 80
              }
            }
          }

          path = "/"
        }
      }
    }

    # tls {
    #   secret_name = "tls-secret"
    # }
  }
}