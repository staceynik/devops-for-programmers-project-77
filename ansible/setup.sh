#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define paths relative to the script directory
ANSIBLE_VAULT_PASSWORD_FILE="$SCRIPT_DIR/ansible/ansible_vault_password.txt"
TERRAFORM_SECRETS_FILE="$SCRIPT_DIR/terraform/secrets.auto.tfvars"
VAULT_YML_FILE="$SCRIPT_DIR/group_vars/webservers/vault.yml"

# Prompt for Ansible Vault password
read -s -p "Enter your Ansible Vault password: " vault_password
echo $vault_password > "$ANSIBLE_VAULT_PASSWORD_FILE"

# Prompt for DigitalOcean token
read -p "Enter your DigitalOcean token: " do_token
echo "do_token = \"$do_token\"" > "$TERRAFORM_SECRETS_FILE"

# Prompt for Datadog API key and App key
read -p "Enter your Datadog API key: " datadog_api_key
read -p "Enter your Datadog App key: " app_key

cat <<EOF > "$VAULT_YML_FILE"
vault_vars:
  datadog_api_key: "$datadog_api_key"
  app_key: "$app_key"
EOF

echo "Configuration files generated successfully."
