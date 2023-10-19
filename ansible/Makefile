VAULT_PASSWORD_FILE = $(CURDIR)/ansible_vault_password.txt

.PHONY: encrypt_vault decrypt_vault edit_vault view_vault install-roles deploy-droplets pull-image run-container configure_datadog

encrypt_vault:
	@ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) group_vars/webservers/vault.yml

decrypt_vault:
	@ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) group_vars/webservers/vault.yml

edit_vault:
	@ansible-vault edit --vault-password-file=$(VAULT_PASSWORD_FILE) group_vars/webservers/vault.yml

view_vault:
	@ansible-vault view --vault-password-file=$(VAULT_PASSWORD_FILE) group_vars/webservers/vault.yml

install-roles:
	@ansible-galaxy install -r requirements.yml --roles-path=roles

deploy-droplets:
	@export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i $(CURDIR)/inventory.ini -l droplets --user=root $(CURDIR)/playbook.yml

pull-image:
	@export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i $(CURDIR)/inventory.ini -l droplets --user=root $(CURDIR)/playbook.yml --tags pull_image

run-container:
	@export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i $(CURDIR)/inventory.ini -l droplets --user=root $(CURDIR)/playbook.yml --tags run_container

configure_datadog:
	@export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i $(CURDIR)/inventory.ini -l droplets --user=root $(CURDIR)/playbook.yml --tags configure_datadog
