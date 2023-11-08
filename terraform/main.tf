terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

output "database_password" {
  value     = digitalocean_database_cluster.my_db.password
  sensitive = true
}

data "digitalocean_ssh_key" "example_ssh_key" {
  name = "key"
}

resource "random_string" "suffix" {
  count   = 2
  length  = 6
  special = false
}

resource "digitalocean_droplet" "web" {
  count  = 2
  image  = "ubuntu-22-04-x64"
  name   = "web-${random_string.suffix[count.index].result}"
  region = "ams3"
  size   = "s-2vcpu-4gb"

  ssh_keys = [
    data.digitalocean_ssh_key.example_ssh_key.fingerprint,
  ]
}

resource "digitalocean_loadbalancer" "lb" {
  name   = "web-lb"
  region = "ams3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 3000
    target_protocol = "http"
  }

  healthcheck {
    port     = 3000
    protocol = "http"
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.web.*.id
}

resource "digitalocean_domain" "example_domain" {
  name = "staceynik.store"
}

resource "digitalocean_record" "lb_dns" {
  count = 2

  domain = digitalocean_domain.example_domain.name
  type   = "A"
  name   = "web-${count.index}"

  value = digitalocean_loadbalancer.lb.ip
}

resource "digitalocean_database_user" "my_db_user" {
  name       = var.db_username
  cluster_id = digitalocean_database_cluster.my_db.id
}

resource "digitalocean_database_cluster" "my_db" {
  name       = "my-database"
  engine     = "pg"
  version    = "12"
  size       = "db-s-1vcpu-2gb"
  region     = "ams3"
  node_count = 1
}

resource "local_file" "inventory" {
  filename = "../ansible/inventory.ini"
  content  = <<-EOT
[droplets]
${join("\n", [for instance in digitalocean_droplet.web : "${instance.name} ansible_host=${instance.ipv4_address} ansible_user=root"])}
  EOT
}

resource "local_file" "load_balancer" {
  filename = "../ansible/group_vars/droplets/load_balancer.yml"
  content  = <<-EOT
---
load_balancer:
  external_port: ${var.external_port}
  EOT
}


resource "local_file" "secrets" {
  filename = "../ansible/group_vars/droplets/secrets.yml"
  content  = <<-EOT
---
db:
  db_host: "${digitalocean_database_cluster.my_db.host}"
  db_password: "${digitalocean_database_cluster.my_db.password}"
  EOT
}

resource "datadog_monitor" "my_monitor" {
  name               = "Simple Monitor"
  type               = "service check"
  message            = "Test Service Check"
  escalation_message = "Test Service Check (Escalated)"

  query = "\"http.can_connect\".over(\"*\").by(\"*\").last(3).count_by_status()"

  monitor_thresholds {
    critical = 1
  }
}
