
This repository contains 
- Generic terraform modules required to create 
  - Kubernetes' ingress resource
  - AWS route53 dns record
- Directory Structure to have separate terraform `.tfvar` files for each service that needs ingress

```
├── README.md
|
├── environments
│   ├── cluster-name-1-eu-central-1
│   │   └── myapp-mynamespace-ingress.tfvars
|   │ 
│   └── cluster-name-2-integration-instance-eu-central-1
│       └── myservice.default-ingress.tfvars
|   
├── modules
│   ├── dns
│   │   ├── README.md
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── ingress
│       ├── README.md
│       ├── locals.tf
│       ├── main.tf
│       ├── output.tf
│       ├── provider.tf
│       └── variables.tf
|   
├── main.tf
├── outputs.tf
├── terraform.tf
└── variables.tf
```

### Module Documentation:
- [Kubernetes Ingress](./modules/ingress/README.md)
- [Route54 Records](./modules/ingress/README.md)