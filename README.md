# Airtel Cloud DNS Record Terraform Module

Terraform module for provisioning Airtel Cloud DNS Records.

## Features

* Creates DNS Records within an existing DNS Zone
* Supports A, AAAA, CNAME, MX, TXT, NS, SRV, CAA and PTR records
* Supports custom TTL values
* Supports MX record preference values

## Usage

### Basic Example

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  record_type = "A"

  owner = "www"

  data = "192.168.1.10"
}
```

### MX Record Example

```hcl
module "dns_record" {
  source = "Airtel-Cloud-Platform/dns-record/airtelcloud"

  zone_id = "zone-id"

  owner       = "mail"
  record_type = "MX"

  data       = "mail.example.com."
  preference = 10

  ttl = 3600
}
```

## Inputs

| Name        | Description         | Type   | Required |
| ----------- | ------------------- | ------ | -------- |
| zone_id     | DNS Zone ID         | string | Yes      |
| record_type | DNS Record Type     | string | Yes      |
| owner       | Record owner/name   | string | No       |
| data        | Record value        | string | Yes      |
| ttl         | DNS TTL             | number | No       |
| description | Record description  | string | No       |
| preference  | MX preference value | number | No       |

## Outputs

| Name       | Description                |
| ---------- | -------------------------- |
| record_id  | DNS Record ID              |
| zone_name  | DNS Zone Name              |
| dns_record | Complete DNS Record object |

## Requirements

| Name                 | Version  |
| -------------------- | -------- |
| Terraform            | >= 1.5   |
| airtelcloud Provider | >= 1.0.4 |

