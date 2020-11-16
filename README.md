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

4. Service Discovery
application.properties

message.service.url=http://message-service-svc.default.svc.cluster.local:8082/message-service
#amazon.dynamodb.endpoint=http://172.17.0.7:8000/
amazon.dynamodb.endpoint=http://dynamo-svc.default.svc.cluster.local:8000/

command to find the values of these URLs

kubectl exec -it message-service-d85f5d84-rpj6t /bin/sh

/opt/app # nslookup flight-service-svc

nslookup: can't resolve '(null)': Name does not resolve

Name:      flight-service-svc
Address 1: 10.96.219.165 flight-service-svc.default.svc.cluster.local

/opt/app # nslookup dynamo-svc

nslookup: can't resolve '(null)': Name does not resolve

Name:      dynamo-svc
Address 1: 10.96.89.196 dynamo-svc.default.svc.cluster.local

5. Payloads:

POST: http://localhost:8081/flight-service/add
Accept: application/json
Content-Type: application/json

Body:
{
    "id":"6",
    "flightId":6,
    "airlinesName":"air india",
    "destinationName":"nagpur",
    "boardingName":"rajkot"
}

POST: http://localhost:8081/flight-service/booking
Accept: application/json
Content-Type: application/json

Body:
{
    "id":"6",
    "flightId":6,
    "airlinesName":"air india",
    "destinationName":"nagpur",
    "boardingName":"rajkot"
}

Response:
{
    "flight": {
        "id": "6",
        "flightId": 6,
        "airlinesName": "air india",
        "destinationName": "nagpur",
        "boardingName": "rajkot"
    },
    "message": "SUCCESS",
    "hostName": "flight-service-67684f5d7c-htrmn is running on this IP null in the namespace 172.18.0.8"
}

GET: http://localhost:8081/flight-service/flights
Content-Type: application/json

Response:
{
    "flights": [
        {
            "id": "5",
            "flightId": 5,
            "airlinesName": "indigo",
            "destinationName": "mumbai",
            "boardingName": "rajkot"
        },
        {
            "id": "2",
            "flightId": 2,
            "airlinesName": "vistara",
            "destinationName": "pune",
            "boardingName": "rajkot"
        }
    ],
    "hostName": "flight-service-67684f5d7c-htrmn is running on this IP null in the namespace 172.18.0.8"
}

POST:http://localhost:8082/message-service/publish-message
Accept: application/json
Content-Type: application/json

{  
      
        "emailId":       "azaveri7@gmail.com",   
        "flight": {
        	"flightId" : 1,
        	"airlinesName" : "INDIGO",
        	"destinationName" : "RAJKOT",
        	"boardingName" : "PUNE"
        } 
    
}
