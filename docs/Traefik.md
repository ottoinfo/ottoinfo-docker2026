### [⬅ Back](../README.md)

# [Traefik](https://traefik.io/traefik)
# [Traefik Docs](https://doc.traefik.io/traefik/v3.0/)
> Traefik reverse proxying, load balancing, and service discovery...

### Alternatives

- [NGINX](hhttps://nginx.org/en/docs/http/ngx_http_proxy_module.html)
- [HAProxy](https://www.haproxy.org/)
- [Caddy](https://caddyserver.com/docs/)

### Why this Setup?

I did not like the idea of labels scattered in all of my compose files. I also liked the idea of being to add a service on the fly with dynamic yaml files. I have the ability to remove and routes, load balancers etc... manually and not have extra files/services created in traefik.

The ability to spin up new services or remove services by updating the YAML configuration files.

**NOTE**: When new ( non existing ) ENV's are added you still have to tear down and start up all services.

### What do you mean labels vs dynamic configuration

> This is PERSONAL preference and nothing to do with performance. I also thought this would help take out some of the auto-magic that labels accomplish ( better learning experience ). I should create a branch to demonstrate setup.

Idea:
- [ ] Create branch `feature/label_setup`

```yaml
# docker-compose.yaml
services:
  my-container:
    # ...
    labels:
      - traefik.http.routers.my-container.rule=Host(`example.com`)
      # Tell Traefik to use the port 12345 to connect to `my-container`
      - traefik.http.services.my-service.loadbalancer.server.port=12345
```

```yaml
# traefik-proxy/config/${ Random FILE name}.yaml
http:
  routers:
    my-container:
      rule: 'Host(`example.com`)'
      service: my-service

  services:
    my-service:
      loadBalancer:
        servers:
          port: 12345
```

### Gotchas w/ Dynamic Configuration

I did not find a way to solve this...

- Yaml file with bad formatting break all config's
- On development make sure to kill and restart services to track
- Priority attribute order Highest to Lowest. Meaning a fallback or main service should be at a lower level. `special.example.com` priority would be `10` and `example.com` priority would be lower value `5`. If reversed you would never be able to reach `special.example.com`.
