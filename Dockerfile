# syntax=docker/dockerfile:1.4
FROM node:18.16.0-bullseye-slim as dev

WORKDIR /app

ENV NODE_OPTIONS=--max-old-space-size=8192

RUN corepack enable && corepack

COPY pnpm-lock.yaml .
RUN pnpm fetch

COPY . .

RUN pnpm install --recursive --offline --frozen-lockfile

RUN npm_config_workspace_concurrency=1 pnpm run build

# production stage
FROM gcr.io/distroless/nodejs18-debian11 as prod

USER node

WORKDIR /app

ENV \
	NODE_ENV="production" \
	NPM_CONFIG_UPDATE_NOTIFIER="false"

COPY --from=builder --chown=node:node /app/dist .

EXPOSE 3000

CMD ["node", "dist/start.js"]
