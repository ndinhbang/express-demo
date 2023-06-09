up:
	docker compose up -d --remove-orphans --force-recreate --build

down:
	docker compose down

build:
	docker compose build --no-cache

clean:
	docker system prune

dev:
	docker compose -f docker-compose.dev.yml up -d --remove-orphans
