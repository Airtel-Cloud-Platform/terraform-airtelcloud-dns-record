module "dns_record" {
  source = "../../"

  zone_id = "zone-id"

  owner       = "www"
  record_type = "AAAA"

  data = "2001:db8::1"

  description = "Web server IPv6 record"
}
