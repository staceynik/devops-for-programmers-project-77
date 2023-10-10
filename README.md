# Infrastructure as code

### Hexlet tests and linter status:
[![Actions Status](https://github.com/staceynik/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/staceynik/devops-for-programmers-project-77/actions)

In this project, we employ Terraform to provision infrastructure on DigitalOcean, including 2 droplets, 1 database, 1 load balancer, and 1 domain. Subsequently, we utilize Ansible to orchestrate the deployment of containerized applications. Specifically, we deploy Wiki.js as a Dockerized application and set up monitoring using Datadog.

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

4. **Preparation of Terraform**

Navigate to `terraform` directory and create the `secrets.auto.tfvars` file with your DigitalOcean token. For example:

   ```hcl
   do_token = "your_secret_token"
   ```
5. **Preparation of DataDog**

For integrating with Datadog, you need to set the required environment variables and keys. This project uses Ansible Vault to securely manage sensitive information. Here's how you can manage these variables:

- Create a file named `vault.yml` in the directory `~/devops-for-programmers-project-76/group_vars/webservers`
- Store your sensitive variables in this file. For example:

   ```vault_vars:
     datadog_api_key: "your-datadog-api-key"
     app_key: "your-app-key"
   ```
**Encrypt/Decrypt/Edit/View Vault**

To securely store sensitive information, Ansible utilizes built-in encryption functionality through Ansible Vault. For your convenience in managing the vault, we provide the following commands:

   ` make encrypt_vault`: Encrypts the vault file. This command helps safeguard sensitive data, such as passwords, API keys, and other secrets.

   ` make decrypt_vault`: Decrypts the vault file. Use this command to access the data within the vault file.

   ` make edit_vault`: Edits the vault file. This command allows you to modify confidential data inside the vault file.

   ` make view_vault`: Views the contents of the vault file. Use this command to review confidential data within the vault file without editing it.

- Before proceeding, ensure that you have extracted the credentials into `secrets.auto.tfvars` by running the following command:

   ```make extract-secrets```

6. **Initialize the Infrastructure:** Run the terraform init command to initialize Terraform:

   ```make init```

7. **Apply Infrastructure Changes:** Run the terraform apply command to create a Droplet with Nginx installed on DigitalOcean:

   ```make apply```

After executing the terraform apply command, Terraform will provide you with information about the created Droplet, including its IP address.

Open your web browser and visit the Droplet's IP address to see the default Nginx page.

8. **Install Ansible Roles:** Before running the playbook, make sure you have the required Ansible roles installed. You can install>

   ```bash
   install-ansible-roles
   ```
To access the newly created Droplets, you can connect using the following command: `ssh root@IP_address_of_your_droplet` You can find the IP address in either the inventory file located in the Ansible directory or within the DigitalOcean project.

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
