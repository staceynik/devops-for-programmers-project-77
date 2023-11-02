.PHONY: setup init apply destroy terraform ansible encrypt_vault decrypt_vault edit_vault view_vault install-roles deploy-droplets pull-image run-container configure_datadog

setup:
	@make -C ansible setup

init:
	@make -C terraform init

apply:
	@make -C terraform apply

destroy:
	@make -C terraform destroy

encrypt_vault:
	@make -C ansible encrypt_vault

decrypt_vault:
	@make -C ansible decrypt_vault

edit_vault:
	@make -C ansible edit_vault

view_vault:
	@make -C ansible view_vault

install-roles:
	@make -C ansible install-roles

deploy-droplets:
	@make -C ansible deploy-droplets

pull-image:
	@make -C ansible pull-image

run-container:
	@make -C ansible run-container

configure_datadog:
	@make -C ansible configure_datadog
