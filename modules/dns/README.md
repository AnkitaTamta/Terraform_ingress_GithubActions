## Route53 record module
Usage
```terraform
module "dns" {
  source = "./modules/dns"

  enable_dns_records = var.enable_dns_records
  dns_zone_id        = var.dns_zone_id
  host               = var.host
  record_type        = var.record_type
  record_ttl         = var.record_ttl
  addresses          = var.addresses
  allow_overwrite    = var.allow_overwrite
}
```
### Input parameters
| Parameter Name     | Description                    | Type           | Required/Optional                         | Default Value |
|--------------------|--------------------------------|----------------|-------------------------------------------|---------------|
| enable_dns_records | Enable or Disable DNS records  | `bool`         | Optional                                  | `false`       |
| dns_zone_id        | Hosted zone id                 | `string`       | Required (if `enable_dns_records = true`) |               |
| host               | Hostname for DNS record        | `string`       | Required (if `enable_dns_records = true`) |               |
| record_type        | Record Type (A, CNAME,..etc)   | `string`       | Optional                                  | `CNAME`       |
| record_ttl         | TTL for record                 | `number`       | Optional                                  | `300`         |
| addresses          | List of addresses              | `list(string)` | Required (if `enable_dns_records = true`) |               |
| allow_overwrite    | Allow overwrite DNS records    | `bool`         | Optional                                  | `false`       |

### Output parameters

| Name | Description                               | 
|------|-------------------------------------------|
| name | Name of the route53 record                | 
| fqdn | FQDN built using the zone domain and name | 

### Example
```terraform
module "dns" {
  source = "./modules/dns"

  enable_dns_records = true
  dns_zone_id        = "ZZ576GTR78B"
  host               = "myapp.example.com"
  record_type        = "CNAME"
  record_ttl         = 60
  addresses          = ["k8s-myapp-prod-1234d12345-0123456789.eu-central-1.elb.amazonaws.com"]
  allow_overwrite    = false
}
```
