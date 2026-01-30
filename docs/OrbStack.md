### [⬅ Back](../README.md)

# [Orb Stack](https://orbstack.local/)

> OrbStack  is a drop-in replacement for Docker Desktop that's fast, light, and easy way to run Docker containers and Linux. Develop at lightspeed with our Docker Desktop alternative.

- Mac Only
- Faster & Battery Friendly ( built on Swift, Go, Rust, ... )
- GUI ( w/ docker & cli built in )
- Run docker, kubernetes, and linux vm's
- [Feature Comparison](https://docs.orbstack.local/compare/docker-desktop#feature-comparison)

This is a _better_ alternative to `docker desktop` that should use less resources and give the benifit of automagic SSL certs.

### Alternatives

> This gain popularity/addoption over the last year.

- [Docker Desktop](https://github.com/louislam/dockge)
- [Podman](https://podman-desktop.io/)
- [Rancher](https://rancherdesktop.io/)
- [Colima](https://github.com/abiosoft/colima)

### SSL

> Automagic SSL certs is created by using domain name `orb.local`

- [HTTPS for containers](https://docs.orbstack.local/features/https)

### Labels

Orb stack is monitoring/listening to the _docker.sock_ for services available. It will check the labels on containers to determine setup.


```yaml
# We will use ${service} to represent a NGINX service

# Ex: .env.${service} => .env.nginx
SERVICE_IMAGE: lscr.io/linuxserver/nginx:latest
SERVICE_NAME: nginx
SERVICE_PORT_FORWARD: nginx
SERVICE_PORT:
# Specific Variables
PUID=1000
PGID=1000
TZ=Americas/Los_Angeles
NGINX_AUTORELOAD=true # Optional

# Ex: docker-${service}-compose.yaml
service;
  nginx:
    image:
    hostname:
    container_name:
    ...
    labels:
  # Orb Stack
  - dev.orbstack.domains=${API_NAME}.orb.local
  - dev.orbstack.http-port=${WEB_SERVICE_PORT}

```

### Default Naming Structure for Domain

```yaml
# ~/nextbigthing/docker-compose.yaml
services:
  api:
    - setup data
  database:
    - setup data
```

For example, a project named _nextbigthing_ with services _api_ and _database_ would have the following domains:

api.nextbigthing.orb.local
database.nextbigthing.orb.local

### Create Unique Names for Domain

```yaml
# ~/nextbigthing/docker-compose.yaml
services:
  api:
    - ... setup data ...
    labels:
    # Orb Stack
      - dev.orbstack.domains=api.orb.local # ${API_NAME}.orb.local
  database:
    - ... setup data ...
    labels:
    # Orb Stack
      - dev.orbstack.domains=api.orb.local # ${DATABASE_NAME}.orb.local
```

### Multiple Domains

```yaml
services:
  nginx:
    image: nginx
    labels:
      - dev.orbstack.domains=foo.local,bar.local
```

# Ports
Unlike localhost, there's no need to use port numbers when connecting to web services by domain. Web server ports are detected automatically.

You can still use ports when referring to other services, e.g. database.stack.orb.local:5432 for Postgres.

### Override Port ( HTTP & HTTPS )
In some cases, if your container has multiple servers, OrbStack may not be able to detect the correct port. To fix this, use a label to specify a port explicitly: `dev.orbstack.http-port=8080`

If you want to run your own HTTPS server without using our proxy, listen on port 443 or 8443.
Alternatively, you can use the https-port label to redirect port 443 to any port:

```yaml
services:
  nginx:
    image: nginx
    ports:
      - "8080:80"
      - "9000:81"
      - "6678:443"
    labels:
      - dev.orbstack.domains=nginx.orb.local
      - dev.orbstack.http-port=80
      - dev.orbstack.https-port=443
```



