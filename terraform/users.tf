resource "minio_iam_user" "users" {
  for_each = toset([
    "loki-user",
    "mimir-user",
    "tempo-user"
  ])
  name = each.value
}
