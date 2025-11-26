output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "CA data for the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "node_group_names" {
  value = keys(module.eks.eks_managed_node_groups)
}
