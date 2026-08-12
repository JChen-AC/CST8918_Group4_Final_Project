variable "name" {
  description = "A prefix to add to all resources"
  type        = string
}
variable "region" {
  description = "Location of the region"
  type        = string
  default     = "canadacentral"
}