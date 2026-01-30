# Nerds Gummy Clusters

**WIP: Please use at your own risk. This is not complete. So do NOT blame me or anybody ( except yourself )!**

This repo is meant to setup a local environment for running ottoinfo.com locally

### Setup Still Required

- [] Fix `choose.sh`
- [] Create Backend Service
- [] Create Frontend Service
- [] Setup SSL Certs - USE .local or .local - Do we want a real cert ( letsencrypt )?
- [] Traefik Proxy
- [] Finish Docs

### Idea

- Create individual docker-${service}-compose.yaml for each service
- SymLink to original repos, no dependencies in repos
- Ability to overwrite ENV from this folder

### Docker Setup

The idea behind this setup is to be able to add resources easily and build out tools the developer wants to be available. Devs should create NEW _.md_ files with notes on the tool and purpose. Tools should not be _required_ to run the project, but things a dev can easily spin up.

### Knowledge - Markdown Documents

> Please feel free to add notes to the _docs_ folder. It will try to contain knowledge dumps about services and inform others. Developers like to be stingy about knowledge, do not be that `ASSHOLE`.

**Create Documents:** there should be an [`.Example.md`](./docs/.Example.md) file devs can _duplicate_ for a starting point.

### Setup

- [Local Setup](./docs/LocalSetup.md)

### Applications

- [Docker](./docs/Docker.md)
- [DockerHelp](./docs/DockerHelp.md)
- [OrbStack](./docs/OrbStack.md)
- [Portainer](./docs/Portainer.md)

### Main Services

- [Docker](./docs/Docker.md)
- [DockerHelp](./docs/DockerHelp.md)
- [OrbStack](./docs/OrbStack.md)
- [Portainer](./docs/Portainer.md)
- [Traefik](./docs/StartUp.md)

### Backend Services

### Frontend Services

### Additional Services ( optional\*\* )

- [Dozzle](./additonalServices/dozzle.md)
- [IT Tools](./additonalServices/it-tools.md)
- [Portainer](./additonalServices/Portainer.md)

### Try Creating a Services ( optional\*\* )

- [Try Example Service](./TryExample/README.md)
