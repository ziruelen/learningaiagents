# Terraform: Cloudflare Registrar y DNS
# Requiere: terraform init
# Aplicar: terraform plan && terraform apply

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API Token con permisos Zone:Edit, DNS:Edit"
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "Dominio principal"
  default     = "tudominio.com"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# Zone (dominio) - Asegúrate de que el dominio ya esté en Cloudflare
data "cloudflare_zone" "main" {
  name = var.domain
}

# Activar DNSSEC
resource "cloudflare_zone_dnssec" "main" {
  zone_id = data.cloudflare_zone.main.id
}

# Registros DNS básicos
resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.main.id
  name    = "@"
  value   = "192.0.2.1"
  type    = "A"
  ttl     = 3600
  proxied = true  # Activar proxy (CDN)
  comment = "Root domain"
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.main.id
  name    = "www"
  value   = var.domain
  type    = "CNAME"
  ttl     = 3600
  proxied = true
  comment = "WWW subdomain"
}

# Registros para servicios homelab
resource "cloudflare_record" "n8n" {
  zone_id = data.cloudflare_zone.main.id
  name    = "n8n"
  value   = "100::"  # IPv6 placeholder - reemplazar con IP real
  type    = "AAAA"
  ttl     = 3600
  proxied = true
  comment = "n8n automation platform"
}

resource "cloudflare_record" "jellyfin" {
  zone_id = data.cloudflare_zone.main.id
  name    = "jellyfin"
  value   = "100::"
  type    = "AAAA"
  ttl     = 3600
  proxied = true
  comment = "Jellyfin media server"
}

# Email Routing (MX records)
resource "cloudflare_record" "mx1" {
  zone_id  = data.cloudflare_zone.main.id
  name     = "@"
  value    = "route1.mx.cloudflare.net"
  type     = "MX"
  priority = 10
  ttl      = 3600
  comment  = "Cloudflare Email Routing"
}

resource "cloudflare_record" "mx2" {
  zone_id  = data.cloudflare_zone.main.id
  name     = "@"
  value    = "route2.mx.cloudflare.net"
  type     = "MX"
  priority = 20
  ttl      = 3600
  comment  = "Cloudflare Email Routing"
}

# SPF Record
resource "cloudflare_record" "spf" {
  zone_id = data.cloudflare_zone.main.id
  name    = "@"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  type    = "TXT"
  ttl     = 3600
  comment = "SPF for email"
}

# Outputs
output "zone_id" {
  value       = data.cloudflare_zone.main.id
  description = "Zone ID de Cloudflare"
}

output "nameservers" {
  value       = data.cloudflare_zone.main.name_servers
  description = "Nameservers de Cloudflare"
}

