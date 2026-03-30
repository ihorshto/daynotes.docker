#!/bin/sh

echo "Waiting for ngrok to be ready..."
until curl -sf http://daynotes.ngrok:4040/api/tunnels | grep -q "public_url"; do
  echo "ngrok not ready, retrying in 2s..."
  sleep 2
done

NGROK_URL=$(curl -s http://daynotes.ngrok:4040/api/tunnels \
  | grep -o '"public_url":"https:[^"]*' \
  | head -n1 \
  | cut -d'"' -f4)

echo "Setting Telegram webhook: $NGROK_URL/api/telegram/webhook"

RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/setWebhook" \
  -H "Content-Type: application/json" \
  -d "{\"url\": \"$NGROK_URL/api/telegram/webhook\", \"drop_pending_updates\": true}")

echo "$RESPONSE"

sleep infinity