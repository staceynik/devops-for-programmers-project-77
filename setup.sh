#!/bin/bash

ANSIBLE_VAULT_PASSWORD_FILE="ansible/ansible_vault_password.txt"
TERRAFORM_SECRETS_FILE="terraform/secrets.auto.tfvars"
VAULT_YML_FILE="ansible/group_vars/webservers/vault.yml"

read -s -p "Enter your Ansible Vault password: " vault_password
echo $vault_password > "$ANSIBLE_VAULT_PASSWORD_FILE"

read -p "Enter your DigitalOcean token: " do_token
echo "do_token = \"$do_token\"" > "$TERRAFORM_SECRETS_FILE"

read -p "Enter your Datadog API key: " datadog_api_key
read -p "Enter your Datadog App key: " app_key

cat <<EOF > "$VAULT_YML_FILE"
vault_vars:
  datadog_api_key: "$datadog_api_key"
  app_key: "$app_key"
EOF

ansible-vault encrypt "$VAULT_YML_FILE" --vault-password-file "$ANSIBLE_VAULT_PASSWORD_FILE"

echo "Configuration files generated successfully."
