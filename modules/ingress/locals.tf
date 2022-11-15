## Locals
locals {
  annotations = {
    "alb.ingress.kubernetes.io/target-group-attributes" = "stickiness.enabled=true,stickiness.lb_cookie.duration_seconds=3600"
    "alb.ingress.kubernetes.io/ssl-policy"              = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
    "alb.ingress.kubernetes.io/listen-ports"            = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
    "alb.ingress.kubernetes.io/actions.ssl-redirect"    = "{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
  }
  labels = {
    "app.kubernetes.io/name" = var.service["name"]
  }
  port = var.service["port"]["number"] != null ? var.service["port"]["number"] : 80
  services = concat(
    [{
      name = var.service["name"],
      port = {
        number = var.service["port"]["number"] != null ? var.service["port"]["number"] : 80
      },
      path      = var.service["path"],
      path_type = var.service["path_type"]
    }],
    var.additional_services
  )
}