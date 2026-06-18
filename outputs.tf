output "record_id" {
  description = "DNS Record ID"

  value = airtelcloud_dns_record.this.id
}

output "zone_name" {
  description = "DNS Zone Name"

  value = airtelcloud_dns_record.this.zone_name
}

output "dns_record" {
  description = "Complete DNS Record object"

  value = {
    id        = airtelcloud_dns_record.this.id
    zone_name = airtelcloud_dns_record.this.zone_name
  }
}
