# Outputs
output "load_balancer_hostname" {
  description = "Displays load balancer hostname (typically present in AWS)"
  value       = kubernetes_ingress_v1.this.status[0].load_balancer[0].ingress[0].hostname
}