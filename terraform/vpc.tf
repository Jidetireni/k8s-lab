# vpc for kubernetes nodes
resource "digitalocean_vpc" "k8s_vpc" {
  name   = "k8s-vpc"
  region = var.region 
  ip_range = var.ip_range
  description = "VPC for Kubernetes nodes"
  default     = false
}