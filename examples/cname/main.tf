module "dns_record" {
  source = "../../"

  zone_id = "zone-id"

  owner       = "blog"
  record_type = "CNAME"

  data = "www.example.com."

  ttl         = 3600
  description = "Blog CNAME pointing to www"
}
