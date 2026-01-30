### [⬅ Back](../../README.md)

# [Traefik](https://doc.traefik.io/traefik/)

- (Orb Local Service - proxy.orb.local)(https://proxy.orb.local)
- (Traefik Local Service - proxy.ottoinfo.local)(https://proxy.ottoinfo.local)

### More Information

Go to the [docs/Traefik.md](../../docs/Traefik.md)

### Login Credentials

```
# "Username": "admin"
# "Password": "localdev1234"
# Docs - https://doc.traefik.io/traefik/reference/routing-configuration/http/middlewares/basicauth/
# We need to ESCAPE `$` => `$$` to translate correctly
# > htpasswd -nb -B admin "localdev1234" | cut -d ":" -f 2 | sed -e s/\\$/\\$\\$/g
```

### Entrypoint is Unavailable | No Shell Available

To get around the usage of using secrets and NOT using a entrypoint file we create 2 variables

```
# .env
# Use Docker Secrets or Fallback to PORTAINER_PASSWORD -> ${PORTAINER_PASSWORD_FILE:-PORTAINER_PASSWORD}
TRAEFIK_DASHBOARD_CREDENTIALS_FILE=/run/secrets/traefik_dashboard_credentials
TRAEFIK_DASHBOARD_CREDENTIALS=developer:$$2y$$05$$EvU774bUrCV1DxVpgYY2Iu0Df7MxUChAaCWSx2SrnUw5ZtDUuU6PC
```

In the compose yaml we use a fallback | use the secret file OR use the .env variable

```
# docker-compose.yam
environment:
  - PORTAINER_PASSWORD_FILE=${PORTAINER_PASSWORD_FILE:-$PORTAINER_PASSWORD}
```
