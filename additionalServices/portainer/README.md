### [⬅ Back](../../README.md)

# [Portainer](https://www.portainer.io/)

- (Orb Local Service - dozzle.orb.local)(https://dozzle.orb.local)
- (Traefik Local Service - dozzle.ottoinfo.local)(https://dozzle.ottoinfo.local)

### More Information

Go to the [docs/Portainer.md](../../docs/Portainer.md)

### Login Credentials

```
# "Username": "admin",
# "Password": "localdev1234", // Required 12 Characters | Can NOT override
# Docs - https://docs.portainer.io/advanced/cli
# We need to ESCAPE `$` => `$$` to translate correctly
# > htpasswd -nb -B admin "localdev1234" | cut -d ":" -f 2 | sed -e s/\\$/\\$\\$/g
```

### Entrypoint is Unavailable | No Shell Available

To get around the usage of using secrets and NOT using a entrypoint file we create 2 variables

```
# .env
# Use Docker Secrets or Fallback to PORTAINER_PASSWORD -> ${PORTAINER_PASSWORD_FILE:-PORTAINER_PASSWORD}
PORTAINER_PASSWORD_FILE=/run/secrets/portainer_password
# Portainer requires 12 characters ->  pw: 'localdev1234'
PORTAINER_PASSWORD="$$2y$$05$$oNTl/ND/ZUS0qSXn/NfJ9enRmrojst9r6DDmg8cjMtHCjJUFZCQyy"
```

In the compose yaml we use a fallback | use the secret file OR use the .env variable
```
# docker-compose.yam
environment:
  - PORTAINER_PASSWORD_FILE=${PORTAINER_PASSWORD_FILE:-PORTAINER_PASSWORD}
```
