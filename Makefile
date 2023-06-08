up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build --no-cache

prod:
	docker compose -f docker-compose.prod.yml up -d --force-recreate --build
