import json
import os

script_dir = os.getcwd()

terraform_state_file = os.path.relpath(
    os.path.join('terraform', 'terraform.tfstate'), start=script_dir
)

inventory_file = os.path.relpath(
    os.path.join('ansible', 'inventory.ini'), start=script_dir
)

terraform_state = json.loads(open(terraform_state_file).read())

resources = terraform_state['resources']
unique_ips_with_names = {}

host_groups = {
    'droplets': [],
    'load_balancer': [],
    'db': [],
    'domain': [],
}

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


for ip, name in unique_ips_with_names.items():
    if 'web-' in name and not name.startswith('web-lb'):
        host_groups['droplets'].append(f"{name} ansible_host={ip} ansible_user=root")  # Добавьте ansible_user=root
    elif 'web-lb' in name:
        host_groups['load_balancer'].append(f"{name} ansible_host={ip} ansible_user=root")  # Добавьте ansible_user=root
    elif 'my-database' in name:
        host_groups['db'].append(f"{name} ansible_host={ip} ansible_user=root")  # Добавьте ansible_user=root
    elif 'staceynik.store' in name:
        host_groups['domain'].append(f"{name} ansible_host={ip} ansible_user=root")  # Добавьте ansible_user=root


with open(inventory_file, 'w') as f:
    for group, hosts in host_groups.items():
        f.write(f"[{group}]\n")
        for host in hosts:
            f.write(f"{host}\n")
