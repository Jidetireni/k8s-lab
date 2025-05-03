# Automated Kubernetes homelab infrastructure on Digital Ocean 

This project automates the setup of a Kubernetes cluster on DigitalOcean using Terraform and Ansible. It provisions the infrastructure, configures the nodes, and prepares the cluster environment for Kubernetes.

## Features

- **Infrastructure Provisioning**: 
  - Creates a master node and two worker nodes with specified resources using Terraform.
  - Sets up a Virtual Private Cloud (VPC) for secure communication between nodes.
  - Configures a firewall to manage traffic and secure the cluster.

- **Node Configuration**:
  - Automates hostname assignment for nodes.
  - Creates a user with sudo access and no-password privileges.
  - Configures SSH access for secure remote management.
  - Opens required ports in the firewall for Kubernetes.
  - Installs container runtime (e.g., containerd).

## Prerequisites

- A DigitalOcean account and API token with read/write permissions.
- Terraform installed on your local machine ([Download Terraform](https://www.terraform.io/downloads)).
- Ansible installed on your local machine ([Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)).
- An SSH key added to your DigitalOcean account for accessing droplets.

## Project Structure

```
project-directory/
├── terraform/
│   ├── main.tf          # Main Terraform configuration
│   ├── variables.tf     # Variables for Terraform
│   ├── outputs.tf       # Outputs for Terraform
│   ├── vpc.tf           # VPC configuration
│   ├── firewall.tf      # Firewall configuration
│   └── droplets/        # Droplet configuration
│       └── main.tf
└── ansible/
    ├── inventory/
    │   └── inventory.ini # Inventory file for Ansible
    ├── playbooks/
    │   └── site.yml      # Main playbook for Ansible
    ├── roles/
    │   ├── common/
    │   │   ├── tasks/
    │   │   │   └── main.yml
    │   ├── containerd/
    │   │   ├── tasks/
    │   │   │   └── main.yml
    │   ├── master/
    │   │   ├── tasks/
    │   │   │   └── main.yml
    │   └── workers/
    │       ├── tasks/
    │       │   └── main.yml
    └── group_vars/
        ├── all.yml       # Shared variables for all hosts
        ├── master.yml    # Variables specific to master nodes
        └── workers.yml   # Variables specific to worker nodes
```

## Usage

### Terraform

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

### Ansible

1. **Update Inventory**:
   - Edit `ansible/inventory/inventory.ini` to include the public IPs of the master and worker nodes created by Terraform.

2. **Test Connection**:
   ```bash
   ansible -i ansible/inventory/inventory.ini all -m ping
   ```

3. **Run Playbook**:
   ```bash
   ansible-playbook -i ansible/inventory/inventory.ini ansible/playbooks/site.yml
   ```
   - Ansible will configure the nodes, set up the environment, and install the container runtime.

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

The playbook installs `containerd` as the container runtime, which is required for Kubernetes.

## Notes

- Ensure that the API token and SSH key ID are securely stored and not hardcoded.
- Modify the port ranges and IP addresses in the firewall rules as needed for your environment.
- The playbook assumes Ubuntu 20.04 as the operating system for nodes.

## Troubleshooting

- **Terraform Issues**:
  - Run `terraform refresh` to sync the state file with DigitalOcean if you encounter issues.
  - Check the `terraform apply` output for errors and update your configuration if needed.

- **Ansible Issues**:
  - Use the `-vvv` flag with Ansible commands for detailed logs:
    ```bash
    ansible-playbook -i ansible/inventory/inventory.ini ansible/playbooks/site.yml -vvv
    ```
  - Ensure SSH access is properly configured for the `root` user during the initial setup.

## License

This project is licensed under the MIT License.

## Author

Created by [Jidetireni](https://github.com/Jidetireni).
