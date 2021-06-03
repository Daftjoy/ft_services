#!/bin/sh
minikube delete;
minikube --vm-driver=virtualbox start
eval $(minikube docker-env)
minikube addons enable metallb
minikube addons enable metrics-server
minikube addons enable dashboard
kubectl apply -f srcs/metallb.yaml >/dev/null
minikube dashboard &
minikube service list  

docker build -t nginx srcs/nginx >/dev/null 
docker build -t wordpress srcs/wordpress >/dev/null 
docker build -t mysql srcs/mysql >/dev/null 
docker build -t phpmyadmin srcs/phpmyadmin >/dev/null
docker build -t grafana srcs/grafana >/dev/null
docker build -t influxdb srcs/influxdb  >/dev/null
docker build -t telegraf srcs/telegraf >/dev/null
docker build -t ftps srcs/ftps  >/dev/null

kubectl apply -f srcs/volumes.yaml >/dev/null 
kubectl apply -f srcs/nginx.yaml >/dev/null 
kubectl apply -f srcs/wordpress.yaml >/dev/null 
kubectl apply -f srcs/phpmyadmin.yaml >/dev/null 
kubectl apply -f srcs/mysql.yaml >/dev/null
kubectl apply -f srcs/grafana-config.yaml >/dev/null 
kubectl apply -f srcs/grafana.yaml >/dev/null
kubectl apply -f srcs/influxdb.yaml >/dev/null
kubectl apply -f srcs/telegraf-config.yaml >/dev/null   
kubectl apply -f srcs/telegraf.yaml >/dev/null   
kubectl apply -f srcs/ftps.yaml >/dev/null 
