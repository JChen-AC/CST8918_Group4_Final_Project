variable "resource_group_name" {
  description = "Name of the shared project resource group"
  type        = string
}

variable "location" {
  description = "Azure region for application resources"
  type        = string
}

variable "label_prefix" {
  description = "Prefix used for Azure resource names"
  type        = string
}

variable "test_kubelet_identity_object_id" {
  description = "Object ID of the test AKS kubelet identity"
  type        = string
}

variable "prod_kubelet_identity_object_id" {
  description = "Object ID of the production AKS kubelet identity"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}
variable "weather_api_key" {
  description = "API key for the weather service, injected into the app as a secret"
  type        = string
  sensitive   = true
}