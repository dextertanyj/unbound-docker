#!/bin/sh

PORT=53

echo "Checking if port $PORT is open..."
PORT_COUNT="$(netstat -ln | grep -c ":$PORT")" &> /dev/null

if [ $PORT_COUNT -gt 0 ]; then
  echo "Port $PORT is open"
else
  echo "Port $PORT is closed"
  exit 1
fi

HEALTHCHECK_DOMAIN="example.com"

echo "Checking if domain '$HEALTHCHECK_DOMAIN' can be resolved..."
IP="$(drill -Q -p $PORT $HEALTHCHECK_DOMAIN @127.0.0.1)" &> /dev/null

if [ $? -eq 0 ]; then
  echo "Domain '$HEALTHCHECK_DOMAIN' resolved to '$IP'"
else
  echo "Domain '$HEALTHCHECK_DOMAIN' cannot be resolved"
  exit 1 
fi