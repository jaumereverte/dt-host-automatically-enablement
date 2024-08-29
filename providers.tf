terraform {
  required_providers {
    dynatrace = {
      version = "~> 1.0"
      source  = "dynatrace-oss/dynatrace"
    }
  }
}

provider "dynatrace" {
  dt_env_url               = var.dt_env_url
  dt_api_token             = var.dt_api_token
  automation_client_id     = var.automation_client_id
  automation_client_secret = var.automation_client_secret
}
