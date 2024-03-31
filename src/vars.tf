variable "api_url" {
  default = "https://pve1.east.codemonkey.science:8006/api2/json"
}

variable "api_user" {
  type    = string
  default = null
}

variable "api_password" {
  type    = string
  default = null
}

variable "api_token_id" {
  type    = string
  default = null
}

variable "api_token_secret" {
  type    = string
  default = null
}

variable "ssh_private_key" {
  description = "SSH private key"
  type        = string
  sensitive   = true
}
