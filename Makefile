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

remove-docker-containers:
	@ansible-playbook -i ansible/inventory.ini --user=root ansible/remove_docker.yml --tags remove_docker_containers

remove-docker-images:
	@ansible-playbook -i ansible/inventory.ini --user=root ansible/remove_docker.yml --tags remove_docker_images

destroy:
	@cd terraform && terraform destroy -var-file=$(TF_VARS_FILE_TERRAFORM)
