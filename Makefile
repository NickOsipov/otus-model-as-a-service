include .env

build-simple:
	docker build -t otus-maas:simple .

run-simple:
	docker run --rm --name otus-maas otus-maas:simple

build-jupyter:
	docker build -t otus-maas:jupyter -f Dockerfile.jupyter .

run-jupyter:
	docker run --rm -v ./notebooks:/app/notebooks -p 8888:8888 --name otus-maas-jupyter otus-maas:jupyter

build-dev:
	docker build -t otus-maas:dev -f Dockerfile.dev .

run-dev:
	docker run \
		--rm \
		-v ./models:/app/models \
		-v ./src:/app/src \
		-p 8000:8000 \
		--name otus-maas-dev \
		otus-maas:dev

build-prod:
	docker build -t otus-maas:prod -f Dockerfile.prod .

run-prod:
	docker run --rm -p 8000:8000 --name otus-maas-prod otus-maas:prod

push-prod:
	docker login -u $(DOCKER_HUB_USER) -p $(DOCKER_HUB_TOKEN)
	docker tag otus-maas:prod $(DOCKER_HUB_USER)/otus-maas:prod
	docker push $(DOCKER_HUB_USER)/otus-maas:prod