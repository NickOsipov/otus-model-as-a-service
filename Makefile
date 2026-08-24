-include .env

start_server:
	uvicorn src.app:app --reload --port 8890

test:
	echo "Running tests"

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

push:
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(DOCKER_HUB_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(DOCKER_HUB_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

deploy-cm:
	kubectl apply -f k8s/configmap.yaml

deploy:
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/service.yaml
	kubectl apply -f k8s/ingress.yaml

ingress-install:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm install ingress-nginx ingress-nginx/ingress-nginx \
		--namespace ingress-nginx \
		--create-namespace \
		--set controller.replicaCount=1 \
		--set controller.nodeSelector."kubernetes\.io/os"=linux \
		--set controller.admissionWebhooks.enabled=false \
		--set controller.service.type=LoadBalancer
