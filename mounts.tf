/* Authentication backends */

resource "vault_auth_backend" "userpass" {
  count         = (var.use_userpass ? 1 : 0)
  depends_on    = [vault_namespace.my_namespace]
  provider      = vault.my_namespace
  type          = "userpass"
  path          = var.up_path
  tune {
    default_lease_ttl = var.up_lease_ttl
  }
}

/* Secrets backends */
resource "vault_mount" "kv" {
  count         = (var.use_kv ? 1 : 0)
  depends_on    = [vault_namespace.my_namespace]
  provider      = vault.my_namespace
  path          = var.kv_path
  type          = "kv"
}

resource "vault_auth_backend" "approle" {
  count         = (var.use_approle ? 1 : 0)
  depends_on    = [vault_namespace.my_namespace]
  provider      = vault.my_namespace
  type          = "approle"
  path          = var.approle_path
}

resource "vault_approle_auth_backend_role" "example" {
  count                   = (var.use_approle ? 1 : 0)
  backend                 = vault_auth_backend.approle.path
  role_name               = var.my_role_name
  token_policies          = var.token_policies
  secret_id_bound_cidrs   = var.secret_id_bound_cidrs
  token_bound_cidrs       = var.token_bound_cidrs
  token_ttl               = var.token_ttl
  token_max_ttl           = var.token_max_ttl
}
