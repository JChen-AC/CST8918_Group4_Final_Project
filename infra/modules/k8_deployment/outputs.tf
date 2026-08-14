output "namespace" {
  description = "Name of the Kubernetes namespace created for this environment"
  value       = kubernetes_namespace.namespace.metadata[0].name
}

output "deployment_name" {
  description = "Name of the Kubernetes deployment"
  value       = kubernetes_deployment.k8_deployment.metadata[0].name
}

output "service_name" {
  description = "Name of the Kubernetes service"
  value       = kubernetes_service.service.metadata[0].name
}

output "service_cluster_ip" {
  description = "Internal cluster IP of the weather app service"
  value       = kubernetes_service.service.spec[0].cluster_ip
}

output "secret_name" {
  description = "Name of the Kubernetes secret holding app credentials"
  value       = kubernetes_secret.secret.metadata[0].name
}