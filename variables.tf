variable "hostFilterQuery" {
  type    = string
  default = "fetch dt.entity.host, from: now() - 3d \n| filter contains(toString(tags), \"Application:easytravel\")"
}

variable "enableTime" {
  type    = string
  default = "08:00"
}

variable "disableTime" {
  type    = string
  default = "23:55"
}

variable "startDate" {
  type    = string
  default = "2024-08-29"
}

variable "dt_owner" {
  type        = string
  default     = "########-####-####-####-############"
  description = "Account Management > Idenitity and access management > People, is the code below the user name"
}

variable "dt_env_url" {}

variable "dt_api_token" {}

variable "automation_client_id" {}

variable "automation_client_secret" {}
