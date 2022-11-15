config_path = "~/.kube/config"
k8s_context = "arn:aws:eks:eu-central-1:{{ Account_ID }}:cluster/{{ Cluster_name }}"

host               = "example.com"
namespace          = "namespace-x"
ingress_class_name = "alb"

labels = {
  name = "service-a"
}
annotations = {
  "alb.ingress.kubernetes.io/tags"   = "CostCenter=12345"
  "alb.ingress.kubernetes.io/scheme" = "internal"
  #  "alb.ingress.kubernetes.io/group.name"              = "demo.ingress-internal-group"
  "alb.ingress.kubernetes.io/ssl-policy" = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  #  "alb.ingress.kubernetes.io/certificate-arn"         = "{{ Certificate_ARN }}"
  "alb.ingress.kubernetes.io/target-group-attributes" = "stickiness.enabled=true,stickiness.lb_cookie.duration_seconds=3600"
}
service = {
  name      = "service-a"
  port      = { number = 80 }
  path      = "/*"
  path_type = "Prefix"
}
default_backend = {
  service_name = "default-http-backend"
  port_number  = 80
}
additional_services = [
  {
    name      = "ssl-redirect"
    port      = { name = "use-annotation" }
    path      = "/*"
    path_type = "ImplementationSpecific"
  }
]
