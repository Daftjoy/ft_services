#!/bin/sh
minikube delete;
minikube --vm-driver=virtualbox start
eval $(minikube docker-env)
minikube addons enable metallb
minikube addons enable metrics-server
minikube addons enable dashboard
kubectl apply -f metallb.yaml
minikube dashboard &
minikube service list  
docker build -t nginx srcs/nginx >/dev/null 
docker build -t wordpress srcs/wordpress >/dev/null 
docker build -t mysql srcs/mysql >/dev/null 
docker build -t phpmyadmin srcs/phpmyadmin 

kubectl apply -f srcs/volumes.yaml >/dev/null 
kubectl apply -f srcs/nginx.yaml >/dev/null 
kubectl apply -f srcs/wordpress.yaml >/dev/null 
kubectl apply -f srcs/phpmyadmin.yaml >/dev/null 
kubectl apply -f srcs/mysql.yaml >/dev/null 