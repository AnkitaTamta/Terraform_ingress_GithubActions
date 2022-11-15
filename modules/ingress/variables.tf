## Variables
variable "config_path" {
  description = "A path to a kube config file. Can be sourced from KUBE_CONFIG_PATH."
  type        = string
  default     = "~/.kube/config"
}

variable "k8s_context" {
  description = "Context to choose from the config file. Can be sourced from KUBE_CTX."
  type        = string
}

variable "namespace" {
  description = "Namespace defines the space within which name of the service must be unique."
  type        = string
  default     = "default"
}

variable "labels" {
  description = "Map of string keys and values that can be used to organize and categorize (scope and select) the service. May match selectors of replication controllers and services."
  type        = map(any)
  default     = {}
}

variable "annotations" {
  description = "An unstructured key value map stored with the ingress that may be used to store arbitrary metadata."
  type        = map(any)
  default     = {}
}

variable "ingress_class_name" {
  description = "The ingress class name references an IngressClass resource that contains additional configuration including the name of the controller that should implement the class."
  type        = string
  default     = "alb"
}

variable "host" {
  description = "Host is the fully qualified domain name of a network host."
  type        = string
}

variable "service" {
  description = <<-EOT
    name: name of the service, must be unique. Cannot be updated once the resource is created,
    port: Specifies the port number of the referenced service. example {number = "80"},
    path: path that will be matched against the path of an incoming request,
    path_type: either of ImplementationSpecific, Exact, or Prefix.
  EOT
  type = object({
    name      = string
    port      = map(any)
    path      = string
    path_type = string
  })
}

variable "default_backend" {
  description = <<-EOT
    DefaultBackend is the backend that should handle requests that don't match any rule.
    If Rules are not specified, DefaultBackend must be specified.
    If DefaultBackend is not set, the handling of requests that do not match any of the rules will be up to the Ingress controller.
  EOT
  type = object({
    service_name = string
    port_number  = string
  })
  default = {
    service_name = "default-http-backend"
    port_number  = 80
  }
}

variable "additional_services" {
  description = <<-EOT
    List of additional services to be added in ingress rule
    name: name of the service, must be unique. Cannot be updated once the resource is created,
    port: Specifies the port number or name of the referenced service. example {number = "80"} or {name = "http"},
    path: path that will be matched against the path of an incoming request,
    path_type: either of ImplementationSpecific, Exact, or Prefix.
  EOT
  type = list(object({
    name      = string
    port      = map(any)
    path      = string
    path_type = string
  }))
  default = [
    {
      name      = "ssl-redirect"
      port      = { name = "use-annotation" }
      path      = "/"
      path_type = "ImplementationSpecific"
    },
  ]
}


