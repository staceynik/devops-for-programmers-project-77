provider "random" {}
provider "digitalocean" {
  token = var.do_token
}
