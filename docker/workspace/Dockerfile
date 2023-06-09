# syntax=docker/dockerfile:1.4
FROM node:18.16.0-bullseye-slim as dev

WORKDIR /app

ENV NODE_ENV="development"
ENV NODE_OPTIONS=--max-old-space-size=8192

RUN : \
	&& apt-get -y update \
	&& apt-get install -y --no-install-recommends \
	git \
	;

RUN corepack enable && corepack prepare pnpm@8.5.1 --activate
# pnpm fetch does require only lockfile
COPY pnpm-lock.yaml .
# More detail: https://pnpm.io/cli/fetch
RUN pnpm fetch

COPY . .

RUN pnpm install --recursive --frozen-lockfile

CMD ["pnpm", "dev"]
