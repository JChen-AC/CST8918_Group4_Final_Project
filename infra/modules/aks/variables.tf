variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where AKS will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID used by the AKS default node pool"
  type        = string
}

variable "vm_size" {
  description = "VM size for the AKS system node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "node_count" {
  description = "Fixed node count when autoscaling is disabled"
  type        = number
  default     = 1
}

variable "auto_scaling_enabled" {
  description = "Whether cluster autoscaling is enabled"
  type        = bool
  default     = false
}

variable "min_count" {
  description = "Minimum number of nodes when autoscaling is enabled"
  type        = number
  default     = null
}

variable "max_count" {
  description = "Maximum number of nodes when autoscaling is enabled"
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags applied to the AKS cluster"
  type        = map(string)
  default     = {}
}

variable "service_cidr" {
  type        = string
  description = "CIDR for Kubernetes internal services (must not overlap the VNet)"
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within service_cidr used for cluster DNS"
}