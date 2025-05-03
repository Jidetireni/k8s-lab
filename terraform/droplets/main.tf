# This file is part of the Terraform configuration for creating DigitalOcean droplets.
# It defines the resources for creating master and worker nodes for a Kubernetes cluster.

# master node
resource "digitalocean_droplet" "master-node" {
  count = 1
  name  = "master-${count.index + 1}"
  image = var.image
  size  = "s-2vcpu-4gb"
  region = var.region

  ssh_keys = [var.ssh_key_id]

  tags = ["k8s-master-lab"]
  
}

#worker nodes
resource "digitalocean_droplet" "worker-node" {
  count = 2
  name  = "worker-${count.index + 1}"
  image = var.image
  size  = "s-1vcpu-2gb"
  region = var.region

  ssh_keys = [var.ssh_key_id]

  tags = ["k8s-worker-lab"]
  
}