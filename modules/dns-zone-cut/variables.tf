// ----------------------------------------------------
// Required Variables
// ----------------------------------------------------
variable "gcp_project" {
  description = "The name of the GCP project to create all resources"
  type        = string
}

variable "parent_domain_managed_zone_name" {
  description = "Name of GCP managed zone"
  type        = string
}

variable "parent_domain" {
  description = "The parent domain to be allocated to the cluster"
  type        = string
}

variable "subdomain" {
  description = "Optional sub domain for the installation"
  type        = string
}

variable "sub_zone_description" {
  description = "Sub-zone description"
  type        = string
  # default     = "GKE with JX managed zone"
}

variable "nameserver_cache_ttl" {
  description = "DNS nameserver cache entry TTL"
  type        = number
  default     = 60
}
