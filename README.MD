# Vault Namespace Creation Terraform Module (POC)

This repo contains a very simple module for creating namespaces in Vault.

## Versions
This module was written using these versions:
-  terraform v0.12.24
-  vault provider v2.10.0
## Usage

A new namespace can be instantiated by calling the module. If you have more than one namespace inside a sate  file then simply call the module as many times as needed.

Currently there are only 2 mounts in the module:
- kv v1 secrets engine
- userpass auth mount

To determine what mounts you want in a namespace, simply set the required variables to true of false:
- use_userpass
- use_kv

Other mounts can be added to the module with the same logic

### LDAP Groups

The use of the 'use_ldap' variable allows creation of internal groups in the namespace and the addition of policies to them.

### Example usage

```hcl
module "avengers_namespace" {
  source = "github.com/iainthegray/vault_namespace_poc"
  token = var.token
  namespace_name = "avengers"
  vault_addr = var.vault_addr
  kv_path = var.kv_path
  use_kv = true
  use_policy = true
  policies = {
    "avengers_pol" = "${data.template_file.avengers_policy.rendered}"
    }
  use_ldap = true
  ns_group_name = "avengers"
  ext_group_id = vault_identity_group.avengers_group.id
}
```
## Variables

### Required
- vault_addr      = The address of the vault server api port
- token           = The vault token to use
- namespace_name  = The name for the new namespace

### Optional (with defaults)
- use_userpass    = (false) boolean to determine if a userpass auth mount is created
- use_kv          = (false) boolean to determine if a kv secrets engine is created
- use_ldap        = (false) boolean to determine if internal groups should be created
- use policy      = (false) boolean to add policies to the namespace and assign them to the internal group. This cannot be true if use_ldap is false
- policies        = This is a map of policy_name and the rendered policy template (or flat policy if you really want)
- up_path         = (userpass) path to mount auth engine
- up_lease_ttl    = (600m) Default lease time for auth mount
- kv_path         = (kv) path to mount my_secrets engine
