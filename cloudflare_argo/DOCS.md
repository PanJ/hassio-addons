# Cloudflare Argo Home Assistant Add-on

## Configuration

1. Setup Cloudflare Tunnel as indicated [here](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup)
2. If the tunnel is created successfully, there will be a file in `~/.cloudflared/{UUID}.json`
3. Create Cloudflare DNS CNAME record pointing `{hostname}` to `{UUID}.cfargotunnel.com`
4. Create tunnel config file named `config.yml`. For example,

```yml
tunnel: { UUID }
credentials-file: /etc/cloudflared/credentials.json
ingress:
  - hostname: { hostname }
    service: http://127.0.0.1:8123
  - service: http_status:404
```

5. Convert `config.yml` to base64 using command `cat config.yml | base64`
6. Copy content from `{UUID}.json` and above base64 string to add-on config
