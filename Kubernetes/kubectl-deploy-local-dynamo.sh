#!/usr/bin/env bash
kubectl delete -f db-pod.yaml
kubectl delete -f db-service.yaml
kubectl create -f db-pod.yaml
kubectl create -f db-service.yaml