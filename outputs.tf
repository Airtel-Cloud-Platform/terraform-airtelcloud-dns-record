output "record_id" {
  description = "DNS Record ID"

  value = airtelcloud_dns_record.this.id
}

output "zone_name" {
  description = "DNS Zone Name"

  value = airtelcloud_dns_record.this.zone_name
}

output "org_name" {
  description = "Organization name associated with the record"

  value = airtelcloud_dns_record.this.org_name
}

output "org_id" {
  description = "Organization ID associated with the record"

  value = airtelcloud_dns_record.this.org_id
}

output "created_by" {
  description = "User who created the record"

  value = airtelcloud_dns_record.this.created_by
}

output "created_at" {
  description = "Record creation timestamp (Unix timestamp)"

  value = airtelcloud_dns_record.this.created_at
}

output "updated_at" {
  description = "Record last updated timestamp (Unix timestamp)"

  value = airtelcloud_dns_record.this.updated_at
}

output "dns_record" {
  description = "Complete DNS Record object with all exported attributes"

  value = {
    id          = airtelcloud_dns_record.this.id
    zone_id     = airtelcloud_dns_record.this.zone_id
    zone_name   = airtelcloud_dns_record.this.zone_name
    owner       = airtelcloud_dns_record.this.owner
    record_type = airtelcloud_dns_record.this.record_type
    data        = airtelcloud_dns_record.this.data
    ttl         = airtelcloud_dns_record.this.ttl
    description = airtelcloud_dns_record.this.description
    preference  = airtelcloud_dns_record.this.preference
    org_name    = airtelcloud_dns_record.this.org_name
    org_id      = airtelcloud_dns_record.this.org_id
    created_by  = airtelcloud_dns_record.this.created_by
    created_at  = airtelcloud_dns_record.this.created_at
    updated_at  = airtelcloud_dns_record.this.updated_at
  }
}
