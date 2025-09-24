variable "vault_address" {
  description = "Vault Address"
  default     = "https://vault.horna.local"
  
}
variable "vault_role_id" {
  sensitive   = true
  description = "Vault Role ID"
  default = null
}
variable "vault_secret_id" {
  sensitive   = true
  description = "Vault Role Secret"
  default = null
}