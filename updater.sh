#!/bin/sh

ROOT_HINTS_URL="https://www.internic.net/domain/named.cache"
ROOT_HINTS_FILE="/etc/unbound/root.hints"

echo "Downloading root hints file..."
wget -O "$ROOT_HINTS_FILE" "$ROOT_HINTS_URL"

if [ $? -eq 0 ]; then
  echo "Root hints file downloaded successfully to $ROOT_HINTS_FILE."
else
  echo "Failed to download root hints file." >&2
  exit 1
fi

echo "Reloading unbound..."
unbound-control reload

if [ $? -eq 0 ]; then
  echo "Unbound reloaded successfully."
else
  echo "Failed to reload unbound." >&2
  exit 1
fi