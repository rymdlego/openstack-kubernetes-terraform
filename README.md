# HA Kubernetes in Openstack

Terraform blueprints for creating the infrastucture for HA Kubernetes (multi control plane with stacked etcd) in Openstack.
It creates:
- router
- network
- subnet
- security groups
- floating IPs
- network ports
- server instances

If config left unchanged, it will provision:
- Three control plane instances
- Three worker node instances
- One SSH bastion host to be used for Ansible

## Usage
#### Prereqs
* Terraform
* Openstack account

#### Config

Create a terraform.tfvars to override variables.tf defaults - specify network configuration and the number of desired nodes

Set the openstack_ variables for the provider to work with your OpenStack account. I'd recommend creating a separate tfvars file for this and marking it as sensitive.
- openstack_password
- openstack_username
- aopenstack_tenant_id
- openstack_auth_url
- openstack_region

#### Run
- `terraform init`
- `terraform apply`

Once the provisioning is complete, Terraform will report back the IP of the bastion-host and the IP for the Kubernetes API

Jot these down somewhere and proceed to the Ansible setup in the kubernetes-openstack-ansible repo.
