
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
