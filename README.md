# Airtel Cloud DNS Record Terraform Module

Terraform module for provisioning Airtel Cloud DNS Records.

The module wraps the `airtelcloud_dns_record` resource and creates one record in an existing DNS zone. Create the zone with the [`dns-zone`](https://github.com/Airtel-Cloud-Platform/terraform-airtelcloud-dns-zone) module and pass its `zone_id` output.

## Features

* Creates DNS Records within an existing DNS Zone
* Supports A, AAAA, CNAME, MX, TXT, NS, SRV, CAA and PTR records
* Supports custom TTL values
* Supports MX record preference values
* Creates many records with `for_each`
* Exposes every attribute exported by the provider (organization, creator and timestamps)

## Requirements

| Name                 | Version  |
| -------------------- | -------- |
| Terraform            | >= 1.5   |
| airtelcloud Provider | >= 1.0.4 |

## Usage

### A Record

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  record_type = "A"

  owner = "www"

  data = "192.168.1.10"
}
```

### AAAA Record

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  owner       = "www"
  record_type = "AAAA"

  data = "2001:db8::1"

  description = "Web server IPv6 record"
}
```

### CNAME Record

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  owner       = "blog"
  record_type = "CNAME"

  data = "www.example.com."

  ttl         = 3600
  description = "Blog CNAME pointing to www"
}
```

### MX Record

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  owner       = "mail"
  record_type = "MX"

  data       = "mail.example.com."
  preference = 10

  ttl         = 3600
  description = "Primary mail server"
}
```

### TXT Record (SPF)

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  owner       = "@"
  record_type = "TXT"

  data = "v=spf1 include:_spf.example.com ~all"

  ttl         = 3600
  description = "SPF record for email authentication"
}
```

### Multiple Records

```hcl
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
  }
}

module "dns_record" {
  source   = "Airtel-Cloud-Platform/dns-record/airtelcloud"
  for_each = local.records

  zone_id = "zone-id"

  owner       = each.value.owner
  record_type = each.value.record_type
  data        = each.value.data
  ttl         = try(each.value.ttl, 300)
}
```

More examples are in [`examples/`](./examples): `basic`, `complete`, `aaaa`, `cname`, `txt` and `multiple-records`.

## Inputs

| Name        | Description                                                                                                  | Type     | Default | Required |
| ----------- | ------------------------------------------------------------------------------------------------------------ | -------- | ------- | -------- |
| zone_id     | DNS Zone ID (UUID). Forces replacement if changed.                                                           | `string` | n/a     | Yes      |
| record_type | DNS record type: `A`, `AAAA`, `CNAME`, `MX`, `TXT`, `NS`, `SRV`, `CAA` or `PTR` (case-insensitive). Forces replacement if changed. | `string` | n/a     | Yes      |
| owner       | Record name relative to the zone (for example `www`; `@` for the apex).                                      | `string` | `"@"`   | No       |
| data        | Record value (IP address, hostname, text).                                                                   | `string` | n/a     | Yes      |
| ttl         | TTL in seconds. Must be at least 60.                                                                         | `number` | `300`   | No       |
| description | Record description.                                                                                         | `string` | `null`  | No       |
| preference  | MX record preference.                                                                                        | `number` | `null`  | No       |

Use the name relative to the zone for `owner` (`www`, not `www.example.com.`). The provider stores the relative name.

## Outputs

| Name       | Description                                                           |
| ---------- | --------------------------------------------------------------------- |
| record_id  | DNS Record ID (UUID)                                                  |
| zone_name  | DNS Zone Name                                                         |
| org_name   | Organization name associated with the record                          |
| org_id     | Organization ID associated with the record                            |
| created_by | User who created the record                                           |
| created_at | Creation timestamp (Unix timestamp)                                   |
| updated_at | Last updated timestamp (Unix timestamp)                               |
| dns_record | Object with id, zone_id, zone_name, owner, record_type, data, ttl, description, preference, org_name, org_id, created_by, created_at and updated_at |

Example:

```hcl
output "record_details" {
  value = module.dns_record.dns_record
}
```

## Import

The underlying resource is imported with the zone ID and record ID separated by a slash:

```shell
terraform import 'module.dns_record.airtelcloud_dns_record.this' <zone-id>/<record-id>
```

When the module is used with `for_each`:

```shell
terraform import 'module.dns_record["web"].airtelcloud_dns_record.this' <zone-id>/<record-id>
```

After importing, run `terraform plan` to confirm the configuration matches the existing record.
