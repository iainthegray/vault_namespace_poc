variable "vault_addr" {
  description = "The address of the Vault server"
  type = string
  default = "http://127.0.0.1:8200"
}

variable "token" {
  description = "The Vault token to be used"
  type = string
}

variable "namespace_name" {
  description = "The Vault namespace to be created"
  type = string
}
/* This section is the set of switches that determine which parts
of he module are used */
variable "use_userpass" {
  description = "a variable set to true or false to determine if a userpass auth method should be created"
  default = false
}
variable "use_kv" {
  description = "a variable set to true or false to determine if a kv secrets method should be created"
  default = false
}
variable "use_policy" {
  description = "a variable set to true or false to determine if policies should be created"
  default = false
}
variable "use_ldap" {
  description = "a variable set to true or false to determine if ldap groups should be created"
  default = false
}
/* Options that have sensible defaults. These are linked to the switches above */
variable "up_path" {
  description = "The path of the userpass auth engine"
  type = string
  default = "userpass"
}

variable "up_lease_ttl" {
  description = "a variable to set the default lease ttl for the userpass auth mount"
  default = "600m"
}

variable "kv_path" {
  description = "The path of the kv secrets engine"
  type = string
  default = "kv"
}
variable "policies" {
  description = "A map of policies to create in the namespace"
  type = map
  default = {
  }
}
/* LDAP Variables */
variable "int_groups" {
  description = "The name the LDAP groups to be added to int groups"
  type = map
  default = {"" = ""}
}
variable "policy_map" {
  description = "a mapping of the policy to internal groups"
  type = map
  default = {"" = ""}
}
