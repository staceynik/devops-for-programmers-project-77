TF_VARS_FILE_TERRAFORM = "secrets.auto.tfvars"

.PHONY: init apply destroy

init:
	@cd terraform && terraform init

apply:
	cd terraform && terraform apply -var-file=$(TF_VARS_FILE_TERRAFORM)

destroy:
	@cd terraform && terraform destroy -var-file=$(TF_VARS_FILE_TERRAFORM)

ansible-deploy:
	@ansible-playbook -i ansible/inventory -e "TF_VARS_FILE_TERRAFORM=$(TF_VARS_FILE_TERRAFORM)" ansible/playbook.yml
