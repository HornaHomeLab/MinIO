resource "minio_iam_service_account" "accounts" {
  for_each = minio_iam_user.users
  target_user = each.value.name
}