## Outputs
output "name" {
  description = "The name of the route53 record."
  value       = aws_route53_record.this[0].name
}

output "fqdn" {
  description = "The fqdn built using the zone domain and name"
  value       = aws_route53_record.this[0].fqdn
}
