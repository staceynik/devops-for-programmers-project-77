TF_VARS_FILE_TERRAFORM = "secrets.auto.tfvars"

.PHONY: init apply destroy remove-docker-containers remove-docker-images generate-inventory install-ansible-roles deploy-droplets

init:
	@cd terraform && terraform init

apply:
	cd terraform && terraform apply -var-file="secrets.auto.tfvars"

generate-inventory:
	python3 ~/devops-for-programmers-project-77/ansible/scripts/generate_inventory.py

install-ansible-roles:
	@ansible-galaxy install -r ansible/requirements.yml

deploy-droplets:
	@ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml

pull-image:
	@ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml --tags pull_image

run-container:
	@ansible-playbook -i ansible/inventory.ini -l droplets --user=root ansible/playbook.yml --tags run_container

destroy:
	@cd terraform && terraform destroy -var-file=$(TF_VARS_FILE_TERRAFORM)
