output "cluster_name" {
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
}

output "node_group_names" {
  value = keys(module.eks.eks_managed_node_groups)
}

#gives full kubeconfig YAML for the EKS cluster to connect
output "kubeconfig" {
  value       = module.eks.kubeconfig
}


# another way to connect with the aws cluster

# output "eks_update_kubeconfig_command" {
#   description = "AWS CLI command to update kubeconfig for the EKS cluster"
#   value       = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_id}"
# }
