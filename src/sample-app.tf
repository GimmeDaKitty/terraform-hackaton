resource "kubernetes_deployment" "sample_app" {
  metadata {
    name      = "sample-app"
    namespace = kubernetes_namespace.terraform.metadata[0].name
    labels = {
      app = "sample-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "sample-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "sample-app"
        }
      }

      spec {
        container {
          image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
          name  = "helloworld"
          port {
            container_port = 80
            name           = "sample-app"
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "example" {
  metadata {
    name      = "sample-app"
    namespace = kubernetes_namespace.terraform.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.sample_app.metadata.0.name
    }
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
  }
}