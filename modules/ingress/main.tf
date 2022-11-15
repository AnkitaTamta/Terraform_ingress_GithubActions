## Resources
resource "kubernetes_ingress_v1" "this" {
  metadata {
    name        = var.service["name"]
    namespace   = var.namespace
    labels      = merge(local.labels, var.labels)
    annotations = merge(local.annotations, var.annotations)
  }

  spec {
    ingress_class_name = var.ingress_class_name

    default_backend {
      service {
        name = var.default_backend["service_name"]
        port {
          number = var.default_backend["port_number"]
        }
      }
    }

    rule {
      host = var.host
      http {
        dynamic "path" {
          for_each = toset(local.services)
          iterator = service
          content {
            backend {
              service {
                name = service.value.name
                port {
                  number = lookup(service.value.port, "number", null)
                  name   = lookup(service.value.port, "name", null)
                }
              }
            }
            path      = service.value.path
            path_type = service.value.path_type
          }
        }
      }
    }
  }

  wait_for_load_balancer = true
  lifecycle {
    ignore_changes = [
      metadata[0].annotations["field.cattle.io/publicEndpoints"],
    ]
  }
}

