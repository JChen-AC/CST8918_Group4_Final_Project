variable "label_prefix" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "cst8918grp4"
}

variable "region" {
  description = "Location of the region"
  type        = string
  default     = "canadacentral"
}
variable "weather_api_key" {
  description = "API key for the weather service, injected into the app as a secret"
  type        = string
  sensitive   = true
}