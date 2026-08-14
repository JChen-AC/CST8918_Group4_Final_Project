output "test_aks_cluster_id" {
  description = "Resource ID of the test AKS cluster"
  value       = module.aks_test.cluster_id
}

output "test_aks_cluster_name" {
  description = "Name of the test AKS cluster"
  value       = module.aks_test.cluster_name
}

output "prod_aks_cluster_id" {
  description = "Resource ID of the production AKS cluster"
  value       = module.aks_prod.cluster_id
}

output "prod_aks_cluster_name" {
  description = "Name of the production AKS cluster"
  value       = module.aks_prod.cluster_name
}

output "test_kubelet_identity_object_id" {
  description = "Kubelet identity object ID for test AKS"
  value       = module.aks_test.kubelet_identity_object_id
}

output "test_kube_config" {
  description = "Test Kube Config"
  value       = module.aks_test.kube_config
}

output "prod_kubelet_identity_object_id" {
  description = "Kubelet identity object ID for production AKS"
  value       = module.aks_prod.kubelet_identity_object_id
}
output "prod_kube_config" {
  description = "Prod Kube Config"
  value       = module.aks_prod.kube_config
}