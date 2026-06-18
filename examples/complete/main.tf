module "dns_record" {
  source = "../../"

  zone_id = "zone-id"

  owner       = "mail"
  record_type = "MX"

  data       = "mail.example.com."
  preference = 10

  ttl         = 3600
  description = "Primary mail server"
}
