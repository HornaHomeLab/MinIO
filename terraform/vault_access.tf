provider "vault" {
  address = var.vault_address

  # When role_id and secret_id are provided, authenticate using approle
  dynamic "auth_login" {
    for_each = (
      var.vault_role_id != null && var.vault_secret_id != null
    ) ? [1] : []

    content {
      path = "auth/approle/login"

      parameters = {
        role_id   = var.vault_role_id
        secret_id = var.vault_secret_id
      }
    }
  }

  # Otherwise, fall back to ~/.vault-token automatically
}

data "vault_generic_secret" "minio_creds" {
  path = "infrastructure/minio.prod.horna.local"
}
