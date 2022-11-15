## Modules
module "ingress" {
  source = "./modules/ingress"

  config_path = var.config_path
  k8s_context = var.k8s_context

  namespace           = var.namespace
  labels              = var.labels
  annotations         = var.annotations
  ingress_class_name  = var.ingress_class_name
  host                = var.host
  service             = var.service
  default_backend     = var.default_backend
  additional_services = var.additional_services
}

module "dns" {
  source = "./modules/dns"

  enable_dns_records = var.enable_dns_records
  dns_zone_id        = var.dns_zone_id
  host               = var.host
  record_type        = var.record_type
  record_ttl         = var.record_ttl
  addresses          = [module.ingress.load_balancer_hostname]
  allow_overwrite    = var.allow_overwrite
}