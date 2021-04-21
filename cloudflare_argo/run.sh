#!/usr/bin/env bashio

cat $(bashio::config 'credential_file_content') > /etc/cloudflared/credentials.json
cat $(bashio::config 'config_file_content') > /etc/cloudflared/config.yml
echo "\ncredentials-file: /etc/cloudflared/credentials.json\n" >> /etc/cloudflared/config.yml

bashio::log.info "Running cloudflare tunnel..."

cloudflared tunnel run --force