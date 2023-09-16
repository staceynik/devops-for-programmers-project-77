terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

resource "random_string" "suffix" {
  count   = 2
  length  = 6
  special = false
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "key" {
  name       = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_droplet" "web" {
  count = 2
  image  = "ubuntu-22-04-x64"
  name   = "web-${element(random_string.suffix.*.result, count.index)}"
  region = "ams3"
  size   = "s-2vcpu-4gb"

  ssh_keys = [digitalocean_ssh_key.key.id]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx

    apt-get install -y certbot python-certbot-nginx

    certbot --nginx --non-interactive --agree-tos -m your_email@example.com -d your_domain.com

    systemctl restart nginx
  EOF
}

resource "digitalocean_loadbalancer" "lb" {
  name   = "web-lb"
  region = "ams3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
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

resource "digitalocean_database_cluster" "my_db" {
  name        = "my-database"
  engine      = "pg"
  version     = "12"
  node_count  = 1
  size        = "db-s-1vcpu-2gb"
  region      = "ams3"
}
