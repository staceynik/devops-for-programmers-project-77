TF_VARS_FILE_TERRAFORM = "secrets.auto.tfvars"

.PHONY: init apply destroy

init:
	@cd terraform && terraform init

apply:
	cd terraform && terraform apply -var-file="secrets.auto.tfvars"

destroy:
	@cd terraform && terraform destroy -var-file=$(TF_VARS_FILE_TERRAFORM)

install-ansible-roles:
	@ansible-galaxy install -r ansible/requirements.yml

ansible-deploy:
	@ansible-playbook -i ansible/inventory.ini -e "TF_VARS_FILE_TERRAFORM=$(TF_VARS_FILE_TERRAFORM)" ansible/playbook.yml

generate-inventory:
	python3 ~/devops-for-programmers-project-77/ansible/scripts/generate_inventory.py

deploy-droplets:
	@cd ansible && ansible-playbook -i inventory.ini -l droplets playbook.yml
