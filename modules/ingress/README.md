## Kubernetes ingress module
Usage
```terraform
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
```
### Input parameters
| Parameter Name      | Description                                          | Type       | Required/Optional   | Default Value                                                                                                                                                                       |
|---------------------|------------------------------------------------------|------------|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| config_path         | K8s config file path                                 | `string`   | Optional            | `~/.kube/config`                                                                                                                                                                    |
| k8s_context         | K8s context name                                     | `string`   | Required            |                                                                                                                                                                                     |
| namespace           | K8s namespace                                        | `string`   | Required            |                                                                                                                                                                                     |
| ingress_class_name  | Ingress class name                                   | `string`   | Required            |                                                                                                                                                                                     |
| labels              | Labels for ingress resource                          | `map(any)` | Optional            | `{}`                                                                                                                                                                                |
| annotations         | Annotations for ingress resource                     | `map(any)` | Required            |                                                                                                                                                                                     |
| host                | Name of the host                                     | `string`   | Required            |                                                                                                                                                                                     |
| service             | Service details to create ingress resource           | `object`   | Required            |                                                                                                                                                                                     |
| default_backend     | Default backend details to create ingress resource   | `object`   | Optional            | <pre>{<br>  service_name = "default-http-backend"<br>  port_number  = 80 <br>}</pre>                                                                                                |
| additional_services | List of additional services to create ingress rules  | `object`   | Optional            | <pre>[<br>  {<br>    name      = "ssl-redirect"<br>    port      = { name = "use-annotation" }<br>    path      = "/"<br>    path_type = "ImplementationSpecific"<br>  }<br>]</pre> | 

Service object will look like below

_**Note**: Regex is not allowed is `path_type` is Prefix._

```terraform
service = {
  name      = "myapp"
  port      = { number = 80 }
  path      = "/"
  path_type = "Prefix"
}
```
Additional services object will look like below

_**Note**: Regex is not allowed is `path_type` is Prefix._
```terraform
additional_services = [
  {
    name      = "ssl-redirect"
    port      = { name = "use-annotation" }
    path      = "/*"
    path_type = "ImplementationSpecific"
  },
  {
    name      = "myapp"
    port      = { number = 80 }
    path      = "/*"
    path_type = "ImplementationSpecific"
  }
]
```
### Output parameters
| Name                   | Description       |  
|------------------------|-------------------|
| load_balancer_hostname | Load balancer url | 


### Example
```terraform
module "dns" {
  source = "./modules/ingress"

  config_path = "~/.kube/config"
  k8s_context = "my-eks-sandbox-cluster"

  namespace = "default"
  labels    = {}
  annotations = {
    "alb.ingress.kubernetes.io/tags"            = "CostCenter=12345"
    "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
    "alb.ingress.kubernetes.io/group.name"      = "demo.ingress-default-group"
    "alb.ingress.kubernetes.io/certificate-arn" = " {{ Certificate_ARN }}"
  }
  ingress_class_name = "alb"
  host               = "myapp.example.com"
  service = {
    name      = "myapp"
    port      = { number = 80 }
    path      = "/"
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
    },
    {
      name      = "myapp"
      port      = { number = 80 }
      path      = "/*"
      path_type = "ImplementationSpecific"
    }
  ]
}
```
