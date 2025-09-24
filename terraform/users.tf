resource "minio_iam_user" "users" {
  for_each = toset([
    "loki-user",
    "mimir-user"
  ])
  name = each.value
}
