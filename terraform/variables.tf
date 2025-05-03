variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Droplet region"
  type        = string
  
}

variable "ip_range" {
  description = "IP range for the VPC"
  type        = string
  
}

variable "firewall_ip_ranges" {
  description = "IP ranges for the firewall rules"
  type        = list(string)
  
}

variable "source_address" {
  description = "Source address for the firewall rules"
  type        = list(string)
  
}