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
variable "ns_group_name" {
  description = "The name the LDAP group will be added to"
  type = string
  default = ""
}
variable "ext_group_id" {
  description = "The id of the external group to be added to the namespace group"
  type = string
  default = ""
}
