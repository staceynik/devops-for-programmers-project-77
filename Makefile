.PHONY: setup init apply destroy install-roles deploy-droplets 

setup:
	@bash setup.sh

init:
	@make -C terraform init

apply:
	@make -C terraform apply

destroy:
	@make -C terraform destroy

install-roles:
	@make -C ansible install-roles

deploy-droplets:
	@make -C ansible deploy-droplets
