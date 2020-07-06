
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

/*Policy Creation */

resource "vault_policy" "ns_policies" {
  provider    = vault.my_namespace
  for_each = var.policies
  name   = each.key
  policy = each.value
}

/* Namespace internal groups linked to LDAP */
resource "vault_identity_group" "internal" {
  provider    = vault.my_namespace
  for_each = var.int_groups
  name = each.key
  member_group_ids = [ each.value ]
  type     = "internal"
}
resource "vault_identity_group_policies" "pols" {
  for_each = var.policy_map
  policies = [ each.key ]
  group_id = each.value
  exclusive = true
}
