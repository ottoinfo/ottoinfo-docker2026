### [⬅ Back](../../README.md)

# [Crowdsec](https://github.com/amir20/dozzle)
# [Traefik Docs](https://plugins.traefik.io/plugins/6335346ca4caa9ddeffda116/crowdsec-bouncer-traefik-plugin)
# [Bouncer](https://app.crowdsec.net/hub#bouncers)

- (Orb Local Service - dozzle.orb.local)(https://crowdsec.orb.local)
- (Traefik Local Service - crowdsec.ottoinfo.local)(https://crowdsec.ottoinfo.local)

# Check Logs

docker logs crowdsec

# Check Info
docker exec -it crowdsec cscli metrics
docker exec -it crowdsec cscli decisions list

# Add a Bouncer

docker exec crowdsec cscli bouncers add bouncer-traefik

# Manually add IP

docker compose up -d crowdsec
docker exec crowdsec cscli decisions add --ip 10.0.0.10 -d 10m # this will be effective 10min
docker exec crowdsec cscli decisions remove --ip 10.0.0.10
docker exec crowdsec cscli decisions add --ip 10.0.0.10 -d 10m -t captcha # this will return a captcha challenge
docker exec crowdsec cscli decisions remove --ip 10.0.0.10 -t captcha
