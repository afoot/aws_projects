output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region us-east-1 update-kubeconfig --name ${module.eks.cluster_name}"
}