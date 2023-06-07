# syntax=docker/dockerfile:1.4
FROM node:18.16.0-bullseye-slim as dev

WORKDIR /app

ENV NODE_ENV="development"
ENV NODE_OPTIONS=--max-old-space-size=8192

RUN : \
	&& apt-get -y update \
	&& apt-get install -y --no-install-recommends git \
	;

RUN corepack enable && corepack prepare
# pnpm fetch does require only lockfile
COPY pnpm-lock.yaml .
# More detail: https://pnpm.io/cli/fetch
RUN pnpm fetch

COPY . .

RUN pnpm install --recursive --offline --frozen-lockfile

########################## BUILD STAGE ##########################
FROM dev as build

WORKDIR /app

ENV NODE_OPTIONS=--max-old-space-size=8192
ENV NODE_ENV="production"

RUN corepack enable && corepack prepare

COPY --from=dev /app/pnpm-lock.yaml ./
RUN pnpm fetch --prod

COPY --from=dev /app/package.json /app/dist ./

RUN pnpm install --recursive --offline --frozen-lockfile --prod

RUN npm_config_workspace_concurrency=1 pnpm run build

########################## PRODUCTION STAGE ######################
FROM gcr.io/distroless/nodejs18-debian11:latest as prod

WORKDIR /app

COPY --from=builder --chown=node:node /app/dist /app/dist

EXPOSE 3000

CMD ["dist/start.js"]
