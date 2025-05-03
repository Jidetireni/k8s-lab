variable "image" {
    description = "Droplet image"
    type        = string

}

variable "ssh_key_id" {
  description = "SSH key ID to access the droplets"
  type        = string
  
}

variable "region" {
  description = "Droplet region"
  type        = string
  
}