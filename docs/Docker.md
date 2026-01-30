### [⬅ Back](../README.md)

# [Docker](https://www.docker.com/)

Docker helps developers build, share, run, and verify applications anywhere — without tedious environment configuration or management.

### Docker Applications/Recommendations

- [Self Host](https://selfh.st)

### What is Docker

Containers ->

### What is Kubernetes (K8s)

Kubernetes is a open source system that can automate the process of deploying new application versions and scaling applications up or down based on demand or resource utilization.

> Idea is when your service is running out of memory or being overwhelmed, you can spin up another instance of it to alleviate load. You would then kill containers when stress is removed off of the service.

Benefits: Self-healing, Load balancing, Service discovery, Resource management, Rolling updates and rollbacks.

Alternatives:
- [Docker Swarm](https://docs.docker.com/engine/swarm/)
- [Amazon Elastic Compute Cloud](https://aws.amazon.com/marketplace/pp/prodview-voru33wi6xs7k?sr=0-1&ref_=beagle&applicationId=AWSMPContessa)
- [Google Cloud Platform](https://cloud.google.com/)
- [Azure Kubernetes Service](https://azure.microsoft.com/en-us/products/kubernetes-service)
...


### Create a Image

Sometimes you will want to create an Image, but you should know why and the benefits.

Usually there isn't something existing or it is bloated and you want to slim it down.

Below is an Example just showing how you could build a Image for `Node` and possibly add build steps to add specific commands or remove excess code for your final build.

Lets say you want a tool or dev-dependency for local, but do NOT want them on your final production build. This is trying to show how you can have build step based on the ENV

- Create a BaseBuild ( starting point )
- Add some helper scripts for Local Development
- Remove them from Production build

```
ARG IMAGE=arm64v8/node
ARG TAG=23-alpine

# Stage 1 - BaseBuild
FROM ${IMAGE}:${TAG} AS builder
WORKDIR /data
RUN set -eux & apk add --no-cache yarn
CMD [".", ".scripts/dockerAliases.sh"]

# Stage 2 - Develop
FROM builder AS develop
WORKDIR /data
COPY . .
CMD ["yarn", "start"]
EXPOSE 3000

# # Stage 3 - QA/Production
# FROM arm64v8/node:23-alpine
# WORKDIR /data
# COPY --from=dev data/.next ./
# COPY package.json ./
# RUN yarn install --only=production
# EXPOSE 3000
# CMD ["node", "build/server/index.js"]
```

### Image File and Tags



So generally you are going to create a service you will need a image to use. You can create your own image or service, but why do the work.

```
// Create your own File => dockerfile



```

For an example lets say we want to create a `nginx` service
Devs will normally just google search for `docker nginx image`
You should understand who is publishing the image, is forked, what changes were made, is the distributor well known or some random person.

recommendation is to check
- [Linux Server](https://docs.linuxserver.io/images/docker-nginx/)
- [Docker Hub](https://hub.docker.com/) try to find original distribution

### What is the difference between tags "Alpine," "Bookworm," and "Bullseye"

`

You will come across TAGS saying `23-alpine`, but what does it mean.

Simple answer is Version of the service and based on Debian Version

> Debian is a well reputed Linux distribution that started in the 90s. Different debian versions are released every 2 years since 2005 with a specific codename taken from Toy Story characters: ex: Jessie, Stretch, Buster, etc...

There are many targets to choose from, but quick rundown
- _Alpine_ Linux, a lightweight, security-oriented Linux distribution
- _Bookworm_ provide a more traditional and fully-featured Linux environment compared to Alpine, based on Debian V12
- _Bullseye_ similar to Bookworm, Bullseye-based Docker images offer a comprehensive environment, but they are based on an older version of Debian V11


### Problems with NETWORKS on a Mac machine

Docker has multiple (network drivers)[https://docs.docker.com/engine/network/drivers/]:
- bridge | default network driver
- host | create unique network for containers
- overlay | connect multiple Docker daemons together and enable Swarm services and containers to communicate across node
- ipvlan | assign IPv4 and IPv6
- macvlan | assign mac address
- none | can NOT communicate with internet or other machines

 > Docker on macOS runs containers inside a lightweight Linux virtual machine (VM), there are significant networking differences and limitations compared to running Docker natively on a Linux host

- No docker0 bridge on the host ( mac )
- Macvlan and IPvlan drivers not supported

> So how do we work around this? Port assignment/publish

You might run a command like: `docker run -p 8080:80`

What it is doing is exposing your machine ( mac ) to map back to the container

**Reason you will get the error, port in use**

You can only expose one service on a port

Now you can navigate to your browser `http://localhost:8080`

### ENV Files and Setup

> There is NO right or wrongs, but here are some ways to simplify things

Create one or multiple `.env` files to store all data, so you have to edit one place or one way.


I have created a simple folder project `TryExample` to give a simple use case.
```
// Ex: .env.nginx
NGINX_IMAGE: lscr.io/linuxserver/nginx:latest # Image to build
NGINX_NAME: nginx # Simple name
NGINX_PORT: 8080 # Container Port
NGINX_PORT_FORWARD: 80 # Computer Port

# Specific Variables
PUID=1000
PGID=1000
TZ=Americas/Los_Angeles
AUTORELOAD=true # Optional

// Ex: docker-nginx-compose.yaml
service:
  nginx:
    image: ${NGINX_IMAGE}
    hostname: ${NGINX_NAME}
    container_name: ${NGINX_NAME}
    networks:
      - ${NGINX_NAME}
    ports:
      - "${NGINX_PORT_FORWARD}:${NGINX_PORT}"
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TZ}
      - NGINX_AUTORELOAD=${AUTORELOAD}

networks:
  ${NGINX_NAME}:
    name: ${NGINX_NAME}
```

# Inspect Network

> docker inspect traefik -f "{{json .NetworkSettings.Networks }}"

# All Services

> docker compose config --services
