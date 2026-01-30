ARG IMAGE=${UI_IMAGE}
ARG TAG=${UI_IMAGE_VERSION}

# Stage 1 - BaseBuild
FROM ${IMAGE}:${TAG} AS builder
WORKDIR /data

# Stage 2 - Develop
FROM builder AS develop
WORKDIR /data
COPY . .
CMD /bin/bash -c /data/scripts/nodeStart.sh
EXPOSE 8300

# # Stage 3 - QA/Production
# FROM arm64v8/node:23-alpine
# WORKDIR /data
# COPY --from=dev data/.next ./
# COPY package.json ./
# RUN yarn install --only=production
# EXPOSE 3000
# CMD ["node", "build/server/index.js"]
