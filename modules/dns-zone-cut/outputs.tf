output "externaldns_ns" {
  description = "ExternalDNS nameservers"
  value       = data.google_dns_managed_zone.externaldns_managed_zone.name_servers
}

output "externaldns_dns_name" {
  description = "ExternalDNS name"
  value       = data.google_dns_managed_zone.externaldns_managed_zone.dns_name
}

output "externaldns_sub_ns" {
  description = "Subzone nameservers"
  value       = google_dns_managed_zone.externaldns_managed_zone_with_sub.*.name_servers
}

output "externaldnsdns_sub_name" {
  description = "Subzone DNS name"
  value       = google_dns_managed_zone.externaldns_managed_zone_with_sub.*.dns_name
}

output "subdomain_verification_cmd" {
    value = "nslookup -type=txt ${google_dns_record_set.verification_record.name}"
}
