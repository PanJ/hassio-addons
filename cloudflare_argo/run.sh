#!/usr/bin/env bashio

echo $(bashio::config 'credential_file_content') > /etc/cloudflared/credentials.json
echo $(bashio::config 'config_file_content_base64') | base64 -d > /etc/cloudflared/config.yml
echo "\ncredentials-file: /etc/cloudflared/credentials.json\n" >> /etc/cloudflared/config.yml

bashio::log.info "Running cloudflare tunnel..."

cloudflared tunnel run --force