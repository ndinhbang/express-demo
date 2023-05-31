FROM node:18.16.0-bullseye-slim

WORKDIR /app

ENV NODE_ENV=development
ENV NODE_OPTIONS=--max-old-space-size=8192

COPY package.json .
RUN corepack enable && corepack prepare

COPY pnpm-lock.yaml .
RUN pnpm fetch

COPY . .

RUN pnpm install --recursive --offline --frozen-lockfile

EXPOSE 3000

CMD : \
	&& pnpm run dev \
	;
