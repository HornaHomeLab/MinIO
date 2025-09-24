resource "vault_kv_secret_v2" "account_credentials" {
  for_each = minio_iam_user.users

  mount = "minio_accounts" 
  name = each.value.name
  data_json = jsonencode({
    access_key = minio_iam_service_account.accounts[each.value.name].access_key
    secret_key = minio_iam_service_account.accounts[each.value.name].secret_key
  })
}
