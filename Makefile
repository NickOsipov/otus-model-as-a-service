build:
	docker build -t otus-maas:latest .

run:
	docker run --rm --name otus-maas otus-maas:latest

build-jupyter:
	docker build -f Dockerfile.jupyter -t otus-maas:jupyter .

run-jupyter:
	docker run --rm --name otus-maas-jupyter otus-maas:jupyter

build-dev:
	docker build -f Dockerfile.dev -t otus-maas:dev .

run-dev:
	docker run --rm --name otus-maas-dev otus-maas:dev

sync-repo:
	rsync -avz \
		--exclude=.venv \
		--exclude=infra/.terraform \
		--exclude=*.tfstate \
		--exclude=*.backup \
		--exclude=*.json . yc-proxy:/home/ubuntu/otus/otus-model-as-a-service