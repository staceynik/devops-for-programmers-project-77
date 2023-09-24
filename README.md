# Installing Njinx with Terraform

### Hexlet tests and linter status:
[![Actions Status](https://github.com/staceynik/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/staceynik/devops-for-programmers-project-77/actions)

Installing a Droplet in the Digital Ocean Cloud with Nginx

**Important:** Attention! Before executing any commands, make sure you understa>

## Running Commands as Root

Commands for managing the project are run as the root user. If you want to exec>

```bash
chmod -R u+rwx /path/to/devops-for-programmers-project-77
```
Replace /path/to/devops-for-programmers-project-77 with the actual path to the >

## Setting up SSH Key

Before running Terraform to create your Droplets, you need to ensure that you have an SSH key set up and associated with your DigitalOcean account. Here are the steps to do that:

Generate an SSH key pair on your local machine if you haven't already:

   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
This will generate a public and private key pair. The public key is usually located in ~/.ssh/id_rsa.pub.

1. Log in to your DigitalOcean account.

2. In the DigitalOcean dashboard, go to Settings > Security > SSH Keys.

3. Click on the `Add SSH Key` button.

4. Give your SSH key a name (e.g., "My SSH Key").

5. In the Public Key Content field, paste the content of your public key file (~/.ssh/id_rsa.pub).

6. Click Add SSH Key to save it.

Now you have an SSH key associated with your DigitalOcean account, and you can use it in your Terraform configuration to create Droplets.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) (install the latest version)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (install the latest version)
- [DigitalOcean Account](https://www.digitalocean.com/) (sign up if you don't have one)
- [Make](https://www.gnu.org/software/make/)


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
5. **Initialize the Infrastructure:** Run the terraform init command to initialize Terraform:

```make init```

6. **Apply Infrastructure Changes:** Run the terraform apply command to create a Droplet with Nginx installed on DigitalOcean:

```make apply```

After executing the terraform apply command, Terraform will provide you with information about the created Droplet, including its IP address.

Open your web browser and visit the Droplet's IP address to see the default Nginx page.

7. **Generate Inventory File:** Run the `make generate-inventory` command to generate an Ansible inventory file that includes the IP addresses of all the created resources.

8. **Install Ansible Roles:** Before running the playbook, make sure you have the required Ansible roles installed. You can install>

```bash
ansible-galaxy install -r ansible/requirements.yml
```
To access the newly created Droplets, you can connect using the following command:??????????? You can find the IP address in either the inventory file located in the Ansible directory or within the DigitalOcean project.

9. **Deploy Your Application to Droplets:** Deploy your application to the Droplets by executing the following command:

    ```bash
    make deploy-droplets
    ```

### Destroying Infrastructure

To remove the created Droplet and associated resources, run the command:

```make destroy```

WARNING: This command will permanently delete the created Droplet and associated resources. Please be cautious when using this command.
Makefile Commands

### License

This project is licensed under the MIT License.
