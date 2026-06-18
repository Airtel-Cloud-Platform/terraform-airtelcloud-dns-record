variable "zone_id" {
  description = "DNS Zone ID"

  type = string

  validation {
    condition     = length(trim(var.zone_id, " ")) > 0
    error_message = "zone_id cannot be empty."
  }
}

variable "record_type" {
  description = "DNS record type"

  type = string

  validation {
    condition = contains(
      ["A", "AAAA", "CNAME", "MX", "TXT", "NS", "SRV", "CAA", "PTR"],
      upper(var.record_type)
    )

    error_message = "record_type must be one of A, AAAA, CNAME, MX, TXT, NS, SRV, CAA, PTR."
  }
}

variable "owner" {
  description = "Record owner/name"

  type    = string
  default = "@"
}

variable "data" {
  description = "DNS record value"

  type = string

  validation {
    condition     = length(trim(var.data, " ")) > 0
    error_message = "data cannot be empty."
  }
}

variable "ttl" {
  description = "DNS record TTL"

  type    = number
  default = 300

  validation {
    condition     = var.ttl >= 60
    error_message = "ttl must be at least 60 seconds."
  }
}

variable "description" {
  description = "DNS record description"

  type    = string
  default = null
}

variable "preference" {
  description = "MX record preference"

  type    = number
  default = null
}
