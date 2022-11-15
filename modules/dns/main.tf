## Resources
resource "aws_route53_record" "this" {
  count           = var.enable_dns_records ? 1 : 0
  zone_id         = var.dns_zone_id
  name            = var.host
  type            = upper(var.record_type)
  ttl             = var.record_ttl
  records         = var.addresses
  allow_overwrite = var.allow_overwrite
}