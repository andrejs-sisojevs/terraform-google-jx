resource "google_project_service" "dns_api" {
  provider           = google
  service            = "dns.googleapis.com"
  disable_on_destroy = false
}

// ----------------------------------------------------------------------------
// Parent zone (existing)
// ----------------------------------------------------------------------------

// if we have a bar.io add recordsets to the same zone
data "google_dns_managed_zone" "externaldns_managed_zone" {
  name = var.parent_domain_managed_zone_name
}

// ----------------------------------------------------------------------------
// Sub zone (new)
// ----------------------------------------------------------------------------

// if we have a foo.bar.io add recordsets to the parent zone
resource "google_dns_managed_zone" "externaldns_managed_zone_with_sub" {
  name        = "${replace(var.subdomain, ".", "-")}-${var.parent_domain_managed_zone_name}-sub"
  dns_name    = "${var.subdomain}.${var.parent_domain}."
  description = var.sub_zone_description

  force_destroy = true

  depends_on = [google_project_service.dns_api]
}

resource "google_dns_record_set" "externaldns_record_set_with_sub" {
  managed_zone = data.google_dns_managed_zone.externaldns_managed_zone.name
  name         = "${var.subdomain}.${var.parent_domain}."
  type         = "NS"
  ttl          = var.nameserver_cache_ttl
  rrdatas      = flatten(google_dns_managed_zone.externaldns_managed_zone_with_sub.name_servers)
}

resource "google_dns_record_set" "verification_record" {
  name = "_verify.${google_dns_managed_zone.externaldns_managed_zone_with_sub.dns_name}"
  type = "TXT"
  ttl  = var.nameserver_cache_ttl

  managed_zone = google_dns_managed_zone.externaldns_managed_zone_with_sub.name

  rrdatas = ["deployment timestamp ${timestamp()}"]
}
