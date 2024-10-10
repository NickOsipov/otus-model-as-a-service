start_server:
	uvicorn src.app:app --reload --port 8890

test:
	echo "Running tests"

run_jupyter:
	docker build -t otus-model-as-a-service:jupyter -f Dockerfile.jupyter .
	docker stop otus-maas-jupyter || true
	docker run \
		--rm \
		-p 8888:8888 \
		-d \
		-v .:/app \
		--name otus-maas-jupyter \
		otus-model-as-a-service:jupyter

run:
	docker build -t otus-model-as-a-service:simple .
	docker run --rm --name otus-maas-simple otus-model-as-a-service:simple

up:
	docker-compose down
	docker-compose up -d --build

up_prod:
	docker-compose -f docker-compose.prod.yml down
	docker-compose -f docker-compose.prod.yml up -d --build

run_prod:
	docker build -t otus-model-as-a-service:prod -f Dockerfile.prod .
	docker stop otus-maas-prod || true
	docker run --rm -p 8890:8890 --name otus-maas-prod otus-model-as-a-service:prod