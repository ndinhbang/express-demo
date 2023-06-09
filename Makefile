up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build --no-cache

clean:
	docker system prune

prod:
	docker compose -f docker-compose.prod.yml up -d --force-recreate --build
