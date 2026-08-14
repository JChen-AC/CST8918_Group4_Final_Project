variable "acr_login_server" {
  description = "Login server URL of the Azure Container Registry (e.g. myregistry.azurecr.io), used to build the container image reference"
  type        = string
}

variable "env" {
  description = "Deployment environment (e.g. test, prod), used to namespace resources"
  type        = string
}

variable "weather_api_key" {
  description = "Common tags applied to resources"
  type        = string
  sensitive   = true
}

variable "redis_hostname" {
  description = "Hostname of the Redis cache used by the weather app"
  type        = string
}

variable "redis_primary_access_key" {
  description = "Primary access key for the Redis cache"
  type        = string
  sensitive   = true
}

variable "redis_ssl_port" {
  description = "SSL port for the Redis cache"
  type        = number
}