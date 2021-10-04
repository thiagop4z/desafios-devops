#!/bin/bash

wget https://github.com/thiagop4z/desafios-devops/archive/refs/heads/master.zip && unzip master.zip &&
cd desafios-devops-master/kubernetes/ && eval $(minikube docker-env) && docker build -t idwall:1.0 . &&
kubectl apply -f idwall.yaml && sudo -- sh -c "echo '$(minikube ip) idwall.cc' >> /etc/hosts" &&
sleep 10s && curl idwall.cc:31000

#sudo apt install unzip -y \

#curl $(minikube service --url idwall)
