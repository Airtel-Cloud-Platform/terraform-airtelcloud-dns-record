resource "airtelcloud_dns_record" "this" {
  zone_id = var.zone_id

  owner = var.owner

  record_type = upper(var.record_type)

  data = var.data

  ttl = var.ttl

  description = var.description

  preference = var.preference
}
