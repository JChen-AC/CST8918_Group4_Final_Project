output "acr_name" {
  description = "Azure Container Registry name"
  value       = module.weather_resources.acr_name
}

output "acr_login_server" {
  description = "Azure Container Registry login server"
  value       = module.weather_resources.acr_login_server
}

output "test_redis_hostname" {
  description = "Test Redis hostname"
  value       = module.weather_resources.test_redis_hostname
}

output "test_redis_ssl_port" {
  description = "Test Redis SSL port"
  value       = module.weather_resources.test_redis_ssl_port
}

output "prod_redis_hostname" {
  description = "Production Redis hostname"
  value       = module.weather_resources.prod_redis_hostname
}

output "prod_redis_ssl_port" {
  description = "Production Redis SSL port"
  value       = module.weather_resources.prod_redis_ssl_port
}