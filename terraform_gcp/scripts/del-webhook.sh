#!/bin/bash

response=$(gh api repos/$REPO/hooks)

if [ "$response" != "[]" ]; then
  for hook_id in $(echo "$response" | jq -r '.[].id'); do
    hook_response=$(gh api repos/$REPO/hooks/$hook_id)
    hook_name=$(echo "$hook_response" | jq -r '.name')
    hook_url=$(echo "$hook_response" | jq -r '.config.url')
    delete_response=$(gh api repos/$REPO/hooks/$hook_id -X DELETE)
    echo "Webhook deleted $delete_response"
  done
else
  echo "Webhook doesn't exist"
fi
