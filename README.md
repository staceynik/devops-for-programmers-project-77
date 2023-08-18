# Installing Njinx with Terraform

### Hexlet tests and linter status:
[![Actions Status](https://github.com/staceynik/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/staceynik/devops-for-programmers-project-77/actions)

Installing a Droplet in the Digital Ocean Cloud with Nginx

**Important:** Attention! Before executing any commands, make sure you understand how they work and what changes they will make to the system.

## Running Commands as Root

Commands for managing the project are run as the root user. If you want to execute commands as your own user, you need to provide write and execute permissions to the project directory. You can do this using the following command:

```bash
chmod -R u+rwx /path/to/devops-for-programmers-project-77
```
Replace /path/to/devops-for-programmers-project-77 with the actual path to the project directory on your system.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) (install the latest version)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (install the latest version)
- [DigitalOcean Account](https://www.digitalocean.com/) (sign up if you don't have one)
- [Make](https://www.gnu.org/software/make/)
- [Go](https://golang.org/dl/) (install the latest version)

### Installing terraform-inventory

To dynamically generate an Ansible inventory from your Terraform state, you can use `terraform-inventory`. If you're using Ubuntu, you can install Go and then `terraform-inventory` with the following commands:

```bash
sudo apt install golang-go

go install github.com/adammck/terraform-inventory@latest
```
Or you can use:

```bash

sudo apt install gccgo-go
```

### Installing Ansible Roles

Before running the playbook, make sure you have the required Ansible roles installed. You can install them using the `ansible-galaxy` command:

```bash
ansible-galaxy install -r ansible/requirements.yml
```

## Instructions

1. Clone the repository:

```https://github.com/staceynik/devops-for-programmers-project-77```

2. Change into the project directory:

```cd devops-for-programmers-project-77```

3. Create the `ansible_vault_password.txt` file with your Ansible Vault password. For example:

```your_vault_password```

4. Create the `secrets.auto.tfvars` file with your DigitalOcean token. For example:

```hcl
do_token = "your_secret_token"
```
5. Run the terraform init command to initialize Terraform:

```make init```

6. Run the terraform apply command to create a Droplet with Nginx installed on DigitalOcean:

```make apply```

After executing the terraform apply command, Terraform will provide you with information about the created Droplet, including its IP address.

Open your web browser and visit the Droplet's IP address to see the default Nginx page.

### Destroying Infrastructure

To remove the created Droplet and associated resources, run the command:

```make destroy```

WARNING: This command will permanently delete the created Droplet and associated resources. Please be cautious when using this command.
Makefile Commands

### License

This project is licensed under the MIT License.
