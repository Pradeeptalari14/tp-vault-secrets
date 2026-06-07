# Vault Enterprise Server configuration
storage "raft" {
  path    = "/vault/data"
  node_id = "node-1"
}
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"  # Set to false and supply certs in production
}
ui = true
disable_mlock = true
api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"