TF_VARS_FILE_TERRAFORM = "secrets.auto.tfvars"

.PHONY: init apply destroy

init:
	@terraform init

apply:
	@terraform apply -var-file=$(TF_VARS_FILE_TERRAFORM)

destroy:
	@terraform destroy -var-file=$(TF_VARS_FILE_TERRAFORM)
