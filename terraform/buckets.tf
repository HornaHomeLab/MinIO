resource "minio_s3_bucket" "data_buckets" {
  for_each = toset([
    "loki-data",
    "mimir-data"
  ])
  bucket = each.value
}
