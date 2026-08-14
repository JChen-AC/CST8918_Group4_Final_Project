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
# Weather app deployment - test environment
# ---------------------------------------------------------------------------
module "weather_app_test" {
  source = "../k8_deployment"

  providers = {
    kubernetes = kubernetes.test
  }

  env              = "test"
  acr_login_server = azurerm_container_registry.weather.login_server
  weather_api_key  = var.weather_api_key

  redis_hostname           = azurerm_redis_cache.test.hostname
  redis_primary_access_key = azurerm_redis_cache.test.primary_access_key
  redis_ssl_port           = azurerm_redis_cache.test.ssl_port
}

# ---------------------------------------------------------------------------
# Weather app deployment - production environment
# ---------------------------------------------------------------------------
module "weather_app_prod" {
  source = "../k8_deployment"

  providers = {
    kubernetes = kubernetes.prod
  }

  env              = "prod"
  acr_login_server = azurerm_container_registry.weather.login_server
  weather_api_key  = var.weather_api_key

  redis_hostname           = azurerm_redis_cache.prod.hostname
  redis_primary_access_key = azurerm_redis_cache.prod.primary_access_key
  redis_ssl_port           = azurerm_redis_cache.prod.ssl_port
}