resource "minio_iam_policy" "loki_access_policy" {
  name = "loki-access-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : "arn:aws:s3:::loki-data"
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:*Object",
        "Resource" : "arn:aws:s3:::loki-data/*"
      }
    ]
  })
}
resource "minio_iam_policy" "mimir_access_policy" {
  name = "mimir-access-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : "arn:aws:s3:::mimir-data"
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:*Object",
        "Resource" : "arn:aws:s3:::mimir-data/*"
      }
    ]
  })
}

resource "minio_iam_user_policy_attachment" "policy_attachment" {
  depends_on = [
    minio_iam_user.users,
    minio_iam_policy.loki_access_policy,
    minio_iam_policy.mimir_access_policy
  ]
  for_each = {
    "${minio_iam_user.users["loki-user"].name}"  = minio_iam_policy.loki_access_policy.name,
    "${minio_iam_user.users["mimir-user"].name}" = minio_iam_policy.mimir_access_policy.name,
  }
  user_name   = each.key
  policy_name = each.value
}
