
/* Vault root provider */
provider "vault" {
  address = var.vault_addr
  token = var.token
  version = "~> 2.10"
}

/* The name of the namespace provided by the call to the module */
resource "vault_namespace" "my_namespace" {
  path = var.namespace_name
}

/* New namespace provider */
provider "vault" {
  address = var.vault_addr
  alias = "my_namespace"
  namespace = var.namespace_name
  token = var.token
}
/* Authentication backends */

resource "vault_auth_backend" "userpass" {
  count = (var.use_userpass ? 1 : 0)
  depends_on = [vault_namespace.my_namespace]
  provider = vault.my_namespace
  type       = "userpass"
  path       = var.up_path
  tune {
    default_lease_ttl = var.up_lease_ttl
  }
}

/* Secrets backends */
resource "vault_mount" "kv" {
  count = (var.use_kv ? 1 : 0)
  depends_on  = [vault_namespace.my_namespace]
  provider    = vault.my_namespace
  path        = var.kv_path
  type        = "kv"
}

/*Policy Creation
This is based on the use_policy variable */

resource "vault_policy" "ns_policies" {
  provider    = vault.my_namespace
  for_each = var.policies
  name   = each.key
  policy = each.value
}

/* Namespace LDAP
This is set up based on the use_ldap variable */
resource "vault_identity_group" "internal" {
  count = (var.use_ldap ? 1 : 0)
  provider    = vault.my_namespace
  name     = var.ns_group_name
  type     = "internal"
  member_group_ids = [var.ext_group_id]
  policies = keys(var.policies)
}
