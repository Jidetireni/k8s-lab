resource "digitalocean_firewall" "k8s_firewall" {
  name = "k8s-firewall"

  droplet_ids = flatten([
    digitalocean_droplet.master.id,
    digitalocean_droplet.worker.*.id
  ])

  inbound_rule {
    protocol         = "tcp"
    port_range       = "6443"
    source_addresses = var.source_address # Allow Kubernetes API server
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "2379-2380"
    source_addresses = var.firewall_ip_ranges # Allow etcd server client API
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "10250"
    source_addresses = var.firewall_ip_ranges # Allow Kubelet API
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "10251-10252"
    source_addresses = var.firewall_ip_ranges # Allow kube-scheduler and kube-controller-manager
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "30000-32767"
    source_addresses = var.source_address # Allow NodePort Services
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = var.firewall_ip_ranges   # Allow ICMP (ping)
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    destination_addresses = var.source_address  # Allow all outbound traffic
  }
}