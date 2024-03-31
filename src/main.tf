terraform {
  required_providers {
    proxmox = {
      source  = "TheGameProfi/proxmox"
      version = "= 2.9.16"
      # version = "= 2.10.0" # BROKEN - leaves disk disconnected and orphaned
    }
  }

  cloud {
    organization = "codemonkey-science"

    workspaces {
      name = "Lab-Environment"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.api_url
  pm_user             = var.api_user
  pm_password         = var.api_password
  pm_api_token_id     = var.api_token_id
  pm_api_token_secret = var.api_token_secret
  pm_debug            = true
}