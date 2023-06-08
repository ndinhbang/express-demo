up:
	docker compose up -d

down:
	docker compose down

prod:
	docker compose -f docker-compose.prod.yml up -d --build
