# ---------------------------------------------------------------------------
# Create Kubernetes Deployment script 
# ---------------------------------------------------------------------------

resource "kubernetes_namespace" "namespace" {
  provider = kubernetes
  metadata {
    name = "${var.env}-cst8918"
  }
}

resource "kubernetes_secret" "secret" {
  provider = kubernetes
  metadata {
    name      = "${var.env}-secrets-cst8918"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  data = {
    WEATHER_API_KEY = var.weather_api_key
    REDIS_URL       = var.redis_hostname
    REDIS_PASSWORD  = var.redis_primary_access_key
  REDIS_PORT = tostring(var.redis_ssl_port) }

  type = "Opaque"
}

resource "kubernetes_deployment" "k8_deployment" {
  provider = kubernetes
  metadata {
    name      = "weather-app-deployment"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels    = { app = "weather-app" }
  }
  spec {
    replicas = 1
    selector {
      match_labels = { app = "weather-app" }
    }
    template {
      metadata {
        labels = { app = "weather-app" }
      }
      spec {
        container {
          name  = "weather-app-container"
          image = "${var.acr_login_server}/weather-app:latest"

          port {
            container_port = 8080
          }

          env {
            name = "WEATHER_API_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.secret.metadata[0].name
                key  = "WEATHER_API_KEY"
              }
            }
          }
          env {
            name = "REDIS_URL"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.secret.metadata[0].name
                key  = "REDIS_URL"
              }
            }
          }
          env {
            name = "REDIS_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.secret.metadata[0].name
                key  = "REDIS_PASSWORD"
              }
            }
          }
          env {
            name = "REDIS_PORT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.secret.metadata[0].name
                key  = "REDIS_PORT"
              }
            }
          }
        }
      }
    }

  }
  lifecycle {
    ignore_changes = [
      spec[0].template[0].spec[0].container[0].image
    ]
  }
}


resource "kubernetes_service" "service" {
  provider = kubernetes

  metadata {
    name      = "weather-app-service"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "weather-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
