variable "vault_addr" {
  description = "The address of the Vault server"
  type = string
}

variable "token" {
  description = "The Vault token to be used"
  type = string
}

variable "namespace_name" {
  description = "The Vault namespace to be created"
  type = string
}

variable "use_userpass" {
  description = "a variable set to true or false to determine if a userpass auth method should be created"
  default = false
}

variable "up_path" {
  description = "The path of the userpass auth engine"
  type = string
  default = "userpass"
}

variable "up_lease_ttl" {
  description = "a variable to set the default lease ttl for the userpass auth mount"
  default = "600m"
}

variable "use_kv" {
  description = "a variable set to true or false to determine if a kv secrets method should be created"
  default = false
}

variable "kv_path" {
  description = "The path of the kv secrets engine"
  type = string
  default = "kv"
}
