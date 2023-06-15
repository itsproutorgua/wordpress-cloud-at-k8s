
#!/bin/bash

external_ip="$1"
WEBHOOK_URL="http://$external_ip/hooks"

response=$(gh api repos/$REPO/hooks)

if [ "$response" = "[]" ]; then
  create_response=$(gh api repos/$REPO/hooks --input - <<< '{
    "name": "web",
    "active": true,
    "events": [
      "push"
    ],
    "config": {
      "url": "'$WEBHOOK_URL'",
      "content_type": "json"
    }
  }')

  echo "Webhook created: $create_response"
else
  echo "Webhook already exists"
fi
