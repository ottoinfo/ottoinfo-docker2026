### [⬅ Back](../README.md)

# [Secrets](https://docs.docker.com/compose/how-tos/use-secrets/)

> Simple way to build docker images with hidden secrets

### Create a file

touch ./secrets/cloudflare_dns_api_token.txt
echo "MyTokenValue" > ./secrets/cloudflare_dns_api_token.txt

### Traefik Credentials

**Note: In the file you do not NEED a `sed` parser**

touch ./secrets/traefik_dashboard_credentials.txt
echo $(htpasswd -nb -B admin "localdev1234") > ./secrets/traefik_dashboard_credentials.txt

### Issue w/ Restart/Rebuild option

- I do NOT currently see a `--force-rebuild` option, so I will normally need to run manual command

```code
# in Terminal go to service - Ex: > cd ~/Sites/do2026/additionalServices/portainer/
docker compose down && docker compose up --force-recreate -d
```
