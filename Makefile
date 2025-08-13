build:
	docker build -t otus-maas:latest .

run-simple:
	docker run --rm --name otus-maas otus-maas:latest

run-it:
	docker run -it --rm --name otus-maas otus-maas:latest bash

run-exec:
	docker exec -it otus-maas bash

build-jupyter:
	docker build -f Dockerfile.jupyter -t otus-maas:jupyter .

run-jupyter:
	docker run --rm --name otus-maas-jupyter -p 8888:8888 otus-maas:jupyter

run-jupyter-with-volume:
	docker run --rm -p 8888:8888 -v ./notebooks:/app/notebooks --name otus-maas-jupyter otus-maas:jupyter

build-dev:
	docker build -t otus-maas:dev -f Dockerfile.dev .

run-dev:
	docker run \
		--rm \
		--name otus-maas-dev \
		-p 8000:8000 \
		-v ./src:/app/src \
		-v ./models:/app/models \
		otus-maas:dev

up:
	docker compose down || true
	docker compose up --build

build-prod:
	docker build -t otus-maas:prod -f Dockerfile.prod .

run-prod:
	docker run \
		--rm \
		--name otus-maas-prod \
		-p 8000:8000 \
		otus-maas:prod

push-prod:
	docker tag otus-maas:prod nickosipov/otus-maas:prod
	docker push nickosipov/otus-maas:prod