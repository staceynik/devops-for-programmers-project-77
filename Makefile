.PHONY: init apply destroy terraform ansible encrypt_vault decrypt_vault edit_vault view_vault install-roles deploy-droplets pull-image run-container configure_datadog

init:
	@cd terraform && terraform init

apply:
	@cd terraform && terraform apply -var-file="secrets.auto.tfvars"

destroy:
	@cd terraform && terraform destroy -var-file="secrets.auto.tfvars"

encrypt_vault:
	@cd ansible && make encrypt_vault

decrypt_vault:
	@cd ansible && make decrypt_vault

edit_vault:
	@cd ansible && make edit_vault

view_vault:
	@cd ansible && make view_vault

install-roles:
	@cd ansible && make install-roles

deploy-droplets:
	@cd ansible && make deploy-droplets

pull-image:
	@cd ansible && make pull-image

run-container:
	@cd ansible && make run-container

configure_datadog:
	@cd ansible && make configure_datadog
