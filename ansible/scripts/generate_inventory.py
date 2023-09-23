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
unique_ips_with_names = {}  # Создаем словарь для хранения уникальных IP-адресов с их именами

# Пройдемся по всем ресурсам и соберем уникальные IP-адреса с их именами
for resource in resources:
    if resource['type'] == 'digitalocean_droplet':
        for instance in resource['instances']:
            name = instance['attributes']['name']
            ip = instance['attributes']['ipv4_address']
            unique_ips_with_names[ip] = name
    elif resource['type'] == 'digitalocean_database_cluster':
        for instance in resource['instances']:
            name = instance['attributes']['name']
            ip = instance['attributes']['host']
            unique_ips_with_names[ip] = name
    elif resource['type'] == 'digitalocean_domain':
        for instance in resource['instances']:
            name = instance['attributes']['name']
            unique_ips_with_names[name] = name
    elif resource['type'] == 'digitalocean_loadbalancer':
        for instance in resource['instances']:
            name = instance['attributes']['name']
            ip = instance['attributes']['ip']
            unique_ips_with_names[ip] = name

# Создайте inventory.ini
with open(inventory_file, 'w') as f:
    for ip, name in unique_ips_with_names.items():
        f.write(f"{name} ansible_host={ip}\n")
