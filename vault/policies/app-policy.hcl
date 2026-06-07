# Scoped application read-only policy
path "secret/data/production/app-creds" {
  capabilities = ["read"]
}
path "secret/data/production/database" {
  capabilities = ["read"]
}