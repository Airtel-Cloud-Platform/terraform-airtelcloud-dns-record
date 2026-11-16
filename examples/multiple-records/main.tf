locals {
  records = {
    web = {
      owner       = "www"
      record_type = "A"
      data        = "192.168.1.10"
    }

    blog = {
      owner       = "blog"
      record_type = "CNAME"
      data        = "www.example.com."
      ttl         = 3600
    }

    mail = {
      owner       = "@"
      record_type = "MX"
      data        = "mail.example.com."
      preference  = 10
      ttl         = 3600
    }

    spf = {
      owner       = "@"
      record_type = "TXT"
      data        = "v=spf1 include:_spf.example.com ~all"
      ttl         = 3600
    }
  }
}

module "dns_record" {
  source   = "../../"
  for_each = local.records

  zone_id = "zone-id"

  owner       = each.value.owner
  record_type = each.value.record_type
  data        = each.value.data
  ttl         = try(each.value.ttl, 300)
  preference  = try(each.value.preference, null)
}

output "record_ids" {
  value = { for k, r in module.dns_record : k => r.record_id }
}
