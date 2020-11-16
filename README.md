# dynamodb

# minikube cheatsheet
https://minikube.sigs.k8s.io/docs/start/

# minikube windows 10 Pro commands needed
WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# to create minikube
minikube start --vm-driver=hyperv --cpus 4 --memory 4096

# projects included
message-service and flight-service

# Steps to run microservices

1. Run kubectl-deploy-local-dynamo in Kubernetes folder in dynamodb project. 
   This will setup dynamodb as a pod and expose it as service in minikube cluster.
   
2. Flight-service:
   gradle clean build
   Run scripts/docker-images.sh (This will create docker image and push it to docker hub)
   Run scripts/kubectl-deploy-local.sh (This will create pods and deployment)
   Run command:
     kubectl port-forward svc/flight-service-svc 8081:8081
   
3. Message-service:
   gradle clean build
   Run scripts/docker-images.sh (This will create docker image and push it to docker hub)
   Run scripts/kubectl-deploy.sh (This will create pods and deployment)
   Run command:
     kubectl port-forward svc/message-service-svc 8081:8081


