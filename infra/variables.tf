variable "resource_group_name" {
  type    = string
  default = "hedgehog-lab-test-rg"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "app_name" {
  type    = string
  default = "hedgehoglabtest"
}

variable "db_name" {
  type    = string
  default = "hedgehoglabdb"
}

variable "db_admin" {
  type    = string
  default = "pgadmin"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "repo_url" {
  type = string
  default = "https://github.com/JohnWillisUK/Hedgehog-Lab-Test"
}
