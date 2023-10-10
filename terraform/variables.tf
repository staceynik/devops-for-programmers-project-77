variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
  default     = ""
}

variable "app_key" {
  description = "Datadog App Key"
  type        = string
  default     = "YOUR_DEFAULT_APP_KEY_HERE"
}

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  default     = "YOUR_DIGITALOCEAN_API_TOKEN_HERE"
}

variable "db_password" {
  description = "Database Password"
  type        = string
  default     = "YOUR_DB_PASSWORD_HERE"
}

variable "db_username" {
  description = "Database Username"
  type        = string
  default     = "YOUR_DB_USERNAME_HERE"
}

