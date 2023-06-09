# syntax=docker/dockerfile:1.4
FROM node:18.16.0-bullseye-slim as build

WORKDIR /app

ENV NODE_OPTIONS=--max-old-space-size=8192
ENV NODE_ENV="development"

RUN corepack enable && corepack prepare pnpm@8.5.1 --activate
# pnpm fetch does require only lockfile
COPY pnpm-lock.yaml .
# More detail: https://pnpm.io/cli/fetch
RUN pnpm fetch

COPY . .

RUN pnpm install --recursive --offline --frozen-lockfile

RUN : \
	&& npm_config_workspace_concurrency=1 pnpm build \
	&& rm -rf node_modules \
	&& pnpm install --recursive --offline --frozen-lockfile --prod \
	;

########################## PRODUCTION STAGE ######################
FROM gcr.io/distroless/nodejs18-debian11:latest as prod

WORKDIR /app

COPY --from=build --chown=node:node /app/package.json ./
COPY --from=build --chown=node:node /app/dist  ./dist
COPY --from=build --chown=node:node /app/node_modules ./node_modules

EXPOSE 3000

CMD ["./dist/start.js"]
