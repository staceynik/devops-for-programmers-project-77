TF_VARS_FILE_TERRAFORM = "secrets.auto.tfvars"
VAULT_PASSWORD_FILE = $(CURDIR)/ansible_vault_password.txt

.PHONY: init apply destroy generate-inventory install-ansible-roles deploy-droplets extract-secrets

init:
	@cd terraform && terraform init

apply:
	cd terraform && terraform apply -var-file="secrets.auto.tfvars"

encrypt_vault:
	ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) ansible/group_vars/webservers/vault.yml

decrypt_vault:
	ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) ansible/group_vars/webservers/vault.yml

edit_vault:
	ansible-vault edit --vault-password-file=$(VAULT_PASSWORD_FILE) ansible/group_vars/webservers/vault.yml

view_vault:
	ansible-vault view --vault-password-file=$(VAULT_PASSWORD_FILE) ansible/group_vars/webservers/vault.yml

extract-secrets:
	@ansible-vault view --vault-password-file=$(VAULT_PASSWORD_FILE) ansible/group_vars/webservers/vault.yml | sed 's/:/=/g' >> terraform/secrets.auto.tfvars

install-ansible-roles:
	@ansible-galaxy install -r ansible/requirements.yml

deploy-droplets:
	@export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml

pull-image:
	@ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml --tags pull_image

run-container:
	@ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml --tags run_container

destroy:
	@cd terraform && terraform destroy -var-file=$(TF_VARS_FILE_TERRAFORM)

configure_datadog:
	@ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml --tags configure_datadog
