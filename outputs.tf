## Outputs
output "load_balancer_hostname" {
  description = "Displays load balancer hostname (typically present in AWS)"
  value       = module.ingress.load_balancer_hostname
}

output "ingress_fqdn" {
  description = "FQDN for ingress."
  value       = var.enable_dns_records ? module.dns.fqdn : var.host
}