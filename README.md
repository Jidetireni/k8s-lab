# Kubernetes Homelab Automation on Digital Ocean

This repository enables the seamless deployment of a Kubernetes homelab on DigitalOcean. Utilizing **Terraform** and **Ansible**, it automates the provisioning of infrastructure, node configuration, and cluster setup.

---

## Features

### Infrastructure Provisioning
- **Master and Worker Nodes**: Creates a master node and two worker nodes with specified resources.
- **Networking**: Sets up a Virtual Private Cloud (VPC) for secure communication between nodes.
- **Firewall**: Configures traffic rules to secure the Kubernetes cluster.

### Node Configuration
- **Hostname Management**: Automatically assigns hostnames to nodes.
- **User Setup**: Creates a user with sudo access and no-password privileges.
- **SSH Access**: Configures secure remote access via SSH.
- **Firewall Ports**: Opens necessary ports for Kubernetes operation.
- **Container Runtime**: Installs `containerd` as the container runtime for Kubernetes.

---

## Prerequisites

1. A [DigitalOcean](https://www.digitalocean.com) account and API token with read/write permissions.
2. [Terraform](https://www.terraform.io/downloads) installed locally.
3. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) installed locally.
4. An SSH key added to your DigitalOcean account for accessing droplets.

---

## Project Structure

```plaintext
project-directory/
   .
   ├── README.md
   ├── ansible
   │   ├── inventory
   │   │   ├── inventory.example.ini
   │   │   └── inventory.ini
   │   ├── playbook.yml
   │   └── roles
   │       ├── bootstrap
   │       │   └── tasks
   │       │       └── main.yml
   │       ├── containerd
   │       │   └── tasks
   │       │       └── main.yml
   │       └── kubernetes
   │           └── tasks
   │               ├── main.yml
   │               ├── master.yml
   │               └── worker.yml
   └── terraform
      ├── droplets
      │   ├── main.tf
      │   ├── terraform.tfvars
      │   └── variables.tf
      ├── firewall.tf
      ├── main.tf
      ├── terraform.tfvars
      ├── variables.tf
      └── vpc.tf
```

---

## Usage Instructions

### Step 1: Provision Infrastructure with Terraform

1. **Initialize Terraform**:
   ```bash
   cd terraform/
   terraform init
   ```

2. **Preview Changes**:
   ```bash
   terraform plan
   ```

3. **Apply Changes**:
   ```bash
   terraform apply
   ```

   - Terraform will provision the infrastructure, including droplets, VPC, and firewall.

---

### Step 2: Configure Nodes with Ansible

1. **Update Inventory File**:
   - Edit `ansible/inventory/inventory.ini` to include the public IPs of the master and worker nodes created by Terraform.

2. **Test SSH Connection**:
   ```bash
   ansible -i ansible/inventory/inventory.ini all -m ping
   ```

3. **Run the Playbook**:
   ```bash
   ansible-playbook -i ansible/inventory/inventory.ini ansible/playbooks/site.yml
   ```

   - Ansible will configure the nodes, set up the environment, and install the container runtime.

---

## Configuration Details

### Firewall Rules

The firewall is configured to allow traffic for the following Kubernetes ports:

| Port Range       | Protocol | Purpose                       |
|-------------------|----------|-------------------------------|
| 6443             | TCP      | Kubernetes API server         |
| 2379–2380        | TCP      | etcd server                   |
| 10250            | TCP      | kubelet                       |
| 10251–10252      | TCP      | Scheduler and controller      |
| 30000–32767      | TCP      | NodePort services             |
| ICMP             | -        | Internal ping between nodes   |

### Container Runtime

- `containerd` is installed as the container runtime for Kubernetes.

---

## Notes

- Ensure that the API token and SSH key ID are securely stored and not hardcoded.
- Modify port ranges and IP addresses in the firewall rules as needed for your environment.
- This setup assumes Ubuntu 20.04 as the operating system for all nodes.

---

## Troubleshooting

### Terraform
- Run `terraform refresh` to sync the state file with DigitalOcean.
- Check the output of `terraform apply` for errors and update your configuration as necessary.

### Ansible
- Use the `-vvv` flag with Ansible commands for detailed logs:
  ```bash
  ansible-playbook -i ansible/inventory/inventory.ini ansible/playbooks/site.yml -vvv
  ```
- Ensure SSH access is properly configured for the `root` user during the initial setup.

---

## License

This project is licensed under the MIT License.

---

## Author

Created and maintained by [Jidetireni](https://github.com/Jidetireni).

---