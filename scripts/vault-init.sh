#!/usr/bin/env bash
set -euo pipefail
export VAULT_ADDR="http://localhost:8200"
echo "Initializing Vault Server..."
vault operator init -key-shares=1 -key-threshold=1 -format=json > keys.json
UNSEAL_KEY=$(jq -r ".unseal_keys_b564[0]" keys.json)
ROOT_TOKEN=$(jq -r ".root_token" keys.json)
echo "Unsealing Vault..."
vault operator unseal "$UNSEAL_KEY"
echo "Logging in to Vault..."
export VAULT_TOKEN="$ROOT_TOKEN"
echo "Enabling KV-v2 Secrets Engine..."
vault secrets enable -path=secret kv-v2
echo "Writing mock database credentials..."
vault kv put secret/production/database username="prod_db_user" password="SuperSecurePassword123!"
echo "Applying security policy..."
vault policy write app-readonly vault/policies/app-policy.hcl
echo "Enabling Kubernetes Auth Method..."
vault auth enable kubernetes
echo "Done!"