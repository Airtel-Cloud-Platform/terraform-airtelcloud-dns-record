module "dns_record" {
  source = "../../"

  zone_id = "zone-id"

  owner       = "@"
  record_type = "TXT"

  data = "v=spf1 include:_spf.example.com ~all"

  ttl         = 3600
  description = "SPF record for email authentication"
}
