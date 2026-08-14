# ---------------------------------------------------------------------------
# Azure Container Registry
# ---------------------------------------------------------------------------
resource "azurerm_container_registry" "weather" {
  name                = "${var.label_prefix}weatheracr"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku           = "Basic"
  admin_enabled = false

  tags = var.tags
}

# ---------------------------------------------------------------------------
# Test AKS can pull images from ACR
# ---------------------------------------------------------------------------
resource "azurerm_role_assignment" "test_acr_pull" {
  scope                = azurerm_container_registry.weather.id
  role_definition_name = "AcrPull"
  principal_id         = var.test_kubelet_identity_object_id
}

# ---------------------------------------------------------------------------
# Production AKS can pull images from ACR
# ---------------------------------------------------------------------------
resource "azurerm_role_assignment" "prod_acr_pull" {
  scope                = azurerm_container_registry.weather.id
  role_definition_name = "AcrPull"
  principal_id         = var.prod_kubelet_identity_object_id
}

# ---------------------------------------------------------------------------
# Redis cache - test environment
# ---------------------------------------------------------------------------
resource "azurerm_redis_cache" "test" {
  name                = "${var.label_prefix}-test-redis"
  location            = var.location
  resource_group_name = var.resource_group_name

  capacity = 0
  family   = "C"
  sku_name = "Basic"

  redis_version        = "6"
  minimum_tls_version  = "1.2"
  non_ssl_port_enabled = false

  redis_configuration {}

  tags = merge(var.tags, {
    Environment = "test"
  })
}

# ---------------------------------------------------------------------------
# Redis cache - production environment
# ---------------------------------------------------------------------------
resource "azurerm_redis_cache" "prod" {
  name                = "${var.label_prefix}-prod-redis"
  location            = var.location
  resource_group_name = var.resource_group_name

  capacity = 0
  family   = "C"
  sku_name = "Basic"

  redis_version        = "6"
  minimum_tls_version  = "1.2"
  non_ssl_port_enabled = false

  redis_configuration {}

  tags = merge(var.tags, {
    Environment = "prod"
  })
}

# ---------------------------------------------------------------------------
# Create Kubernetes Deployment script 
# ---------------------------------------------------------------------------

resource "kubernetes_namespace" "test_namespace" {
  provider = kubernetes.test
  metadata {
    name = "test_cst8918"
  }
}

resource "kubernetes_deployment" "test_k8_deployment" {
  provider = kubernetes.test  
  metadata {
    name = "Weather-app-deployment"
    namespace = kubernetes_namespace.test_namespace.metadata[0].name
    labels = {app="weather-app"}    
  }
  spec {
    relicas = 1
    selector {
      match_labels = {app = "weather-app"}
    }
    template {
      metadata {
        labels = { app = "weather-app" }
      }
      spec {
        container {
          name  = "weather-app-container"
          image = "${azurerm_container_registry.acr.login_server}/weather-app:latest"

          port {
            container_port = 8080
          }

          env {
            name = "WEATHER_API_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.weather_app_secrets.metadata[0].name
                key  = "WEATHER_API_KEY"
              }
            }
          }
          env {
            name = "REDIS_URL"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.weather_app_secrets.metadata[0].name
                key  = "REDIS_URL"
              }
            }
          }
          env {
            name = "REDIS_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.weather_app_secrets.metadata[0].name
                key  = "REDIS_PASSWORD"
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


# ---------------------------------------------------------------------------
# Create Kubernetes Deployment script 
# ---------------------------------------------------------------------------

resource "kubernetes_namespace" "prod_namespace" {
  provider = kubernetes.prod
  metadata {
    name = "prod_cst8918"
  }
}

resource "kubernetes_deployment" "prod_k8_deployment" {
  provider = kubernetes.prod
  metadata {
    name = "Weather-app-deployment"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels = {app="weather-app"}    
  }
  spec {
    relicas = 1
    selector {
      match_labels = {app = "weather-app"}
    }
    template {
      metadata {
        labels = { app = "weather-app" }
      }
      spec {
        container {
          name  = "weather-app-container"
          image = "${azurerm_container_registry.acr.login_server}/weather-app:latest"

          port {
            container_port = 8080
          }

          env {
            name = "WEATHER_API_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.weather_app_secrets.metadata[0].name
                key  = "WEATHER_API_KEY"
              }
            }
          }
          env {
            name = "REDIS_URL"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.weather_app_secrets.metadata[0].name
                key  = "REDIS_URL"
              }
            }
          }
          env {
            name = "REDIS_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.weather_app_secrets.metadata[0].name
                key  = "REDIS_PASSWORD"
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