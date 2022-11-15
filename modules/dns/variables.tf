## Variables
variable "enable_dns_records" {
  description = "Allow to add records in route53"
  type        = bool
  default     = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_dns_records))
    error_message = "[Error]: Value must be either true or false."
  }
}

variable "dns_zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
}

variable "host" {
  description = "The hostname or name of the record."
  type        = string
}


variable "record_type" {
  description = "The record type"
  type        = string
  default     = "CNAME"
  validation {
    condition     = contains(["A", "AAAA", "CAA", "CNAME", "DS", "MX", "NAPTR", "NS", "PTR", "SOA", "SPF", "SRV", "TXT"], upper(var.record_type))
    error_message = "[Error]: Valid record types are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT."
  }
}

variable "record_ttl" {
  description = "The TTL of the record."
  type        = number
  default     = 300
  validation {
    condition     = can(regex("^[0-9]+$", var.record_ttl))
    error_message = "[Error]: Value must be a whole number."
  }
}

variable "addresses" {
  description = "Address of the alb to be added to the record."
  type        = list(string)
}

variable "allow_overwrite" {
  type    = bool
  default = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.allow_overwrite))
    error_message = "[Error]: Value must be either true or false."
  }
}
