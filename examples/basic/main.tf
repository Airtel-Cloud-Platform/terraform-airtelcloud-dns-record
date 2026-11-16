module "dns_record" {
  source = "../../"

  zone_id = "zone-id"

  record_type = "A"

  owner = "www"

  data = "192.168.1.10"
}

output "record_id" {
  value = module.dns_record.record_id
}
