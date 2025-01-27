web_server_start:
	uvicorn src.app:app --port 8000

build:
	docker build -t otus-maas-fastapi .

run:
	docker run --rm -d -p 8000:8000 --name otus-maas-fastapi otus-maas-fastapi

stop:
	docker stop otus-maas-fastapi

build-jupiter:
	docker build -t otus-maas-jupyter -f Dockerfile.jupyter .

run-jupiter:
	docker run --rm -d -p 8888:8888 --name otus-maas-jupyter otus-maas-jupyter

stop-jupiter:
	docker stop otus-maas-jupyter

up:
	docker-compose down
	docker-compose up -d --build

apply:
	cd infrastructure && terraform apply -auto-approve

destroy:
	cd infrastructure && terraform destroy -auto-approve

plan:
	cd infrastructure && terraform plan