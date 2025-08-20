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
	docker build -t otus-maas:0.0.1 -f Dockerfile.prod .

run-prod:
	docker run \
		--rm \
		--name otus-maas-prod \
		-p 8000:8000 \
		otus-maas:prod

push-prod:
	docker tag otus-maas:0.0.1 nickosipov/otus-maas:0.0.1
	docker push nickosipov/otus-maas:0.0.1

helm-install-ingress:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm install ingress-nginx ingress-nginx/ingress-nginx \
		--namespace ingress-nginx \
		--create-namespace \
		--set controller.replicaCount=1 \
		--set controller.nodeSelector."kubernetes\.io/os"=linux \
		--set controller.admissionWebhooks.enabled=false \
		--set controller.service.type=LoadBalancer

helm-uninstall-ingress:
	helm uninstall ingress-nginx -n ingress-nginx

helm-deploy:
	helm upgrade --install otus-maas helm/otus-maas \
		--namespace otus-maas \
		--create-namespace \
		--set image.tag=${IMAGE_TAG}

helm-destroy:
	helm uninstall otus-maas -n otus-maas
