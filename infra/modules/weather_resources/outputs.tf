output "acr_id" {
  description = "Resource ID of the Azure Container Registry"
  value       = azurerm_container_registry.weather.id
}

output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.weather.name
}

output "acr_login_server" {
  description = "Login server of the Azure Container Registry"
  value       = azurerm_container_registry.weather.login_server
}

output "test_redis_hostname" {
  description = "Hostname of the test Redis cache"
  value       = azurerm_redis_cache.test.hostname
}

output "test_redis_ssl_port" {
  description = "SSL port of the test Redis cache"
  value       = azurerm_redis_cache.test.ssl_port
}

output "prod_redis_hostname" {
  description = "Hostname of the production Redis cache"
  value       = azurerm_redis_cache.prod.hostname
}

output "prod_redis_ssl_port" {
  description = "SSL port of the production Redis cache"
  value       = azurerm_redis_cache.prod.ssl_port
}