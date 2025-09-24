terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = ">= 3.0.0"
    }
  }
}
provider "minio" {
  minio_server  = data.vault_generic_secret.minio_creds.data["url"]
  minio_user = data.vault_generic_secret.minio_creds.data["root-user"]
  minio_password = data.vault_generic_secret.minio_creds.data["root-password"]
}
terraform {
  backend "http" {
    address = "http://10.0.10.11:8001/state/Minio/prod"
  }
}
data "terraform_remote_state" "state" {
  backend = "http"
  config = {
    address = "http://10.0.10.11:8001/state/Minio/prod"
  }
}
