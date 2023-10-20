provider "digitalocean" {
  token = var.do_token
}

provider "datadog" {
  api_key  = var.datadog_api_key
  app_key  = var.app_key
  validate = false
  api_url  = "https://api.datadoghq.eu/"
}
