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

### Example usage

```hcl
module "ns1_namespace" {
  source = "github.com/iainthegray/vault_namespace_poc?ref=v1.0"
  token = var.token
  namespace_name = "my_shiny_new_namespace"
  vault_addr = "http://my_vault_addr.bob"
  kv_path = "my_secrets"
  use_userpass = false
  use_kv = true
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
- up_path         = (userpass) path to mount auth engine
- up_lease_ttl    = (600m) Default lease time for auth mount
- kv_path         = (kv) path to mount my_secrets engine
