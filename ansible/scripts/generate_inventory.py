import json
import os

# Получите текущий рабочий каталог
script_dir = os.getcwd()

# Путь к файлу состояния Terraform относительно текущего рабочего каталога
terraform_state_file = os.path.relpath(
    os.path.join('terraform', 'terraform.tfstate'), start=script_dir
)

# Путь к файлу inventory.ini относительно текущего рабочего каталога
inventory_file = os.path.relpath(
    os.path.join('ansible', 'inventory.ini'), start=script_dir
)

# Загрузите файл состояния Terraform
terraform_state = json.loads(open(terraform_state_file).read())

resources = terraform_state['resources']
unique_ips = set()  # Создаем множество для хранения уникальных IP-адресов

# Пройдемся по всем ресурсам и соберем уникальные IP-адреса
for resource in resources:
    if resource['type'] == 'digitalocean_droplet':
        for instance in resource['instances']:
            unique_ips.add(instance['attributes']['ipv4_address'])
    elif resource['type'] == 'digitalocean_database_cluster':
        for instance in resource['instances']:
            unique_ips.add(instance['attributes']['host'])
    elif resource['type'] == 'digitalocean_domain':
        for instance in resource['instances']:
            unique_ips.add(instance['attributes']['name'])
    elif resource['type'] == 'digitalocean_loadbalancer':
        for instance in resource['instances']:
            unique_ips.add(instance['attributes']['ip'])

# Создайте inventory.ini
with open(inventory_file, 'w') as f:
    for ip in unique_ips:
        f.write(f"host ansible_host={ip}\n")
