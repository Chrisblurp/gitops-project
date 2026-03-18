# outputs.tf (keep as is)
output "cluster_name" {
  value = module.eks.cluster_name
}

# Add this helpful output too
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "configure_kubectl" {
  description = "Configure kubectl command"
  value       = "aws eks update-kubeconfig --region us-east-1 --name ${module.eks.cluster_name}"
}